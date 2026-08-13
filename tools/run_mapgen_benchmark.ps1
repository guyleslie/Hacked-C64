[CmdletBinding()]
param(
    [ValidateSet('cycles', 'checksum')]
    [string]$Mode = 'cycles',

    [switch]$LegacyRowOffsets,

    [switch]$LegacyRoomBounds,

    [string]$Oscar64 = 'E:\Apps\oscar64\bin\oscar64.exe',
    [string]$Vice = 'E:\Apps\GTK3VICE-3.9-win64\bin\x64sc.exe'
)

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$source = Join-Path $PSScriptRoot 'mapgen_benchmark.c'
$buildDir = Join-Path $repoRoot 'build'
$includeRoot = Join-Path $repoRoot 'main\src'
$mapgenInclude = Join-Path $includeRoot 'mapgen'

if (-not (Test-Path -LiteralPath $Oscar64)) {
    throw "OSCAR64 not found: $Oscar64"
}
if (-not (Test-Path -LiteralPath $Vice)) {
    throw "VICE not found: $Vice"
}
if (-not (Test-Path -LiteralPath $buildDir)) {
    New-Item -ItemType Directory -Path $buildDir | Out-Null
}

function Build-Benchmark {
    param(
        [string]$Name,
        [string[]]$Defines = @()
    )

    $output = Join-Path $buildDir "$Name.prg"
    $oscarRoot = Split-Path -Parent (Split-Path -Parent $Oscar64)
    $arguments = @(
        "-o=$output",
        '-Os', '-Oo', '-Oi', '-Op', '-Oz',
        '-tf=prg', '-tm=c64', '-dNOLONG', '-dNOFLOAT', '-psci',
        "-i=$oscarRoot\include",
        "-i=$oscarRoot\include\c64",
        "-i=$includeRoot",
        "-i=$mapgenInclude"
    )
    $arguments += $Defines
    $arguments += $source

    & $Oscar64 @arguments
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $output)) {
        throw "Benchmark compilation failed: $Name"
    }
    return $output
}

function Invoke-Benchmark {
    param(
        [string]$Program,
        [Nullable[long]]$CycleLimit = $null
    )

    $arguments = @(
        '-silent', '-minimized', '-warp', '+sound', '+confirmonexit',
        '-debugcart', '-autostart', $Program
    )
    if ($null -ne $CycleLimit) {
        # PowerShell unwraps Nullable[Int64] parameters, so using .Value here
        # would silently pass an empty limit to VICE.
        $arguments = @('-limitcycles', [long]$CycleLimit) + $arguments
    }

    # VICE is a Windows GUI executable, so invoking it directly from
    # PowerShell can return before the emulator has actually stopped. Use an
    # explicit Process object and wait for the debug-cart/limitcycles exit.
    $startInfo = [Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $Vice
    $startInfo.UseShellExecute = $false
    $startInfo.CreateNoWindow = $true
    foreach ($argument in $arguments) {
        [void]$startInfo.ArgumentList.Add([string]$argument)
    }

    $process = [Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    [void]$process.Start()
    $process.WaitForExit()
    $exitCode = $process.ExitCode
    $process.Dispose()
    Write-Verbose "VICE limit=$CycleLimit exit=$exitCode"
    return $exitCode
}

$variantSuffix = ''
$benchmarkDefines = @()
if ($LegacyRowOffsets) {
    $variantSuffix += '-legacy-row-offsets'
    $benchmarkDefines += '-dMAPGEN_LEGACY_ROW_OFFSETS'
}
if ($LegacyRoomBounds) {
    $variantSuffix += '-legacy-room-bounds'
    $benchmarkDefines += '-dMAPGEN_LEGACY_ROOM_BOUNDS'
}

if ($Mode -eq 'checksum') {
    $lowProgram = Build-Benchmark -Name "mapgen-benchmark$variantSuffix-low" -Defines ($benchmarkDefines + '-dBENCH_CHECKSUM_LOW')
    $low = Invoke-Benchmark -Program $lowProgram
    $highProgram = Build-Benchmark -Name "mapgen-benchmark$variantSuffix-high" -Defines ($benchmarkDefines + '-dBENCH_CHECKSUM_HIGH')
    $high = Invoke-Benchmark -Program $highProgram
    $checksum = (($high -band 0xFF) -shl 8) -bor ($low -band 0xFF)
    '{0:X4}' -f $checksum
    exit 0
}

$benchmarkName = "mapgen-benchmark$variantSuffix"
$program = Build-Benchmark -Name $benchmarkName -Defines $benchmarkDefines
$benchmarkCompleteExit = 0x42

# Find a successful upper bound, then binary-search the first cycle where the
# benchmark reaches its debug-cart exit. A limit hit returns nonzero in VICE.
[long]$lowLimit = 0
[long]$highLimit = 1000000
while ((Invoke-Benchmark -Program $program -CycleLimit $highLimit) -ne $benchmarkCompleteExit) {
    $lowLimit = $highLimit
    $highLimit *= 2
    if ($highLimit -gt 2000000000) {
        throw 'Benchmark did not finish before the maximum cycle limit.'
    }
}

while (($highLimit - $lowLimit) -gt 1) {
    [long]$mid = $lowLimit + (($highLimit - $lowLimit) / 2)
    if ((Invoke-Benchmark -Program $program -CycleLimit $mid) -eq $benchmarkCompleteExit) {
        $highLimit = $mid
    } else {
        $lowLimit = $mid
    }
}

$highLimit

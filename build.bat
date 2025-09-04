@echo off
echo =============================================================================
echo OSCAR64 Build Script for Hacked C64 Map Generator
echo =============================================================================
echo.

REM OSCAR64 compilation flags:
REM -O0  : No compiler optimization
REM -v2  : Verbose output for diagnostics
REM -g   : Debug symbols (optional, can be removed for final build)

REM Get the script directory
set "SCRIPT_DIR=%~dp0"
REM Path to oscar64 compiler
set "OSCAR64_PATH=%SCRIPT_DIR%oscar64\bin\oscar64.exe"
REM Set the source directories
set "SRC_DIR=%SCRIPT_DIR%main\src"
set "MAPGEN_DIR=%SCRIPT_DIR%main\src\mapgen"
REM Set the build directory
set "BUILD_DIR=%SCRIPT_DIR%build"
REM Set the output PRG file name
set "OUTPUT_PATH=%BUILD_DIR%\Hacked C64.prg"

REM Create build directory if it doesn't exist, or clean it if it does
if not exist "%BUILD_DIR%" (
    echo Creating build directory...
    mkdir "%BUILD_DIR%"
    echo.
) else (
    echo Cleaning build directory...
    del /Q "%BUILD_DIR%\*" 2>nul
    for /d %%D in ("%BUILD_DIR%\*") do rmdir /S /Q "%%D" 2>nul
    echo.
)

REM Change to script directory to use relative paths
cd /d "%SCRIPT_DIR%"

REM Build the project with oscar64 (simplified - main.c includes all modules)
echo Building "Hacked C64.prg" with oscar64...
oscar64\bin\oscar64.exe -o="build\Hacked C64.prg" -n -tf=prg -Os -dNOLONG -dNOFLOAT -psci -tm=c64 -dDEBUG -d__oscar64__ -i=oscar64\include -i=oscar64\include\c64 -i=main\src\mapgen main\src\main.c
echo.

REM Check if build was successful
if exist "%OUTPUT_PATH%" (
    echo =============================================================================
    echo Build completed successfully!
    echo =============================================================================
    echo.
    echo Generated files folder:
    echo %BUILD_DIR%
    echo.
    if exist "%OUTPUT_PATH%" (
        echo - PRG: Hacked C64.prg
        for %%A in ("%OUTPUT_PATH%") do echo   Size: %%~zA bytes
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64.map" (
        echo - MAP: Memory usage details
	echo.
    )
    if exist "%BUILD_DIR%\Hacked C64.asm" (
        echo - ASM: 6502 assembly listing
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64.lbl" (
        echo - LBL: VICE debugger labels
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64.dbj" (
        echo - DBJ: JSON debug data
    )
) else (
    echo Build failed!
    pause
    exit /b 1
)

echo Build completed.
echo.
pause
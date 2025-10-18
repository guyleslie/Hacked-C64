@echo off
echo =============================================================================
echo OSCAR64 RELEASE Build Script for Hacked C64 Map Generator
echo =============================================================================
echo.

REM Release build with maximum size optimization and no debug overhead
REM Optimized for: minimum file size, maximum performance
REM Trade-off: No debug information for smaller, faster code

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

REM RELEASE BUILD FLAGS:
REM -Os        : Optimize for size (primary goal)
REM -Oo        : Outliner optimization (extract repeated code into functions)
REM -Oi        : Auto inline small functions
REM -Op        : Optimize constant parameters
REM -Oz        : Auto zero page placement for globals
REM -tf=prg    : Output PRG format
REM -tm=c64    : Target Commodore 64
REM -dNOLONG   : Disable long integer support
REM -dNOFLOAT  : Disable floating point support
REM -psci      : Enable C64-specific optimizations
REM
REM REMOVED: -dDEBUG, -d__oscar64__, -g, -n (no debug overhead)

echo Building "Hacked C64.prg" (RELEASE BUILD) with oscar64...
oscar64\bin\oscar64.exe -o="build\Hacked C64.prg" -Os -Oo -Oi -Op -Oz -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci -i=oscar64\include -i=oscar64\include\c64 -i=main\src\mapgen main\src\main.c
echo.

REM Check if build was successful
if exist "%OUTPUT_PATH%" (
    echo =============================================================================
    echo RELEASE Build completed successfully!
    echo =============================================================================
    echo.
    echo Generated files folder:
    echo %BUILD_DIR%
    echo.
    echo - PRG: Hacked C64.prg (RELEASE BUILD - OPTIMIZED^))
    for %%A in ("%OUTPUT_PATH%") do echo   Size: %%~zA bytes
    echo.
    echo This is an optimized release build with:
    echo   * Size optimization (-Os^)
    echo   * Code outlining (-Oo^)
    echo   * Auto inline (-Oi^)
    echo   * Constant optimization (-Op^)
    echo   * Zero page optimization (-Oz^)
    echo   * No debug overhead
    echo   * Minimum file size
    echo.
    echo Release build completed.
    echo.
    pause
    exit /b 0
) else (
    echo Release build failed!
    pause
    exit /b 1
)
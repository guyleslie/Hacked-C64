@echo off
echo =============================================================================
echo OSCAR64 DEVELOPMENT Build Script for Hacked C64 Map Generator
echo =============================================================================
echo.

REM Development build with full debug information and minimal optimization
REM Optimized for: debugging, analysis, development workflow
REM Trade-off: Larger file size for better debugging experience

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
set "OUTPUT_PATH=%BUILD_DIR%\Hacked C64-dev.prg"

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

REM DEVELOPMENT BUILD FLAGS:
REM -O0        : No optimization (easier debugging)
REM -g         : Include debug symbols
REM -n         : Generate additional debug files (.map, .asm, .lbl, .dbj)
REM -dDEBUG    : Enable DEBUG macro for conditional compilation
REM -d__oscar64__ : Enable OSCAR64-specific defines
REM -tf=prg    : Output PRG format
REM -tm=c64    : Target Commodore 64
REM -dNOLONG   : Disable long integer support (C64 optimization)
REM -dNOFLOAT  : Disable floating point support (C64 optimization)
REM -psci      : Enable some C64-specific optimizations

echo Building "Hacked C64-dev.prg" (DEVELOPMENT BUILD) with oscar64...
oscar64\bin\oscar64.exe -o="build\Hacked C64-dev.prg" -O0 -g -n -dDEBUG -d__oscar64__ -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci -i=oscar64\include -i=oscar64\include\c64 -i=main\src\mapgen main\src\main.c
echo.

REM Check if build was successful
if exist "%OUTPUT_PATH%" (
    echo =============================================================================
    echo DEVELOPMENT Build completed successfully!
    echo =============================================================================
    echo.
    echo Generated files folder:
    echo %BUILD_DIR%
    echo.
    if exist "%OUTPUT_PATH%" (
        echo - PRG: Hacked C64-dev.prg (DEVELOPMENT BUILD^)
        for %%A in ("%OUTPUT_PATH%") do echo   Size: %%~zA bytes
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-dev.map" (
        echo - MAP: Memory usage details (use for optimization analysis^)
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-dev.asm" (
        echo - ASM: 6502 assembly listing (use for performance analysis^)
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-dev.lbl" (
        echo - LBL: VICE debugger labels (use for debugging^)
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-dev.dbj" (
        echo - DBJ: JSON debug data (use for analysis^)
        echo.
    )
    echo NOTE: This is a DEVELOPMENT build with debug overhead.
    echo Use build-release.bat for optimized production build.
    echo.
    echo Development build completed.
) else (
    echo Development build failed!
    pause
    exit /b 1
)

echo.
pause
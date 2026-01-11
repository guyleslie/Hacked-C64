@echo off
echo =============================================================================
echo MAPGEN RELEASE Build Script for C64 Map Generator
echo =============================================================================
echo.

REM Mapgen release build without DEBUG_MAPGEN
REM Disables: Menu, preview, navigation, export
REM Optimized for: Production use, minimal size
REM Uses: Full optimization (-O3), no debug symbols

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
set "OUTPUT_PATH=%BUILD_DIR%\Hacked C64-mapgen-release.prg"

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

REM MAPGEN RELEASE BUILD FLAGS:
REM -Os            : Optimize for size
REM -Oo            : Optimize code
REM -Oi            : Inline functions
REM -Op            : Optimize peephole
REM -Oz            : Optimize zero page usage
REM NO -dDEBUG_MAPGEN : Disable MAPGEN DEBUG mode (production API only)
REM -tf=prg        : Output PRG format
REM -tm=c64        : Target Commodore 64
REM -dNOLONG       : Disable long integer support (C64 optimization)
REM -dNOFLOAT      : Disable floating point support (C64 optimization)
REM -psci          : Enable some C64-specific optimizations

echo Building "Hacked C64-mapgen-release.prg" (MAPGEN RELEASE BUILD) with oscar64...
oscar64\bin\oscar64.exe -o="build\Hacked C64-mapgen-release.prg" -Os -Oo -Oi -Op -Oz -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci -i=oscar64\include -i=oscar64\include\c64 -i=main\src\mapgen main\src\main.c
echo.

REM Check if build was successful
if exist "%OUTPUT_PATH%" (
    echo =============================================================================
    echo MAPGEN RELEASE Build completed successfully!
    echo =============================================================================
    echo.
    echo Generated files folder:
    echo %BUILD_DIR%
    echo.
    if exist "%OUTPUT_PATH%" (
        echo - PRG: Hacked C64-mapgen-release.prg (MAPGEN RELEASE BUILD^)
        for %%A in ("%OUTPUT_PATH%") do echo   Size: %%~zA bytes
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-mapgen-release.map" (
        echo - MAP: Memory usage details (use for size analysis^)
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-mapgen-release.asm" (
        echo - ASM: 6502 assembly listing (use for optimization verification^)
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-mapgen-release.lbl" (
        echo - LBL: VICE debugger labels (use for production debugging^)
        echo.
    )
    echo NOTE: This is a PRODUCTION build:
    echo - DEBUG_MAPGEN features disabled (no menu, no preview, no export)
    echo - Uses mapgen_generate_with_params() API
    echo - Optimized for minimal size and maximum performance
    echo - Currently configured with MEDIUM preset (64x64, 25%% features)
    echo.
    echo Use build-mapgen-test.bat for testing with DEBUG features.
    echo.
    echo Mapgen release build completed.
) else (
    echo Mapgen release build failed!
    pause
    exit /b 1
)

echo.
pause

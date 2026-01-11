@echo off
echo =============================================================================
echo MAPGEN TEST Build Script for C64 Map Generator
echo =============================================================================
echo.

REM Mapgen test build with DEBUG_MAPGEN enabled
REM Enables: Menu, preview, navigation, export
REM Optimized for: Testing mapgen module functionality
REM Uses: No optimization (-O0), debug symbols, full debug info

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
set "OUTPUT_PATH=%BUILD_DIR%\Hacked C64-mapgen-test.prg"

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

REM MAPGEN TEST BUILD FLAGS:
REM -Os            : Optimize for size
REM -Oo            : Optimize code
REM -Oi            : Inline functions
REM -Op            : Optimize peephole
REM -Oz            : Optimize zero page usage
REM -dDEBUG_MAPGEN : Enable MAPGEN DEBUG mode (menu, preview, navigation, export)
REM -tf=prg        : Output PRG format
REM -tm=c64        : Target Commodore 64
REM -dNOLONG       : Disable long integer support (C64 optimization)
REM -dNOFLOAT      : Disable floating point support (C64 optimization)
REM -psci          : Enable some C64-specific optimizations

echo Building "Hacked C64-mapgen-test.prg" (MAPGEN TEST BUILD) with oscar64...
oscar64\bin\oscar64.exe -o="build\Hacked C64-mapgen-test.prg" -Os -Oo -Oi -Op -Oz -dDEBUG_MAPGEN -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci -i=oscar64\include -i=oscar64\include\c64 -i=main\src\mapgen main\src\main.c
echo.

REM Check if build was successful
if exist "%OUTPUT_PATH%" (
    echo =============================================================================
    echo MAPGEN TEST Build completed successfully!
    echo =============================================================================
    echo.
    echo Generated files folder:
    echo %BUILD_DIR%
    echo.
    if exist "%OUTPUT_PATH%" (
        echo - PRG: Hacked C64-mapgen-test.prg (MAPGEN TEST BUILD^)
        for %%A in ("%OUTPUT_PATH%") do echo   Size: %%~zA bytes
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-mapgen-test.map" (
        echo - MAP: Memory usage details (use for optimization analysis^)
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-mapgen-test.asm" (
        echo - ASM: 6502 assembly listing (use for performance analysis^)
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-mapgen-test.lbl" (
        echo - LBL: VICE debugger labels (use for debugging^)
        echo.
    )
    if exist "%BUILD_DIR%\Hacked C64-mapgen-test.dbj" (
        echo - DBJ: JSON debug data (use for analysis^)
        echo.
    )
    echo NOTE: This build includes DEBUG_MAPGEN features:
    echo - Configuration menu with joystick controls
    echo - Map preview and navigation
    echo - M key for map export
    echo - FIRE button for regeneration
    echo.
    echo Use build-mapgen-release.bat for production build.
    echo.
    echo Mapgen test build completed.
) else (
    echo Mapgen test build failed!
    pause
    exit /b 1
)

echo.
pause

@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "BUILD_DIR=%SCRIPT_DIR%build"
set "OUTPUT=%BUILD_DIR%\Hacked C64-tileviewer.prg"

echo.
echo =============================================================================
echo                           TILE VIEWER Build
echo =============================================================================
echo.
echo  Scrollable 3x3 tile preview of a generated dungeon.
echo  Joystick 2 scrolls, FIRE generates a new map, Q quits.
echo.
echo  NOTE: the character set is copied to $3800 at runtime, so code and data
echo        must stay below that. If the linker reports an overlap, move the
echo        VIC to bank 1 - see docs/tile-rendering.md.
echo.

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
del /Q "%BUILD_DIR%\*-tileviewer.*" 2>nul

echo Compiling...
echo.

"%SCRIPT_DIR%oscar64\bin\oscar64.exe" -o="%OUTPUT%" -Os -Oo -Oi -Op -Oz -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci -i="%SCRIPT_DIR%oscar64\include" -i="%SCRIPT_DIR%oscar64\include\c64" -i="%SCRIPT_DIR%main\src\mapgen" -i="%SCRIPT_DIR%main\src\tiles" "%SCRIPT_DIR%main\src\tileviewer.c"
set "BUILD_ERROR=%ERRORLEVEL%"

echo.
echo -----------------------------------------------------------------------------
if %BUILD_ERROR% equ 0 (
    if exist "%OUTPUT%" (
        echo  Status:    OK
        for %%A in ("%OUTPUT%") do echo  Size:      %%~zA bytes
        echo  Output:    %BUILD_DIR%\
        echo -----------------------------------------------------------------------------
        echo  Files:
        for %%F in ("%BUILD_DIR%\*-tileviewer.*") do echo              %%~nxF
    ) else (
        echo  Status:    FAILED
        echo  Error:     Output file not created
        set "BUILD_ERROR=1"
    )
) else (
    echo  Status:    FAILED
    echo  Error:     Compiler error %BUILD_ERROR%
)
echo =============================================================================
echo.
pause
exit /b %BUILD_ERROR%

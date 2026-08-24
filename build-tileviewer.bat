@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "BUILD_DIR=%SCRIPT_DIR%build"
set "OUTPUT=%BUILD_DIR%\Hacked C64-tileviewer.prg"

REM Locate the OSCAR64 compiler.
REM Order: OSCAR64_HOME environment variable, then a copy inside the repo,
REM then the usual local install. Set OSCAR64_HOME to override.
set "OSCAR64_DIR="
if defined OSCAR64_HOME if exist "%OSCAR64_HOME%\bin\oscar64.exe" set "OSCAR64_DIR=%OSCAR64_HOME%"
if not defined OSCAR64_DIR if exist "%SCRIPT_DIR%oscar64\bin\oscar64.exe" set "OSCAR64_DIR=%SCRIPT_DIR%oscar64"
if not defined OSCAR64_DIR if exist "E:\Apps\oscar64\bin\oscar64.exe" set "OSCAR64_DIR=E:\Apps\oscar64"
if not defined OSCAR64_DIR (
    echo  Status:    FAILED
    echo  Error:     oscar64.exe not found.
    echo             Set OSCAR64_HOME to the OSCAR64 install directory, e.g.
    echo               set OSCAR64_HOME=E:\Apps\oscar64
    echo.
    pause
    exit /b 1
)

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

"%OSCAR64_DIR%\bin\oscar64.exe" -o="%OUTPUT%" -Os -Oo -Oi -Op -Oz -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci -i="%OSCAR64_DIR%\include" -i="%OSCAR64_DIR%\include\c64" -i="%SCRIPT_DIR%main\src\mapgen" -i="%SCRIPT_DIR%main\src\tiles" "%SCRIPT_DIR%main\src\tileviewer.c"
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
    echo  Compiler:  %OSCAR64_DIR%
)
echo =============================================================================
echo.
pause
exit /b %BUILD_ERROR%

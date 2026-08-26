@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "BUILD_DIR=%SCRIPT_DIR%build"
set "OUTPUT=%BUILD_DIR%\Hacked C64-mapgen-tile-viewer.prg"

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

where python >nul 2>&1
if errorlevel 1 (
    echo  Status:    FAILED
    echo  Error:     python.exe not found; tileset data cannot be generated.
    echo.
    pause
    exit /b 1
)

echo.
echo =============================================================================
echo                       MAPGEN TILE VIEWER Build
echo =============================================================================
echo.
echo  Generates the 3x3 character tiles from newest5/tileset.ctm, then builds
echo  a standalone scrolling dungeon viewer PRG.
echo.
echo  Black grid: walkable floor, stairs and open doors only.
echo  No grid:    walls, closed doors and black outside cells.
echo.

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
del /Q "%BUILD_DIR%\*-mapgen-tile-viewer.*" 2>nul

echo Generating tileset data...
python "%SCRIPT_DIR%tools\tileset_build.py" "%SCRIPT_DIR%main\assets\tileset.ctm" --self-test --quiet
if errorlevel 1 (
    echo.
    echo  Status:    FAILED
    echo  Error:     tileset self-test failed
    echo =============================================================================
    echo.
    pause
    exit /b 1
)
python "%SCRIPT_DIR%tools\tileset_build.py" "%SCRIPT_DIR%main\assets\tileset.ctm" --out-dir "%SCRIPT_DIR%main\src\tiles" --quiet
if errorlevel 1 (
    echo.
    echo  Status:    FAILED
    echo  Error:     tileset generation failed
    echo =============================================================================
    echo.
    pause
    exit /b 1
)

echo.
echo Compiling...
echo.

"%OSCAR64_DIR%\bin\oscar64.exe" -o="%OUTPUT%" -O2 -n -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci -i="%OSCAR64_DIR%\include" -i="%OSCAR64_DIR%\include\c64" -i="%SCRIPT_DIR%main\src\mapgen" -i="%SCRIPT_DIR%main\src\tiles" "%SCRIPT_DIR%main\src\tileviewer.c"
set "BUILD_ERROR=%ERRORLEVEL%"

echo.
echo -----------------------------------------------------------------------------
if %BUILD_ERROR% equ 0 (
    if exist "%OUTPUT%" (
        echo  Status:    OK
        for %%A in ("%OUTPUT%") do echo  Size:      %%~zA bytes
        echo  Output:    %OUTPUT%
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

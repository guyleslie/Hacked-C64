@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "BUILD_DIR=%SCRIPT_DIR%build"
set "OUTPUT=%BUILD_DIR%\Hacked C64-mapgen-test.prg"

echo.
echo =============================================================================
echo                           MAPGEN TEST Build
echo =============================================================================
echo.

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
del /Q "%BUILD_DIR%\*-mapgen-test.*" 2>nul

echo Compiling...
echo.

"%SCRIPT_DIR%oscar64\bin\oscar64.exe" -o="%OUTPUT%" -Os -Oo -Oi -Op -Oz -dDEBUG_MAPGEN -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci -i="%SCRIPT_DIR%oscar64\include" -i="%SCRIPT_DIR%oscar64\include\c64" -i="%SCRIPT_DIR%main\src\mapgen" "%SCRIPT_DIR%main\src\main.c"
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
        for %%F in ("%BUILD_DIR%\*-mapgen-test.*") do echo              %%~nxF
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

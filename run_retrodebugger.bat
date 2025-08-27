@echo off
cls
setlocal enabledelayedexpansion

REM Get the script directory
set "SCRIPT_DIR=%~dp0"


REM Path to RetroDebugger executable (relative to script directory)
set "RETRODEBUGGER_PATH=%SCRIPT_DIR%RetroDebugger\retrodebugger-notsigned.exe"

REM Get the current directory name (project name)
for %%I in ("%SCRIPT_DIR%.") do set "PROJECT_NAME=%%~nxI"

REM Set the PRG file path
set "PRG_PATH=%SCRIPT_DIR%build\Hacked C64.prg"

REM Check if the PRG file exists
if not exist "%PRG_PATH%" (
    echo Error: PRG file not found at "%PRG_PATH%"
    echo Build may have failed.
    pause
    exit /b 1
)

REM Check if RetroDebugger exists
if not exist "%RETRODEBUGGER_PATH%" (
    echo Error: RetroDebugger not found at "%RETRODEBUGGER_PATH%"
    pause
    exit /b 1
)

REM Launch RetroDebugger with the PRG file in C64 mode
echo Starting RetroDebugger with Hacked C64.prg...
"%RETRODEBUGGER_PATH%" ^
  -kernal "%SCRIPT_DIR%RetroDebugger\roms\kernal" ^
  -basic "%SCRIPT_DIR%RetroDebugger\roms\basic" ^
  -chargen "%SCRIPT_DIR%RetroDebugger\roms\chargen" ^
  -dos1541 "%SCRIPT_DIR%RetroDebugger\roms\dos1541" ^
  -c64 "%PRG_PATH%" ^
  -autojmp ^
  -unpause

if errorlevel 1 (
    echo Error: Failed to start RetroDebugger
    pause
)

endlocal
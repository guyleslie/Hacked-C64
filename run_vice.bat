@echo off
cls
setlocal enabledelayedexpansion

REM Get the script directory
set "SCRIPT_DIR=%~dp0"

REM Path to VICE C64 executable (relative to script directory)
set "VICE_PATH=%SCRIPT_DIR%vice\bin\x64sc.exe"

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

REM Check if VICE exists
if not exist "%VICE_PATH%" (
    echo Error: VICE emulator not found at "%VICE_PATH%"
    pause
    exit /b 1
)

REM Start VICE C64 emulator with the PRG file
echo Starting VICE C64 emulator...
echo Loading: "%PRG_PATH%"

REM Use x64sc (accurate C64 emulator) with autostart
"%VICE_PATH%" -autostart "%PRG_PATH%"

echo Exit code: %errorlevel%
if errorlevel 1 (
    echo Error: Failed to start VICE emulator
    pause
)

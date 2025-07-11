@echo off
setlocal enabledelayedexpansion

REM Path to C64 Debugger executable (using local helpers folder)
set "C64DEBUGGER_PATH=E:\APPS\c64 debugger\C64Debugger.exe"

REM Get the current directory name (project name)
for %%I in ("%cd%") do set "PROJECT_NAME=%%~nxI"

REM Build the project first
echo Building project before running...
call "%cd%\build.bat"
if errorlevel 1 (
    echo Build failed! Cannot run debugger.
    pause
    exit /b 1
)

REM Set the PRG file path
set "PRG_PATH=%cd%\build\%PROJECT_NAME%.prg"

REM Check if the PRG file exists
if not exist "%PRG_PATH%" (
    echo Error: PRG file not found at "%PRG_PATH%"
    echo Build may have failed.
    pause
    exit /b 1
)

REM Launch C64 Debugger with the PRG file
echo Starting C64 Debugger with "%PROJECT_NAME%.prg"...
"%C64DEBUGGER_PATH%" "%PRG_PATH%"

if errorlevel 1 (
    echo Error: Failed to start C64 Debugger
    pause
)

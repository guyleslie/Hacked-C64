@echo off
setlocal enabledelayedexpansion

REM Path to VICE executable
set "VICE_PATH=E:\Apps\GTK3VICE-3.9-win64\bin\x64sc.exe"

REM Get the current directory name (project name)
for %%I in ("%cd%") do set "PROJECT_NAME=%%~nxI"

REM Build the project first
echo Building project before running...
call "%cd%\build.bat"
if errorlevel 1 (
    echo Build failed! Cannot run VICE.
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

REM Launch VICE with the PRG file
echo Starting VICE with "%PROJECT_NAME%.prg"...
"%VICE_PATH%" "%PRG_PATH%"

if errorlevel 1 (
    echo Error: Failed to start VICE
    pause
)

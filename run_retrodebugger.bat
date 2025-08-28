rem @echo off
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

REM Change to RetroDebugger directory for proper working directory
cd /d "%SCRIPT_DIR%RetroDebugger"

REM Try multiple methods to ensure window appears
echo Attempting to start RetroDebugger...

REM First kill any existing instance
taskkill /f /im retrodebugger-notsigned.exe 2>nul

REM Try with multiple compatibility settings
echo Starting RetroDebugger with enhanced compatibility...

REM Set compatibility mode for Windows XP SP3 and disable DPI scaling
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%CD%\retrodebugger-notsigned.exe" /t REG_SZ /d "WINXPSP3 DPIUNAWARE HIGHDPIAWARE" /f >nul 2>&1

REM Alternative: try with admin rights and different window mode
echo Trying with administrator privileges and window focus...
powershell -Command "Start-Process -FilePath 'retrodebugger-notsigned.exe' -ArgumentList '-machine c64 -kernal \"roms\kernal\" -basic \"roms\basic\" -chargen \"roms\chargen\" -dos1541 \"roms\dos1541\" -prg \"..\build\Hacked C64.prg\" -autojmp -unpause' -WindowStyle Normal" 

echo Exit code: %errorlevel%
if errorlevel 1 (
    echo Error: Failed to start RetroDebugger
    pause
)
pause

endlocal
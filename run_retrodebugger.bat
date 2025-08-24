@echo off
REM RetroDebugger launcher script for Hacked C64 project
REM This script launches RetroDebugger with the built PRG file

setlocal

REM Define paths
set PROJECT_DIR=%~dp0
set RETRO_DEBUGGER_EXE=%PROJECT_DIR%RetroDebugger\RetroDebugger.exe
set BUILD_DIR=%PROJECT_DIR%build
set PRG_FILE=%BUILD_DIR%\Hacked C64.prg
set SYMBOLS_FILE=%BUILD_DIR%\Hacked C64.lbl

REM Check if RetroDebugger exists
if not exist "%RETRO_DEBUGGER_EXE%" (
    echo Error: RetroDebugger.exe not found at: %RETRO_DEBUGGER_EXE%
    echo Please run the CI/CD build first to download and extract RetroDebugger.
    pause
    exit /b 1
)

REM Check if PRG file exists
if not exist "%PRG_FILE%" (
    echo Error: PRG file not found at: %PRG_FILE%
    echo Please build the project first using: cmake --build build --target oscar64_build
    pause
    exit /b 1
)

REM Display launch information
echo ========================================
echo Launching RetroDebugger
echo ========================================
echo PRG File: %PRG_FILE%
echo Symbols: %SYMBOLS_FILE%
echo RetroDebugger: %RETRO_DEBUGGER_EXE%
echo ========================================
echo.

REM Launch RetroDebugger with the PRG file
if exist "%SYMBOLS_FILE%" (
    echo Loading with symbols file...
    "%RETRO_DEBUGGER_EXE%" -prg "%PRG_FILE%" -symbols "%SYMBOLS_FILE%" -autojmp -unpause
) else (
    echo Loading without symbols file...
    "%RETRO_DEBUGGER_EXE%" -prg "%PRG_FILE%" -autojmp -unpause
)

REM Check if RetroDebugger launched successfully
if %ERRORLEVEL% neq 0 (
    echo.
    echo Error: RetroDebugger failed to launch ^(Error Code: %ERRORLEVEL%^)
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo RetroDebugger session ended.
pause
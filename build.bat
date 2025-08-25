@echo off
echo =============================================================================
echo OSCAR64 Build Script for Hacked C64 Map Generator
echo =============================================================================

REM OSCAR64 compilation flags:
REM -O0  : No compiler optimization
REM -v2  : Verbose output for diagnostics
REM -g   : Debug symbols (optional, can be removed for final build)

REM Path to oscar64 compiler
set "OSCAR64_PATH=E:\Apps\oscar64\bin\oscar64.exe"
REM Set the source directories
set "SRC_DIR=%cd%\main\src"
set "MAPGEN_DIR=%cd%\main\src\mapgen"
REM Set the build directory
set "BUILD_DIR=%cd%\build"
REM Get the current directory name
set "PROJECT_NAME=%CD%"
for %%A in ("%PROJECT_NAME%") do set "PROJECT_NAME=%%~nxA"
REM Set the output PRG file name
set "OUTPUT_PATH=%BUILD_DIR%\%PROJECT_NAME%.prg"

REM Create build directory if it doesn't exist, or clean it if it does
if not exist "%BUILD_DIR%" (
    echo Creating build directory...
    mkdir "%BUILD_DIR%"
) else (
    echo Cleaning build directory...
    del /Q "%BUILD_DIR%\*" 2>nul
    for /d %%D in ("%BUILD_DIR%\*") do rmdir /S /Q "%%D" 2>nul
)

REM Build the project with oscar64 (all required .c files, unified utilities)
echo Building "%PROJECT_NAME%" with oscar64...
"%OSCAR64_PATH%" -o="%OUTPUT_PATH%" -n -g -tf=prg -O0 -tm=c64 -v2 -dDEBUG -d__oscar64__ -i="E:\Apps\oscar64\include" -i="E:\Apps\oscar64\include\c64" -i="E:\Apps\oscar64\include\c128" -i="E:\Apps\oscar64\include\audio" -i="E:\Apps\oscar64\include\gfx" -i="%cd%" -i="%cd%\src" -i="%cd%\main\src\mapgen" -i="%cd%\build" "main\src\main.c" "main\src\mapgen\map_export.c" "main\src\mapgen\map_generation.c" "main\src\mapgen\mapgen_utils.c" "main\src\mapgen\room_management.c" "main\src\mapgen\connection_system.c" "main\src\mapgen\mapgen_display.c"

REM Check if build was successful
if exist "%OUTPUT_PATH%" (
    echo Build successful! Output: "%OUTPUT_PATH%"
    echo.
    echo =============================================================================
    echo Build completed successfully!
    echo =============================================================================
    echo.
    echo Generated files:
    if exist "%OUTPUT_PATH%" (
        echo - PRG file: "%OUTPUT_PATH%" ^(executable program^)
        for %%A in ("%OUTPUT_PATH%") do echo   File size: %%~zA bytes
    )
    if exist "%BUILD_DIR%\%PROJECT_NAME%.map" (
        echo - Map file: %BUILD_DIR%\%PROJECT_NAME%.map ^(memory usage details^)
    )
    if exist "%BUILD_DIR%\%PROJECT_NAME%.asm" (
        echo - ASM listing: %BUILD_DIR%\%PROJECT_NAME%.asm ^(6502 assembly code^)
    )
    if exist "%BUILD_DIR%\%PROJECT_NAME%.lbl" (
        echo - Label file: %BUILD_DIR%\%PROJECT_NAME%.lbl ^(VICE debugger labels^)
    )
    if exist "%BUILD_DIR%\%PROJECT_NAME%.dbj" (
        echo - Debug info: %BUILD_DIR%\%PROJECT_NAME%.dbj ^(JSON debug data^)
    )
) else (
    echo Build failed!
    pause
    exit /b 1
)

echo.
echo Build completed.
pause
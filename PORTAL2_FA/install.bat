@echo off
setlocal enabledelayedexpansion
title Portal 2 - Persian Translation - Installer
color 0A

echo ========================================
echo   Portal 2 - Persian Translation
echo   Installer
echo ========================================
echo.

REM ============================================
REM پیدا کردن خودکار Portal 2
REM ============================================
set "PORTAL_PATH="

call :CheckPath "C:\Program Files (x86)\Steam\steamapps\common\Portal 2"
call :CheckPath "C:\Program Files\Steam\steamapps\common\Portal 2"
call :CheckPath "D:\Steam\steamapps\common\Portal 2"
call :CheckPath "D:\SteamLibrary\steamapps\common\Portal 2"
call :CheckPath "E:\SteamLibrary\steamapps\common\Portal 2"
call :CheckPath "F:\SteamLibrary\steamapps\common\Portal 2"
call :CheckPath "D:\Games\Steam\steamapps\common\Portal 2"
call :CheckPath "D:\Games\Portal 2"
call :CheckPath "C:\Games\Portal 2"

if "!PORTAL_PATH!"=="" (
    echo [!] Portal 2 folder not found automatically.
    echo.
    echo Please enter the full path to your Portal 2 folder.
    echo Example: D:\SteamLibrary\steamapps\common\Portal 2
    echo.
    set /p "PORTAL_PATH=Path: "
    if not "!PORTAL_PATH:~-1!"=="\" set "PORTAL_PATH=!PORTAL_PATH!\"
)

REM بررسی نهایی
if not exist "!PORTAL_PATH!portal2\" (
    echo.
    echo [X] ERROR: Portal 2 folder not found at:
    echo     !PORTAL_PATH!
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Portal 2 found at:
echo      !PORTAL_PATH!
echo.
echo [*] Installing Persian translation...
echo.

REM ============================================
REM بررسی پوشه Persian
REM ============================================
if not exist "%~dp0data\Persian\" (
    echo [X] ERROR: data\Persian folder not found!
    echo     Looking in: %~dp0data\Persian\
    echo.
    pause
    exit /b 1
)

REM ============================================
REM کپی فایل‌ها با xcopy
REM ============================================
echo     [*] Copying files...
echo.

xcopy /E /Y /I /Q "%~dp0data\Persian\*" "!PORTAL_PATH!" >nul 2>&1

if !errorlevel! neq 0 (
    echo     [!] xcopy failed with errorlevel !errorlevel!
    echo     [!] Trying alternative method...
    echo.
    call :CopyRecursive "%~dp0data\Persian" "!PORTAL_PATH!"
) else (
    echo     [OK] All files copied successfully.
)

echo.
echo ========================================
echo   Installation Complete!
echo ========================================
echo.
echo Now launch the game and enjoy!
echo.
pause
exit /b 0

REM ============================================
REM تابع بررسی مسیر
REM ============================================
:CheckPath
if exist "%~1\portal2\" (
    set "PORTAL_PATH=%~1\"
)
exit /b 0

REM ============================================
REM تابع کپی بازگشتی (روش جایگزین)
REM ============================================
:CopyRecursive
set "SRC=%~1"
set "DST=%~2"
for /r "%SRC%" %%f in (*.*) do (
    set "FILE=%%f"
    set "REL=!FILE:%SRC%\=!"
    set "DEST=!DST!!REL!"
    for %%d in ("!DEST!") do (
        if not exist "%%~dpd" mkdir "%%~dpd" >nul 2>&1
    )
    copy /Y "%%f" "!DEST!" >nul 2>&1
    echo         [OK] !REL!
)
exit /b 0
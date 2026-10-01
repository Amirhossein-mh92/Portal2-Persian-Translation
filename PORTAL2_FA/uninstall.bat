@echo off
setlocal enabledelayedexpansion
title Portal 2 - Persian Translation - Uninstaller
color 0C

echo ========================================
echo   Portal 2 - Persian Translation
echo   Uninstaller
echo ========================================
echo.

REM ============================================
REM مرحله ۱: پیدا کردن خودکار پوشه Portal 2
REM ============================================
set "PORTAL_PATH="
call :FindPortal

if "%PORTAL_PATH%"=="" (
    echo [!] Portal 2 installation folder not found automatically.
    echo.
    echo Please enter the full path to your Portal 2 folder.
    echo Example: D:\SteamLibrary\steamapps\common\Portal 2
    echo.
    set /p "PORTAL_PATH=Path: "
    if not "!PORTAL_PATH:~-1!"=="\" set "PORTAL_PATH=!PORTAL_PATH!\"
)

if not exist "%PORTAL_PATH%portal2\" (
    echo.
    echo [X] ERROR: Portal 2 folder not found at:
    echo     %PORTAL_PATH%
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Portal 2 found at:
echo      %PORTAL_PATH%
echo.
echo [*] Restoring original English files...
echo.

REM ============================================
REM مرحله ۲: کپی تمام فایل‌ها و پوشه‌های اصلی انگلیسی
REM ============================================
if not exist "%~dp0data\English\" (
    echo [X] ERROR: data\English folder not found!
    echo.
    pause
    exit /b 1
)

REM کپی تمام محتویات پوشه English با حفظ ساختار
xcopy /E /Y /I /Q "%~dp0data\English\*" "%PORTAL_PATH%" >nul 2>&1

if %errorlevel% equ 0 (
    echo     [OK] All original English files restored successfully.
) else (
    echo     [!] Some files may not have been restored. Check permissions.
)

echo.
echo ========================================
echo   Uninstallation Complete!
echo ========================================
echo.
echo Portal 2 has been restored to English.
echo.
pause
exit /b 0

REM ============================================
REM تابع پیدا کردن خودکار Portal 2
REM ============================================
:FindPortal
for %%D in (C D E F G H) do (
    if exist "%%D:\Program Files (x86)\Steam\steamapps\common\Portal 2\portal2\" (
        set "PORTAL_PATH=%%D:\Program Files (x86)\Steam\steamapps\common\Portal 2\"
        exit /b 0
    )
    if exist "%%D:\Program Files\Steam\steamapps\common\Portal 2\portal2\" (
        set "PORTAL_PATH=%%D:\Program Files\Steam\steamapps\common\Portal 2\"
        exit /b 0
    )
    if exist "%%D:\Steam\steamapps\common\Portal 2\portal2\" (
        set "PORTAL_PATH=%%D:\Steam\steamapps\common\Portal 2\"
        exit /b 0
    )
    if exist "%%D:\SteamLibrary\steamapps\common\Portal 2\portal2\" (
        set "PORTAL_PATH=%%D:\SteamLibrary\steamapps\common\Portal 2\"
        exit /b 0
    )
    if exist "%%D:\Games\Steam\steamapps\common\Portal 2\portal2\" (
        set "PORTAL_PATH=%%D:\Games\Steam\steamapps\common\Portal 2\"
        exit /b 0
    )
    if exist "%%D:\Games\Portal 2\portal2\" (
        set "PORTAL_PATH=%%D:\Games\Portal 2\"
        exit /b 0
    )
)
exit /b 1
@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ============================================
echo   Глаз Аргуса — локальный запуск сайта
echo ============================================
echo.
echo [1/2] Запускаю сервер...
echo [2/2] Сейчас откроется браузер — не закрывайте это окно.
echo.

:: Основной способ — через PowerShell (как в START-SITE.bat) — сам выберет свободный порт и откроет браузер
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0local-server.ps1" "/"
if %errorlevel% equ 0 goto :eof

echo.
echo PowerShell сервер не запустился, пробую Python...
echo.

:: Fallback 1: Python
python -m http.server 8000 --bind 127.0.0.1 2>nul
if %errorlevel% equ 0 goto :eof
python3 -m http.server 8000 --bind 127.0.0.1 2>nul
if %errorlevel% equ 0 goto :eof

:: Fallback 2: npx
echo Пробую npx serve...
npx --yes serve . -l 8000

if errorlevel 1 (
  echo.
  echo Не удалось запустить сервер. Установите Python 3 или Node.js
  echo Сайт находится в папке: %~dp0
  echo Откройте index.html вручную в браузере.
  pause
)

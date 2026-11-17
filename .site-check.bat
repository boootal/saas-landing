@echo off
cd /d "%~dp0"
echo Starting Glaz Argusa...
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0local-server.ps1"
if not errorlevel 1 goto :eof
echo.
echo PowerShell local-server failed, trying Python...
echo.
timeout /t 1 >nul
start "" "http://localhost:8000"
python -m http.server 8000 --bind 127.0.0.1
if not errorlevel 1 goto :eof
python3 -m http.server 8000 --bind 127.0.0.1
if not errorlevel 1 goto :eof
npx --yes serve . -l 8000
if errorlevel 1 (
  echo.
  echo Failed to start server. Please install Python or Node.js
  echo Open index.html manually: %~dp0
  pause
)

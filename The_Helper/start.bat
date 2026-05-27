@echo off
echo ========================================
echo   CORE_COMPASS Platform Startup
echo ========================================
echo.

REM Check if MongoDB is running
echo Checking MongoDB...
sc query MongoDB | find "RUNNING" >nul
if %errorlevel% == 0 (
    echo [OK] MongoDB is running
) else (
    echo [WARNING] MongoDB is not running
    echo Starting MongoDB...
    net start MongoDB
)

echo.
echo Starting Backend Server...
cd backend

REM Check if node_modules exists
if not exist "node_modules\" (
    echo Installing backend dependencies...
    call npm install
)

echo.
REM Start backend
start cmd /k "npm run dev"

echo Waiting for backend to start...
timeout /t 5 /nobreak >nul

echo.
echo Starting Frontend Server...
cd ..\frontend

REM Start frontend with Python
start cmd /k "python -m http.server 8000"

echo.
echo ========================================
echo   CORE_COMPASS is Running!
echo ========================================
echo.
echo.
echo Test Login:
echo   Hospital: contact@citygeneralhospital.com
echo   Password: hospital123
echo.
echo Press any key to open frontend in browser...
pause >nul

start 

echo.
echo Servers are running in separate windows.
echo Close those windows to stop the servers.
echo.
pause

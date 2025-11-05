@echo off
echo ============================================
echo Connection Diagnostics Tool
echo ============================================
echo.

echo 1. Checking if server config exists...
if exist "server-config.json" (
    echo    [OK] Config file found
    type server-config.json
) else (
    echo    [FAIL] Config file NOT found - Server hasn't been started yet!
    echo    Please start the server first: cd central-admin\server ^&^& npm start
)
echo.

echo 2. Checking if Node.js is running...
tasklist /FI "IMAGENAME eq node.exe" 2>NUL | find /I /N "node.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo    [OK] Node.js processes found
    tasklist /FI "IMAGENAME eq node.exe"
) else (
    echo    [FAIL] No Node.js processes running
    echo    Please start the server first!
)
echo.

echo 3. Checking network connection...
ping -n 1 192.168.29.212 >NUL 2>&1
if "%ERRORLEVEL%"=="0" (
    echo    [OK] Network reachable at 192.168.29.212
) else (
    echo    [WARNING] Cannot reach 192.168.29.212
    echo    Your IP might have changed. Restart the server!
)
echo.

echo 4. Testing server port 7401...
netstat -an | findstr ":7401" >NUL
if "%ERRORLEVEL%"=="0" (
    echo    [OK] Port 7401 is in use (server likely running)
    netstat -an | findstr ":7401"
) else (
    echo    [FAIL] Port 7401 not in use - Server NOT running!
    echo    Start server: cd central-admin\server ^&^& npm start
)
echo.

echo 5. Checking Electron processes (Kiosk)...
tasklist /FI "IMAGENAME eq electron.exe" 2>NUL | find /I /N "electron.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo    [OK] Electron/Kiosk is running
) else (
    echo    [INFO] Kiosk not running yet
)
echo.

echo ============================================
echo Quick Start Commands:
echo ============================================
echo.
echo Start Server:
echo    cd central-admin\server
echo    npm start
echo.
echo Start Kiosk:
echo    cd student-kiosk\desktop-app  
echo    npm start
echo.
echo Open Dashboard:
echo    http://192.168.29.212:7401/dashboard/working-simple.html
echo.
echo ============================================
pause

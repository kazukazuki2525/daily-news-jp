@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ========================================
echo   GitHub Sync - daily-news-jp
echo ========================================
echo.

echo [1/4] Pulling latest from GitHub...
git pull origin main
if errorlevel 1 (
    echo [ERROR] git pull failed
    pause
    exit /b 1
)

echo [2/4] Staging changes...
git add .
if errorlevel 1 (
    echo [ERROR] git add failed
    pause
    exit /b 1
)

echo [3/4] Committing...
for /f "tokens=*" %%d in ('date /t') do set TODAY=%%d
git commit -m "Update news data %TODAY%"
if errorlevel 1 (
    echo.
    echo [INFO] Nothing to commit (no changes)
    pause
    exit /b 0
)

echo [4/4] Pushing to GitHub...
git push origin main
if errorlevel 1 (
    echo [ERROR] git push failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Sync complete!
echo ========================================
echo.
pause

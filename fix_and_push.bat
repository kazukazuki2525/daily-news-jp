@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ========================================
echo   Resolve conflict and Push
echo ========================================
echo.

echo [1/5] Removing stale lock files...
del /q .git\HEAD.lock 2>nul
for /r .git\refs %%f in (*.lock) do del /q "%%f" 2>nul
echo Done.

echo [2/5] Staging changes...
git add .
if errorlevel 1 (
    echo [ERROR] git add failed
    pause
    exit /b 1
)

echo [4/5] Committing...
git commit -m "Add missing news data 7/25, 7/26, 7/28, 7/29, 7/30"
if errorlevel 1 (
    echo.
    echo [INFO] Nothing to commit (no changes)
    pause
    exit /b 0
)

echo [5/5] Pushing to GitHub...
git push origin main
if errorlevel 1 (
    echo [ERROR] git push failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Complete! 5 days of news data pushed.
echo ========================================
echo.
pause

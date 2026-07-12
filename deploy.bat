@echo off
chcp 65001 >nul 2>&1
echo ========================================
echo   釜山行程 - 部署到 GitHub Pages
echo   https://mcg62bzw7t-cell.github.io/busan-trip/
echo ========================================
echo.

cd /d "%~dp0"

:: Git 提交
git add -A
git diff --cached --quiet
if %errorlevel%==0 (
    echo [INFO] 没有检测到更改，跳过提交
) else (
    for /f "tokens=*" %%i in ('date /t ^& time /t') do set TIMESTAMP=%%i
    git commit -m "update %TIMESTAMP%"
    echo [OK] Git 提交完成
)

:: Git 推送（push 后 GitHub Actions 自动部署）
echo [INFO] 推送到 GitHub，自动触发 Pages 部署...
git push 2>&1
if %errorlevel%==0 (
    echo.
    echo ========================================
    echo   推送成功！1-2分钟后生效
    echo   https://mcg62bzw7t-cell.github.io/busan-trip/
    echo ========================================
) else (
    echo [ERROR] 推送失败，请检查错误信息
)

pause

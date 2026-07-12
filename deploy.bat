@echo off
chcp 65001 >nul 2>&1
echo ========================================
echo   釜山行程 - 部署到 Netlify
echo   https://busan0903.netlify.app
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

:: Netlify 部署
echo [INFO] 正在部署到 Netlify...
netlify deploy --prod --dir=. 2>&1
if %errorlevel%==0 (
    echo.
    echo ========================================
    echo   部署成功！
    echo   https://busan0903.netlify.app
    echo ========================================
) else (
    echo [ERROR] 部署失败，请检查错误信息
)

pause

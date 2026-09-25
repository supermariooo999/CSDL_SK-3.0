@echo off
setlocal

cd /d "%~dp0"

title CSDL SK - NLP Service

echo ==========================================
echo   CSDL SK - NLP SERVICE
echo ==========================================
echo.

if not exist "nlp-service\venv\Scripts\python.exe" (
    echo [ERROR] Chua co venv.
    echo Hay chay setup.bat truoc.
    echo.
    pause
    exit /b 1
)

if not exist "nlp-service\models\vietnamese-bi-encoder" (
    echo [ERROR] Khong tim thay model:
    echo nlp-service\models\vietnamese-bi-encoder
    echo.
    pause
    exit /b 1
)

echo Python:
nlp-service\venv\Scripts\python.exe --version

echo.
echo Dang khoi dong NLP service...
echo.
echo API:
echo http://127.0.0.1:8001
echo.
echo Health:
echo http://127.0.0.1:8001/health
echo.
echo Nhan Ctrl+C de dung server.
echo.

cd /d "%~dp0nlp-service"

venv\Scripts\python.exe -m uvicorn app:app --host 0.0.0.0 --port 8001 --reload

pause
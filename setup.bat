@echo off
setlocal

cd /d "%~dp0"

echo ==========================================
echo   CSDL SK - NLP SERVICE SETUP
echo ==========================================
echo.

echo [1/4] Kiem tra Python 3.12...
py -3.12 --version

if errorlevel 1 (
    echo.
    echo [ERROR] Khong tim thay Python 3.12.
    echo Hay cai Python 3.12 truoc.
    pause
    exit /b 1
)

echo.
echo [2/4] Tao virtual environment...

if exist "nlp-service\venv\Scripts\python.exe" (
    echo Venv da ton tai - bo qua.
) else (
    py -3.12 -m venv "nlp-service\venv"

    if errorlevel 1 (
        echo [ERROR] Tao venv that bai.
        pause
        exit /b 1
    )
)

echo.
echo [3/4] Nang cap pip...

nlp-service\venv\Scripts\python.exe -m pip install --upgrade pip

echo.
echo [4/4] Cai dat packages...

nlp-service\venv\Scripts\python.exe -m pip install torch --index-url https://download.pytorch.org/whl/cpu

if errorlevel 1 (
    echo.
    echo [ERROR] Cai torch that bai.
    pause
    exit /b 1
)

nlp-service\venv\Scripts\python.exe -m pip install -r "nlp-service\requirements.txt"

if errorlevel 1 (
    echo.
    echo [ERROR] Cai requirements that bai.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   SETUP HOAN TAT
echo ==========================================
echo.
echo NLP Service:
echo %CD%\nlp-service
echo.
echo Model:
echo %CD%\nlp-service\models\vietnamese-bi-encoder
echo.
echo Chay NLP bang:
echo start.bat
echo.

pause
Python 3.12.8

py -3.12 -m venv venv
venv\Scripts\activate.bat
pip install --upgrade pip
pip install torch --index-url https://download.pytorch.org/whl/cpu
pip install -r requirements.txt

uvicorn app:app --host 0.0.0.0 --port 8001 --reload
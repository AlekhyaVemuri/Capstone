@echo off
:: ──────────────────────────────────────────────────────────────────
::  Sequential Sentence Classification — Capstone Project
::  Python venv setup script for Windows
::  Usage: Double-click or run from Command Prompt / PowerShell
:: ──────────────────────────────────────────────────────────────────

setlocal EnableDelayedExpansion

set VENV_DIR=%~dp0venv
set PYTHON_BIN=python

echo ================================================
echo   Creating Python virtual environment
echo   Location: %VENV_DIR%
echo ================================================
echo.

:: Check Python is available
%PYTHON_BIN% --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found. Please install Python 3.10+ from https://python.org
    echo        Make sure to check "Add Python to PATH" during installation.
    pause
    exit /b 1
)

for /f "tokens=*" %%v in ('%PYTHON_BIN% --version') do echo   Found: %%v

:: Create venv with system site-packages
echo.
echo Creating venv...
%PYTHON_BIN% -m venv --system-site-packages "%VENV_DIR%"
if errorlevel 1 (
    echo ERROR: Failed to create venv.
    pause
    exit /b 1
)

echo.
echo ✓ venv created at: %VENV_DIR%
echo.

:: Check core packages
echo Core packages (via system site-packages):
"%VENV_DIR%\Scripts\python.exe" -c ^
"packages = [('numpy','numpy'),('pandas','pandas'),('sklearn','scikit-learn'),('matplotlib','matplotlib'),('seaborn','seaborn')]
for mod_name, pkg_name in packages:
    try:
        import importlib; m = importlib.import_module(mod_name)
        print(f'  OK  {pkg_name:<20} {m.__version__}')
    except ImportError:
        print(f'  --  {pkg_name:<20} not found (install: pip install {pkg_name})')
"

:: Check deep learning packages
echo.
echo Deep learning packages (optional — needed for Models 2-4):
"%VENV_DIR%\Scripts\python.exe" -c ^
"packages = [('tensorflow','tensorflow==2.18.0'),('transformers','transformers==4.35.0'),('torch','torch==2.2.0'),('tensorflow_hub','tensorflow-hub')]
for mod_name, install_cmd in packages:
    try:
        import importlib; m = importlib.import_module(mod_name)
        print(f'  OK  {mod_name:<20} {m.__version__}')
    except ImportError:
        print(f'  --  {mod_name:<20} optional (pip install {install_cmd})')
"

:: Register Jupyter kernel if ipykernel is available
echo.
echo Registering Jupyter kernel...
"%VENV_DIR%\Scripts\python.exe" -c "import ipykernel" >nul 2>&1
if errorlevel 1 (
    echo   ipykernel not found - skipping kernel registration.
    echo   To register manually:
    echo     pip install ipykernel
    echo     python -m ipykernel install --user --name=capstone_venv
) else (
    "%VENV_DIR%\Scripts\python.exe" -m ipykernel install --user ^
        --name=capstone_venv --display-name "Python (capstone_venv)"
    echo   ✓ Kernel registered: Python (capstone_venv)
)

echo.
echo ================================================
echo   DONE! Next steps:
echo.
echo   1. Activate the venv:
echo      %VENV_DIR%\Scripts\activate.bat
echo.
echo   2. (Optional) Install deep learning packages:
echo      pip install tensorflow==2.18.0 tensorflow-hub
echo      pip install transformers==4.35.0
echo      pip install torch==2.2.0
echo.
echo   3. Install Jupyter and launch:
echo      pip install jupyter ipykernel
echo      jupyter notebook Sequential_Sentence_Classification.ipynb
echo ================================================
echo.
pause
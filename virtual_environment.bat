@Echo Off
:: Display a message indicating the start of the script
echo ***********************************************
echo    Virtual-Environment is activating....
echo ***********************************************

:: Create a virtual environment named 'venv' if it doesn't exist
if not exist "venv" (
    python -m venv venv
)

:: Display a message indicating the virtual environment is ready to use
echo ***********************************************
echo    Virtual-Environment ready to use....
echo ***********************************************

:: Activate the virtual environment
venv/Scripts/activate.bat

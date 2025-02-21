@Echo Off
:: Batch script to install the Automation Framework

:: Display the start of the installation process
echo:************************************
echo:       Automation Framework
echo:************************************
echo:
echo:   **** Installation started ****

:: Upgrade pip to the latest version
 python.exe -m pip install --upgrade pip

:: Install the current package in editable mode with trusted hosts
py -m pip install -e . --trusted-host pypi.org --trusted-host files.pythonhosted.org
::--use-pep517 --config-settings="editable_mode=compat"

automation

@echo off
setlocal

:PROMPT
::echo:       **** Successfully Installed ****
::echo:*************************************************
::echo:    Automation Framework Installation Complete!
::echo:*************************************************
::echo:       **** Package Version --- v0.0.1 ****
::echo:
::SET /P AREYOUSURE= Do you like to Restart your system (N/Y)?
::IF /I "%AREYOUSURE%" NEQ "N" shutdown -s -t 0
::END


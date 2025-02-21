<meta property="og:site_name" content="AI QA Automation">
<meta property="og:title" content="AI QA Automation: Robot framework, Python, Pytest, Chat bot, GPT API, Web Automation, and E2E Testing" />
<meta property="og:description" content="Build fast, reliable, end-to-end tests." />
<meta property="og:keywords" content="Python, pytest, selenium, webdriver, test automation, testing, AI Testing, test framework, RPA, reports, website tours, presentations">

<p align="center">
<b>IT QA friendly AI driven automation framework!</b>
</p>

<p align="center">
All in one framework that supports Web, API, Database, and Mobile app automation testing 👨‍💻
</p>

<p align="center"> 
<a href="#python_installation">	🚀 Start</a> |
<a href="#install_framework">🔧Installation</a> |

</p>

<p align="center">
<img src="https://img.shields.io/badge/release-v0.0.1-brightgreen" alt="Latest Release on GitLab" /></a>
</p>


------
<p> 🧬 How it works? </p>
------
The AI Test Automation Framework is a Python-based QA testing framework that organizes and hosts multiple 
types of frameworks in an isolated system. It incorporates test runners such 
as [Robot Framework](https://github.com/robotframework) and other Python libraries to provide a 
structured approach to test discovery, execution, and state management.


<a id="python_installation"></a>
<h2> Software Setup:</h2>

Please add [Python to PATH](https://docs.python.org/3/using/windows.html#the-full-installer) during installation.

| Application Name       | Download Link                                                                                                    |
|------------------------|------------------------------------------------------------------------------------------------------------------|
| Python 3.12.8 [64 bit] | [Click Here](https://www.python.org/ftp/python/3.12.8/python-3.12.8-amd64.exe)                                   |
| Git                    | [Click Here](https://github.com/git-for-windows/git/releases/download/v2.30.0.windows.2/Git-2.30.0.2-64-bit.exe) |
| PyCharm                | [Click Here](https://jetbrains.com/pycharm/download/download-thanks.html?platform=windows&code=PCC)              |                                                              
| Github Desktop         | [Click Here](https://central.github.com/deployments/desktop/desktop/latest/win32)                                |
-----------------------------------------------------------------

<a id="install_framework"></a>
<h2> Install Automation Framework:</h2>


**1. Clone from GitLab using **[Github Desktop](https://central.github.com/deployments/desktop/desktop/latest/win32)** app**

```commandline
git clone https://github.com/zahed3795/AI_QA_Testing.git
```
****************************************************************************

**2. Use one of two options to build the framework:**

🟢 
<b>ProTip™: Option 1 is recommended, because it's the easiest way to install the framework.</b> 

Note: If you are using Pycharm, make sure your Command Prompt is activated, not the PowerShell. By default, Pycharm is set up with PowerShell, not the Command Prompt.

🔹 **Option 1:** Install from Command Prompt/Pycharm Terminal using executable file.

```bash
virtual_environment.bat
``` 
```bash
installer.bat
``` 
 
🔹 **Option 2:**
 Install using raw commands.

```commandline
python -m venv venv
venv\Scripts\activate.bat
git pull
python.exe -m pip install --upgrade pip
py -m pip install -e . --trusted-host pypi.org --trusted-host files.pythonhosted.org
```
* (For re-installation use --><code>py -m pip install -e. --force-reinstall</code>)

* (For upgrade use --> <code>py -m pip install -e. --upgrade</code>)

**3. Upgrade existing installation:**

```bash
git pull
pip install -e .
```






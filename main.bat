@echo off

net session >nul 2>&1
if "%errorLevel%" NEQ "0" (
    echo Error: Please run this script with administrator privileges.
    exit /b
)

where scoop >nul 2>&1
if not "%errorlevel%" equ "0" (
    echo Installing dependency Scoop...
    powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
    powershell -Command "(New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh') | Invoke-Expression"
)

where gcc >nul 2>&1
if not "%errorlevel%" equ "0" (
    echo Installing dependency gcc...
    scoop install main/gcc
)

where .\run.exe >nul 2>&1
if not "%errorlevel%" equ "0" (
    echo Compiling main.c...
    gcc .\main.c -o run.exe
)

takeown /f %systemroot%\System32\SettingsEnvironment.Desktop.dll /a
icacls %systemroot%\System32\SettingsEnvironment.Desktop.dll /grant Administrators:F
.\run.exe
slmgr -rearm

shutdown /r /f /t 0
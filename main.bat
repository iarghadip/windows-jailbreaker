@echo off

net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Error: Please run this script with administrator privileges.
    exit /b
)

takeown /f %systemroot%\System32\SettingsEnvironment.Desktop.dll /a
icacls %systemroot%\System32\SettingsEnvironment.Desktop.dll /grant Administrators:F

gcc .\main.c -o run.exe
.\run.exe
del .\run.exe

slmgr -rearm

shutdown /r /f /t 0
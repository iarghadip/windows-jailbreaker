@echo off

:isCommandExists
where %1 >nul 2>&1
if "%errorlevel%" equ "0" (
    exit /b 0
) else (
    exit /b 1
)

net session >nul 2>&1
if "%errorLevel%" NEQ "0" (
    echo Error: Please run this script with administrator privileges.
    exit /b
)

call :isCommandExists scoop
if not "%errorlevel%" equ "0" (
    powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
    powershell -Command "(New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh') | Invoke-Expression"
)

call :isCommandExists gcc
if not "%errorlevel%" equ "0" (
    scoop install main/gcc
)

takeown /f %systemroot%\System32\SettingsEnvironment.Desktop.dll /a
icacls %systemroot%\System32\SettingsEnvironment.Desktop.dll /grant Administrators:F

call :isCommandExists .\run.exe
if not "%errorlevel%" equ "0" (
    gcc .\main.c -o run.exe
)

slmgr -rearm

shutdown /r /f /t 0
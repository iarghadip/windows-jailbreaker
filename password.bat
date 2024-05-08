@echo off
setlocal EnableDelayedExpansion

set "chars=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
set "special=-"
set "password="

for /l %%i in (1,1,20) do (
    set /a idx=!random! %% 62
    for %%a in (!idx!) do set "char=!chars:~%%a,1!"
    set "password=!password!!char!"
)

set "password=!password:~0,6!-!password:~6,6!-!password:~12,6!"

echo| set /p=!password!| clip
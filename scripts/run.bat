@echo off

set user=pi
set piHost=192.168.68.168
set privateKeyPath=C:\Users\Stormtroopes\.ssh\id_rsa

ssh -i "%privateKeyPath%" %user@%piHost%
if %errorlevel% NEQ 0 (
    echo "SSH command failed with error code %errorlevel%."
) else (
    echo "SSH command completed successfully."
)

pause

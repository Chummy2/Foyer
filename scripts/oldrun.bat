@echo off

set user=pi
set piHost=192.168.68.168
set privateKeyPath=C:\Users\Stormtroopes\.ssh\id_rsa

set sourceFile=C:\Users\Stormtroopes\Downloads\cat-1151519_1280.jpg
set destinationFolder=/home/pi/Documents/pic

REM Construct the SSH command with dynamic variables
set touchCommand=ssh -i "%privateKeyPath%" %user@%piHost% "touch ~/Documents/test.json"
set scpCommand=ssh -i "%privateKeyPath%" %user@%piHost% "scp -i %privateKeyPath% \"%sourceFile%\" %user@%piHost%:\"%destinationFolder%\""

REM Execute the commands
%touchCommand%
echo "Executing SCP command..."
%scpCommand%
if errorlevel 1 (
    echo "SCP command failed with error code %errorlevel%."
) else (
    echo "SCP command completed successfully."
)

pause

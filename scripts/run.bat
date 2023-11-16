@echo off

:: Set your Raspberry Pi's details
set piAddress=172.16.1.225
set piUsername=pi
set updateFilePath=/home/pi/Documents/update.json
set picLocalPath=C:\Users\Stormtroopes\Documents\Foyer\scripts\UpdatePics
set picRemotePath=/home/pi/Documents/pics

:: Use SSH to check if update.json exists and delete it on the Raspberry Pi
call ssh -i C:\Users\Stormtroopes\.ssh\id_rsa %piUsername%@%piAddress% "if exist %updateFilePath% rm %updateFilePath%"

:: Use SCP to transfer all files from your PC to the Raspberry Pi
call scp -i C:\Users\Stormtroopes\.ssh\id_rsa %picLocalPath%\* %piUsername%@%piAddress%:%picRemotePath%

:: Use SSH to create an empty update.json file on the Raspberry Pi
call ssh -i C:\Users\Stormtroopes\.ssh\id_rsa %piUsername%@%piAddress% "touch %updateFilePath%"

:: Check the success of the command and echo the appropriate message
if %errorlevel% equ 0 (
    echo Completed: Update.json file created on the Raspberry Pi, and pictures transferred.
) else (
    echo Failed: Unable to create/update the update.json file or transfer pictures on the Raspberry Pi.
)

:: Pause to keep the console window open for viewing the result
pause

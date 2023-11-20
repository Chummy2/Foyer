@echo off

:: Set your Raspberry Pi's details
:: Set this IP address as your respberry pi's static ip. Make sure you set up static ip and then Go to terminal and type hostname -I to get the ip set piAddress=172.16.1.225 :: set this to what your username for your pi is. Should be pi but if not then open up file and go home then see what the folder is called inside the home folder
set piAddress=172.16.1.225
:: Set this to the name of your pi. Should be pi if not go to folders then the home folder and see what the name is of then folder in the home folder
set piUsername=pi
:: Set this to the directory where you want your .json file to be and what you want its name to be 
set updateFilePath=/home/pi/Documents/update.json
:: Set this to where you are placing your pictures that you want going to the pi
set picLocalPath=C:\Users\Stormtroopes\Documents\Foyer\scripts\UpdatePics
:: set this to where you want the pictures at on the pi. This creates a folder and you can change the name to anything you want. 
set picRemotePath=/home/pi/Documents/pics
:: tells you when the program is starting
echo Starting update process on the Raspberry Pi...

:: Uses SSH to delete the existing file that you can change on the Raspberry Pi. Will not error if there is not the file there
call ssh -i C:\Users\Stormtroopes\.ssh\id_rsa %piUsername%@%piAddress% "if [ -e %updateFilePath% ]; then rm %updateFilePath%; fi"
echo Deleted existing update.json file on the Raspberry Pi.

:: Use SSH to delete the existing /pics or what ever you named it  folder on the Raspberry Pi. Will not error if there is no folder 
call ssh -i C:\Users\Stormtroopes\.ssh\id_rsa %piUsername%@%piAddress% "rm -rf %picRemotePath%"
echo Deleted existing /pics folder on the Raspberry Pi.

:: Use SSH to recreate the /pics or what ever you named it folder on the Raspberry Pi
call ssh -i C:\Users\Stormtroopes\.ssh\id_rsa %piUsername%@%piAddress% "mkdir %picRemotePath%"
echo Recreated /pics folder on the Raspberry Pi.

:: Use SCP to transfer all files from your PC(the directory where you have your pictures located on your pc) to the /pics folder on the Raspberry Pi
call scp -i C:\Users\Stormtroopes\.ssh\id_rsa -r "%picLocalPath%\*" %piUsername%@%piAddress%:%picRemotePath%
echo Transferred pictures to the /pics folder on the Raspberry Pi.

:: Use SSH to recreate the update.json or what ever you named it file on the Raspberry Pi
call ssh -i C:\Users\Stormtroopes\.ssh\id_rsa %piUsername%@%piAddress% "touch %updateFilePath%"
echo Recreated update.json file on the Raspberry Pi.

:: Lets you know if the program worked correctly 
if %errorlevel% equ 0 (
    echo Completed: update.json file deleted, recreated, and pictures transferred.
) else (
    echo Failed: Unable to perform the necessary operations on the Raspberry Pi.
)

:: Pause to keep the console window open for viewing the result
pause

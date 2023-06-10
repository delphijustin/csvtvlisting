@echo off
if not exist channels.csv goto nocsv
set chid=
if "%1"=="/?" goto help
if "%1"=="" set /P chid=Enter Channel ID to lookup:
if not "%1"=="" set chid=%1
type channels.csv | find /I "%chid%"
if not "%2"=="/nowait" pause
exit /b 0
:help
echo Usage: %0 [channel_id] [/nowait]
echo.
echo Parameters:
echo /nowait     After the lookup is complete don't wait for a key press.

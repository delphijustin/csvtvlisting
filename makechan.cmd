@echo off
if "%1"=="/?" goto help
:newid
set csvid=%random%
if exist channels.%csvid%.csv goto newid
set churl=https://www.xmltvlistings.com/xmltv/get_channels/%1/%2
if "%2"=="" set churl=%1
if "%1"=="" goto configure
:makecsv
echo Creating CSV File...
xml2csv.exe -i %churl% -m channels.map -o channels.%csvid%.csv
if exist channels.%csvid%.csv goto created
echo Failed.
exit /b 1
:created
move /Y channels.%csvid%.csv channels.csv
echo Done.
exit /b 0
:help
echo Usage: %0 [xmlfilename] [apikey] [lineupid]
echo Parameters must be in the same order as shown.
echo To use a offline xml just use [xmlfilename] with nothing else typed
echo [xmlfilename] can also be a URL
exit /b 0
:configure
set /P apikey=Enter XMLTVListing.com API Key: 
set /P lineup=Enter Lineup ID: 
set churl=https://www.xmltvlistings.com/xmltv/get_channels/%apikey%/%lineup%
goto makecsv

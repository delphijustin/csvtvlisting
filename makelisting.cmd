@echo off
set apikey=%1
set lineup=%2
set startday=%3
set lastday=%4
set URLFooter=
:newid
set csvid=%RANDOM%
if exist listing.%csvid%.csv goto newid
if "%1"=="/?" goto help
if "%2"=="" goto nodownload
if "%apikey%"=="" set /P apikey=Enter your XMLTVListing API Key: 
if "%lineup%"=="" set /P lineup=Enter LineUp ID: 
if "%1"=="" goto askaboutdays
:processdays
if "%startday%"=="" set startday=0
set URLFooter=%startday%
if "%lastday%"=="" goto nodays
set URLFooter=%URLFooter%/%lastday%
:nodays
echo Create CSV File...
xml2csv.exe -i https://www.xmltvlistings.com/xmltv/get/%apikey%/%lineup%/%URLFooter% -o listing.%csvid%.csv -m shows.map
if exist listing.%csvid%.csv exit /b %csvid%
echo Failed!
exit /b 0
:askaboutdays
echo Would you like to use the default date starting from
choice /C 12N /M "Press 1 for start day only,press 2 for start day and number of days after the start day or press N for none"
if errorlevel 3 goto nodays
if errorlevel 2 goto inputBothdays
if errorlevel 1 set /P startday=Enter the offset day from today to use in the request:  
goto processdays
:inputBothdays
set /P startday=Enter the offset day from today to use in the request: 
set /P lastday=Enter the day count for this request: 
goto processdays
:help
echo Usage: %0 [xmlfilename] [apikey] [lineupid] [dayoffset] [daycount]
echo Parameters must be in the same order as shown.
echo To use a offline xml just use [xmlfilename] with nothing else typed.
echo [xmlfilename] can also be a URL
exit /b 0
:nodownload
if not exist %1 exit /b 0
xml2csv.exe -i %1 -m shows.map -o listing.%csvid%.csv
if not exist listing.%csvid%.csv exit /b 0
exit /b %csvid%
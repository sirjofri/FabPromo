@echo off
setlocal enabledelayedexpansion

set arg1=%1

for /f "tokens=2* skip=2" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\inkscape.exe" /v "Path"') do set inkscape=%%b

for %%f in (*.svg) do call :Run %%f %%~nf.png

:Run
rem last call will be empty or arg1, so only process actual files
if not exist "%1" goto :EOF
set source=%1
set target=%2
rem echo   %source% %target%
if "%arg1%" equ "/f" goto :Newer
if not exist "%target%" goto :Newer

for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "(Get-Item '%source%').LastWriteTime.ToString('yyyyMMddHHmmss')"`) do set "stime=%%A"
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "(Get-Item '%target%').LastWriteTime.ToString('yyyyMMddHHmmss')"`) do set "ttime=%%A"
rem echo   stime: %stime%
rem echo   ttime: %ttime%

if "!stime!" gtr "!ttime!" goto :Newer

:Skip
echo skipped %source%
goto :EOF

:Newer
"%inkscape%\inkscape.exe" %source% --export-type=png
echo built %target%

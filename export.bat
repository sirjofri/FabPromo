rem @echo off

for /f "tokens=2* skip=2" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\inkscape.exe" /v "Path"') do set inkscape=%%b

for %%f in (*.svg) do (
"%inkscape%\inkscape.exe" %%f --export-type=png --export-page=all
echo %%f
)

mkdir output 2>NUL
move *.png output 2>NUL

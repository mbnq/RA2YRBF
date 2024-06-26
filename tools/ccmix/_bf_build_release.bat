REM mbnq00@gmail.com
REM https://www.mbnq.pl/

@echo off
title Mbnq's Brute Force Release Builder
setlocal
cls

call :intro

set RarPath="C:\Program Files\WinRAR\WinRAR.exe"

if NOT exist %RarPath% (echo:WinRAR.exe not found&&goto bye)

set "verPreffix=RA2YRBF_0_8_"
set "SourceDir=F:\projekty\_cnc_\RA2BruteForce\RA2BF\RA2YRBF"
set "rVerPreffix=Version: 0.8."
set readmeFile="%SourceDir%\README.md"

set /p ArchiveName=Name your release suffix (preffix is "%verPreffix%"): 
set "OutputArchive=%verPreffix%%ArchiveName%.zip"

if exist %readmeFile% (
	powershell -Command ^
		"(Get-Content '%readmeFile%') | ForEach-Object { if ($_ -like '%rVerPreffix%*') { '%rVerPreffix%%ArchiveName%' } else { $_ } } | Set-Content '%readmeFile%'"
)
%RarPath% a -r -ep1 "%OutputArchive%" "%SourceDir%" -z"%SourceDir%\README.md" -x"%SourceDir%\desktop.ini" -x"%SourceDir%\_build.bat" -x"%SourceDir%\MIX" -x"%SourceDir%\tools" -x"%SourceDir%\tools\ccmix" -x"%SourceDir%\.git" -x"%SourceDir%\.gitattributes" -x"%SourceDir%\.gitignore" -OS

echo Archive ready: %OutputArchive%

choice /C GN /M "Are you ready to upload it as an update for autoupdater? (Go/No)"
if %errorlevel% neq 1 goto bye

choice /C YN /M "Do you really want to upload it as an update for autoupdater? (Y/N)"
if %errorlevel% equ 1 (
    copy "%OutputArchive%" ra2yrbf_patch.zip /y > nul
    curl -T "ra2yrbf_patch.zip" -u "login:password" ftp.mysite.net
    goto bye
)

:bye
	echo:
	echo:Press any key to quit this script...
	pause > nul
endlocal	
exit

:intro
	cls
	echo:*********************************************************
	echo:*                                                       *
	echo:*  Command ^& Conquer Yuri^'s Revenge - Brute Force Mod   *
	echo:*                                                       *
	echo:*                                        mbnq.pl 2024   *
	echo:*                                                       *
	echo:*********************************************************
	echo:

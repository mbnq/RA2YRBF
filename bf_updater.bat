@echo off
setlocal enabledelayedexpansion
title Mbnq's Brute Force Updater
REM mbnq00@gmail.com
REM https://www.mbnq.pl/

if exist ".gitattributes" (
	echo:Warning^^! detected repo files^^!
	goto bye
)

if not exist %windir%\System32\curl.exe (
	call :error0001
	echo Cannot find curl.exe^^!
	goto bye
)

if not exist gamemd.exe (
	call :error0001
	echo Cannot find gamemd.exe^^!
	goto bye
)

taskkill /im clientdx.exe > nul
cls
call :intro

set "gameRoot=%cd%"
cd "%gameRoot%"

set url=https://bf.mbnq.pl/patch/ra2yrbf_patch.zip
set bfTempPath=bftmp
set extractedPath=bftmp\extracted
set downloadedFile=bftmp\ra2yrbf_patch.zip
set "bfFiles=INI Maps Resources tools debug audio.bag audio.idx syringe.log spawn.ini rmgmd.ini soundmd.ini spawnmap.ini mpmbnqdummy.ini urbannmd.ini urbanmd.ini temperatmd.ini snowmd.ini desertmd.ini lunarmd.ini rulesmd.ini aimd.ini artmd.ini uimd.ini artmd.ini evamd.ini rbcvbf.ini mpzombie.ini mpmodesmd.ini mpbrutedoomsday2.ini mpanimaldoomsday2.ini heroicvehicles.ini heroicbuildings.ini heroicshields.ini heroicsidebonus.ini heroicbuildingsciv.ini heroicinfantry.ini heroicAI.ini ares.dll ares.dll.inj ares.mix BFLauncher.exe BFLauncherUnix.sh changelog.temp.txt cncnet5.dll expandmd70.mix expandmd71.mix expandmd72.mix expandmd73.mix gamemd.exe Phobos.dll Phobos.pdb qres.dat qres32.dll README.md Syringe.exe bfAI.ini bfAnimal.ini bfBrute.ini bfBuildings.ini bfBuildingsCiv.ini bfInfantry.ini bfLoot.ini bfRMCV.ini bfShields.ini bfSideBonus.ini bfVehicles.ini bfZombie.ini"

if not exist "%bfTempPath%" mkdir "%bfTempPath%"
if not exist "%extractedPath%" mkdir "%extractedPath%"

if not exist "%bfTempPath%" (
	call :error0001
	echo:Was not able to create temporary files.
	goto bye
)

echo:
echo Downloading the latest RA2YRBF version available...
echo:
curl -L -k -o "%downloadedFile%" "%url%"

if %ERRORLEVEL% neq 0 (
	rem cls
	pause > nul	
	call :error0001
    echo Failed to download the update files.
    goto bye
)

echo:
echo Extracting the mod mod files to temporary path...
echo:
tar -xf "%downloadedFile%" -C "%extractedPath%" > nul

if not exist "%extractedPath%\RA2YRBF\bf_uninstaller.bat" (
	call :error0001
	echo:Was not able to find bf_uninstaller.
	goto bye
)

echo:
echo Preparing uninstaller...
echo:
copy "%extractedPath%\RA2YRBF\bf_uninstaller.bat" bf_uninstaller.bat /y > nul

if not exist bf_uninstaller.bat (
	call :error0001
	echo:Was not able to overwrite bf_uninstaller.
	goto bye
)

:uninstall
call :intro
start bf_uninstaller.bat > nul
echo:
echo Please uninstall old files first then continue here
echo by pressing any key twice...
(pause > nul)&&(pause > nul)

for %%f in (%bfFiles%) do (
    if exist "%%f" (
		goto uninstall
    )
)

echo:
echo Copying new version mod filles...
echo:
xcopy /s /e /y "%extractedPath%\RA2YRBF\*" * > nul

if %ERRORLEVEL% neq 0 (
	rem cls
	pause > nul	
	call :error0001
    echo Failed to copy the update files into the game folder.
    goto bye
)

call :intro
echo Success^^!
echo Mod files has been updated.
goto bye

:bye
	echo:
	echo:Press any key to quit this updater...
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
	exit /b
	
:error0001
	call :intro
	echo:EEEEEEE EEEEEE  EEEEEE   EEEEEE  EEEEEE  
	echo:EE      EE   EE EE   EE EE    EE EE   EE 
	echo:EEEEE   EEEEEE  EEEEEE  EE    EE EEEEEE  
	echo:EE      EE   EE EE   EE EE    EE EE   EE 
	echo:EEEEEEE EE   EE EE   EE  EEEEEE  EE   EE 
	echo:
	exit /b
	

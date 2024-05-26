@echo off
setlocal enabledelayedexpansion
title Brute Force Updater
REM mbnq00@gmail.com
REM https://www.mbnq.pl/

if exist ".gitattributes" (
	echo Warning^^! detected repo files^^!
	goto bye
)

call :intro
echo This script will update Brute Force to the latest available version.
echo Custom maps and user options will remain saved.&&echo.
echo If you encounter an error during updating run updater once again.&&echo.

call :readVersion
echo Current version is: %bfversion%&&echo.

choice /C YN /M "- Do you want to run autoupdater? (Y/N)"
if not %errorlevel% equ 1 (
		call :intro
		echo Update aborted.
		goto bye
)

echo.
echo - Checking files...

where curl > nul 2> nul
if %ERRORLEVEL% neq 0 (
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
set extractedPath=%bfTempPath%\extracted
set backupPath=%bfTempPath%\backup
set downloadedFile=%bfTempPath%\ra2yrbf_patch.zip
set "bfFiles=INI Maps Resources tools debug audio.bag audio.idx syringe.log spawn.ini rmgmd.ini soundmd.ini spawnmap.ini mpmbnqdummy.ini urbannmd.ini urbanmd.ini temperatmd.ini snowmd.ini desertmd.ini lunarmd.ini rulesmd.ini aimd.ini artmd.ini uimd.ini artmd.ini evamd.ini rbcvbf.ini mpzombie.ini mpmodesmd.ini mpbrutedoomsday2.ini mpanimaldoomsday2.ini heroicvehicles.ini heroicbuildings.ini heroicshields.ini heroicsidebonus.ini heroicbuildingsciv.ini heroicinfantry.ini heroicAI.ini ares.dll ares.dll.inj ares.mix BFLauncher.exe BFLauncherUnix.sh changelog.temp.txt cncnet5.dll expandmd70.mix expandmd71.mix expandmd72.mix expandmd73.mix gamemd.exe Phobos.dll Phobos.pdb qres.dat qres32.dll README.md Syringe.exe bfAI.ini bfAnimal.ini bfBrute.ini bfBuildings.ini bfBuildingsCiv.ini bfInfantry.ini bfLoot.ini bfRMCV.ini bfShields.ini bfSideBonus.ini bfVehicles.ini bfZombie.ini"
set /a checkCounter=0
set /a checkAll=10

if not exist "%bfTempPath%" mkdir "%bfTempPath%"
if not exist "%extractedPath%" mkdir "%extractedPath%"
if not exist "%backupPath%" mkdir "%backupPath%"

if not exist "%bfTempPath%" (
	call :error0001
	echo Was not able to create temporary files.
	goto bye
)

echo.
echo - Creating backup of user settings and maps...

copy /y RA2MD.ini "%backupPath%\RA2MD.ini" > nul
xcopy /s /e /y "%gameRoot%\Maps\Custom\" "%backupPath%\Custom\" > nul

if %ERRORLEVEL% neq 0 (
	call :error0001
    echo Failed to backup user custom maps.
    goto bye
)

if not exist "%backupPath%\RA2MD.ini" (
	echo:Was not able to backup user settings.
)

call :sleep

echo.
echo - Downloading the latest RA2YRBF version available...

curl -L -k -o "%downloadedFile%" "%url%"

if %ERRORLEVEL% neq 0 (
	call :error0001
    echo Failed to download the update files.
    goto bye
)

call :sleep

echo.
echo - Extracting new mod files...

powershell -Command "Expand-Archive -Path '%downloadedFile%' -DestinationPath '%extractedPath%'" > nul
if %ERRORLEVEL% neq 0 (
    call :error0001
    echo Failed to extract the update files^^!
    goto bye
)

call :sleep

echo.
echo - Unblocking files...

powershell -Command "dir -r '%extractedPath%' | Unblock-File"
if %ERRORLEVEL% neq 0 (
	echo.
    echo BF Updater was unable to unblock the files^^!
	echo You may need to do that manually.
	echo.
	echo Press any key to continue updating...
	pause > nul
)

call :sleep

move /y "%extractedPath%\RA2YRBF\bf_updater.bat" "%backupPath%"\bf_updater.bat > nul

call :sleep

:uninstall
for %%f in (%bfFiles%) do (
	if exist "%%f" (
		echo Deleting: %%f
		del /Q /f "%%f"
		rd /Q /s "%%f"
		call :intro
		echo.
		echo - Uninstalling old files...
		echo.
	)
)

if exist "cnc-ddraw config.exe" del /q /f "cnc-ddraw config.exe" > nul

call :sleep

:install
call :intro
echo.
echo - Copying new version mod files...

xcopy /s /e /y "%extractedPath%\RA2YRBF\*" * > nul

if %ERRORLEVEL% neq 0 (
	call :error0001
    echo Failed to copy the update files into the game folder^^!
    goto bye
)

call :sleep

:restore
echo.
echo - Restoring player settings and maps...

copy /y "%backupPath%\RA2MD.ini" "RA2MD.ini" > nul
if %ERRORLEVEL% neq 0 (
	call :error0001
    echo Failed to restore player settings^^!
    goto bye
)
xcopy /s /e /y "%backupPath%\Custom\" "%gameRoot%\Maps\Custom\" > nul
if %ERRORLEVEL% neq 0 (
	call :error0001
    echo Failed to restore player settings^^!
    goto bye
)

call :sleep

echo.
echo - Cleaning up...

copy /y "%backupPath%\bf_updater.bat" "bf_updater.bat" > nul
call :sleep
rd /s /q "%bfTempPath%"

if %ERRORLEVEL% neq 0 (
	call :error0001
    goto bye
)

call :sleep

if %checkCounter% neq %checkAll% (
	call :error0001
    goto bye
)

call :readVersion
call :intro
echo Success^^!
echo Mod files have been updated to version: %bfversion%
goto bye

:bye
	echo.
	echo Press any key to quit this updater...
	pause > nul
endlocal	
exit

:readVersion
	if exist "readme.md" (
		for /f "tokens=1,* delims=:" %%a in ('findstr /c:"Version" "readme.md"') do (
			set "bfversionR=%%b"
			set "bfversionR=!bfversionR:~1!"
		)
		set bfversion=!bfversionR!
	) else (
		set bfversion=unknown
	)
	exit /b

:sleep
	set /a checkCounter=%checkCounter%+1
	title [%checkCounter%/%checkAll%] BF Updater > nul	
	timeout /t 1 > nul
	exit /b

:intro
	cls
	echo *********************************************************
	echo *                                                       *
	echo *  Command ^& Conquer Yuri^'s Revenge - Brute Force Mod   *
	echo *                                                       *
	echo *                                        mbnq.pl 2024   *
	echo *                                                       *
	echo *********************************************************
	echo.
	exit /b
	
:error0001
	echo.
	echo EEEEEEE EEEEEE  EEEEEE   EEEEEE  EEEEEE  
	echo EE      EE   EE EE   EE EE    EE EE   EE 
	echo EEEEE   EEEEEE  EEEEEE  EE    EE EEEEEE  
	echo EE      EE   EE EE   EE EE    EE EE   EE 
	echo EEEEEEE EE   EE EE   EE  EEEEEE  EE   EE 
	echo.
	echo Something went wrong. You can try again.
	exit /b
	

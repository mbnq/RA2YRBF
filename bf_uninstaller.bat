@echo off
setlocal enabledelayedexpansion
title Mbnq's Brute Force Uninstaller
REM mbnq00@gmail.com
REM https://www.mbnq.pl/

cls
call :intro

if exist ".gitattributes" (echo:Warning^^! detected repo files^^!)&&(goto bye)

set "files=INI Maps Resources tools debug audio.bag audio.idx syringe.log spawn.ini rmgmd.ini soundmd.ini spawnmap.ini mpmbnqdummy.ini urbannmd.ini urbanmd.ini temperatmd.ini snowmd.ini desertmd.ini lunarmd.ini rulesmd.ini aimd.ini artmd.ini uimd.ini artmd.ini evamd.ini rbcvbf.ini mpzombie.ini mpmodesmd.ini mpbrutedoomsday2.ini mpanimaldoomsday2.ini heroicvehicles.ini heroicbuildings.ini heroicshields.ini heroicsidebonus.ini heroicbuildingsciv.ini heroicinfantry.ini heroicAI.ini ares.dll ares.dll.inj ares.mix BFLauncher.exe BFLauncherUnix.sh changelog.temp.txt cncnet5.dll expandmd70.mix expandmd71.mix expandmd72.mix expandmd73.mix gamemd.exe Phobos.dll Phobos.pdb qres.dat qres32.dll README.md Syringe.exe"

set "filesExist=0"
set _sample=%random%
echo Checking for files...
echo.

for %%f in (%files%) do (
    if exist "%%f" (
        echo Found: %%f
        set "filesExist=1"
    )
)

if %filesExist%==1 (
    echo.
    set /p choice="Type %_sample% and press ENTER if you really want to remove Brute Force: "
    echo.

    if /I "!choice!"=="%_sample%" (
        for %%f in (%files%) do (
            if exist "%%f" (
                echo Deleting: %%f
                del /Q /f "%%f"
				rd /Q /s "%%f
            )
        )
		
		if exist "cnc-ddraw config.exe" del /q /f "cnc-ddraw config.exe" > nul
		
		call :intro
		echo.
		echo:Make sure to verify game files integrity after uninstalling Brute Force^^!		
		echo: 
        echo: Thank you for trying Brute Force mod^^!
		echo: I would be very thankful for any feedback
		echo: on moddb, github or mbnq.pl.
		echo: -mbnq
		echo.
		goto byeanddelete
    ) else (
		call :intro
		call :error0001		
		echo: 
        echo: Entered wrong safety code, uninstallation cancelled^^!
		echo: 
		goto bye
    )
) else (
	call :intro
	echo:
	echo:Brute Force Mod files can not be found^^!
	echo:
	echo:Place me ^(bf_uninstaller.bat^) in your Yuri's Revenge dir
	echo:^(in folder with gamemd.exe^) where Brute Force mod was 
	echo:installed.
	goto bye
)

:bye
	echo:
	echo:Press any key to quit this uninstaller...
	pause > nul
endlocal	
exit

:byeanddelete
	echo:
	echo:Press any key to quit this uninstaller...
	pause > nul
	rem del /q /f bf_uninstaller.bat
endlocal	
exit

:intro
	cls
	echo:ллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
	echo:л                                                       л
	echo:л  Command ^& Conquer Yuri^'s Revenge - Brute Force Mod   л
	echo:л                                                       л
	echo:л                                        mbnq.pl 2024   л
	echo:л                                                       л
	echo:ллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
	echo:
	exit /b
	
:error0001
	echo:EEEEEEE EEEEEE  EEEEEE   EEEEEE  EEEEEE  
	echo:EE      EE   EE EE   EE EE    EE EE   EE 
	echo:EEEEE   EEEEEE  EEEEEE  EE    EE EEEEEE  
	echo:EE      EE   EE EE   EE EE    EE EE   EE 
	echo:EEEEEEE EE   EE EE   EE  EEEEEE  EE   EE 
	echo:
	exit /b
	


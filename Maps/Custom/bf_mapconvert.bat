@echo off
setlocal enabledelayedexpansion
title Brute Force Map Converter
REM mbnq00@gmail.com
REM https://www.mbnq.pl/

call :intro
echo This script will change extension of any map files
echo in current folder to .map&&echo.
echo.

choice /C YN /M "- Do you want to convert? (Y/N)"
if not %errorlevel% equ 1 (
		call :intro
		goto bye
)

taskkill /im clientdx.exe > nul
set /a _bfcounter=0

cls
call :intro

for %%f in (*.yrm *.mpr *.mmx) do (
    if exist "%%f" (
        echo - Converting: %%f
        set "newname=%%~nf.map"
		if exist "!newname!" set "newname=%random%!newname!"
		ren "%%f" "!newname!"
    )
)
if %ERRORLEVEL% neq 0 (
	call :error0001
)

echo.
echo - Finished^^!
goto bye

:bye
	echo.
	echo - Press any key to quit this script...
	pause > nul
endlocal	
exit

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
	echo Something went wrong or no maps found.
	exit /b
	

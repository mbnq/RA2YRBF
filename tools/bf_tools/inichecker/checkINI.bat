@echo off
setlocal enabledelayedexpansion
title Mbnq's INI Checker
REM mbnq00@gmail.com
REM https://www.mbnq.pl/

call :intro
echo.
echo - Starting

if not exist log.txt (
	echo - Creating new log file
	echo:>log.txt
) else (
	echo - Wiping log file
	echo:>log.txt
)

echo - Scanning...

for %%f in (*.ini) do (
    python checkINI.py "%%f" >> log.txt
)

echo Done.
type log.txt
goto :bye

:bye
	echo.
	echo Press any key to quit...
	pause > nul
endlocal	
exit

:sleep
	timeout /t 1 > nul
	exit /b

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
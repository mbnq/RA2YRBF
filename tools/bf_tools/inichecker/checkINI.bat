@echo off
setlocal enabledelayedexpansion
title Mbnq's INI Checker
REM mbnq00@gmail.com
REM https://www.mbnq.pl/

set logfile=log.txt
set pyScript=checkINI.py

call :intro
echo.
echo - Starting

if not exist %logfile% (
	echo - Creating new log file
	call :logHeader
) else (
	echo - Wiping log file
	call :logHeader
)

echo - Scanning...

for %%f in (*.ini) do (
    python %pyScript% "%%f" >> %logfile%
)

echo Done.
type %logfile%
echo.
choice /C YN /M "- Do you want to open log file? (Y/N)"
if %errorlevel% equ 1 (
	start %logfile%
)

goto :byewithexit

:bye
	echo.
	echo Press any key to quit...
	pause > nul
endlocal	
exit

:logHeader
	echo _______________________________>%logfile%
	echo:%date% %time%>>%logfile%
	echo _______________________________>>%logfile%
	echo.>>%logfile%
	exit /b
	
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
	
:byewithexit
	exit
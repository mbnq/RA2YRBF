@echo off
setlocal enabledelayedexpansion
title Mbnq's Brute Force CleanUP
REM mbnq00@gmail.com
REM https://www.mbnq.pl/

call :intro
if exist ".gitattributes" (echo:Warning^^! detected repo files^^!)&&(goto bye)
echo:This script will cleanup current folder from not needed files.
echo:Press any key twice to continue...
(pause > nul&&pause > nul)

echo:proceeding...
for %%i in (*.log *.txt *.doc *.mmx *.yro) do (
    del /f "%%i"
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

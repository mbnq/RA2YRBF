@echo off
title Mbnq's Brute Force Launcher
REM mbnq00@gmail.com
cls
	echo:ллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
	echo:л                                                       л
	echo:л  Command ^& Conquer Yuri^'s Revenge - Brute Force Mod   л
	echo:л                                        mbnq.pl 2024   л
	echo:л                                                       л	
	echo:л  This is an alternative launcher.                     л
	echo:л  Using BF_LAUNCHER.EXE is recommended.                л
	echo:л                                                       л
	echo:ллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
	echo:
	
IF NOT exist yuri.exe goto 0x000000
echo:Starting the game...

Syringe "gamemd.exe" %* -NOLOGO -b=38 -mb12,14
goto bye

:0x000000

	echo:
	echo:Game files can not be found !
	echo:
	echo:Place me ^(bf_launcher.bat^) in your Yuri's Revenge dir
	echo:^(in folder with yuri.exe^) first !
	echo:
	echo:
	echo:press any key to quit...
	pause > nul
	goto bye

:bye
exit
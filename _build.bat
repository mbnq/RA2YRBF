@echo off
chcp 65001 > nul
cls

echo:Removing old mix files if needed...&&echo:
	if exist "expandmd70.mix" del /q /f "expandmd70.mix"
	if exist "expandmd71.mix" del /q /f "expandmd71.mix"
	if exist "expandmd72.mix" del /q /f "expandmd72.mix"
	if exist "expandmd73.mix" del /q /f "expandmd73.mix"
	echo:&&	timeout /t 1 > nul
	
echo:Compiling mix files...&&echo:

for /f "tokens=*" %%f in ('dir "MIX\" /a:d /b') do (
	echo Compiling %%f.mix...&&echo:
	Tools\ccmix\ccmix.exe --create --lmd --game=ts --dir "MIX\%%f" --mix "%%f.mix"
	echo.
	)

set tmp=%0
echo:Done. Check mix files in [%tmp:~1,-11%] folder.&&echo:
echo:Press any key to exit...
pause > nul

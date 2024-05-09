@echo off
chcp 65001 > nul
cls

echo:Removing old mix files if needed...&&echo:
	for %%f in (expandmd70.mix expandmd71.mix expandmd72.mix expandmd73.mix) do (
		if exist "%%f" del /f "%%f"
	)
	echo:&&	timeout /t 2 > nul
	
echo:Compiling mix files...&&echo:

for /f "tokens=*" %%f in ('dir "MIX\" /a:d /b') do (
	echo Compiling %%f.mix...&&echo:
	Tools\ccmix\ccmix.exe --create --lmd --game=ra2 --dir "MIX\%%f" --mix "%%f.mix"
	echo.
	)

set tmp=%0
echo:Done. Check mix files in [%tmp:~1,-11%] folder.&&echo:
echo:Press any key to exit...
pause > nul

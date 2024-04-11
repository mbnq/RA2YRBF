@echo off
chcp 65001 > nul

echo Compiling mix files...

for /f "tokens=*" %%f in ('dir "MIX\" /a:d /b') do (
	echo Compiling %%f.mix...
	Tools\ccmix\ccmix.exe --create --lmd --game=ts --dir "MIX\%%f" --mix "%%f.mix"
	echo.
	)

set tmp=%0
echo Done. Check mix files in [%tmp:~1,-11%] folder.
pause

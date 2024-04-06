@echo off
chcp 65001 > nul
echo Compiling mix archives...
Tools\make.exe -f Tools\makefile
echo.
echo Done.
pause

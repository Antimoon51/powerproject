@echo off
echo NOTE: pleas be aware, that this programm ony works for up to 9 devices enabled to wake the PC.
echo To see wich devices are enabled right now open a command prompt and type 'powercfg devicequery wake_armed'
echo.
echo I do not take responsibility for any computers being harmed!
echo Use of the programm on own risk!
pause
cls
setlocal EnableDelayedExpansion
echo The following devices are able to wake your PC:
SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`powercfg devicequery wake_armed`) DO (
  SET h=%%F
  echo [!count!] !h!
  SET var!count!=!h!
  SET /a count+=1
)
pause


Endlocal
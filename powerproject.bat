@echo off
echo NOTE: pleas be aware, that this programm ony works for up to 9 devices enabled to wake the PC.
echo To check how many devices are enabled right now open a command prompt and type 'powercfg devicequery wake_armed'
echo.
echo I do not take responsibility for any computers being harmed!
echo Use of the programm on own risk!
pause
cls
SETLOCAL ENABLEDELAYEDEXPANSION
SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`powercfg devicequery wake_armed`) DO (
  SET var!count!=%%F
  SET /a count=!count!+1
)
echo The following devices are able to wake your PC:
echo 1: %var1%
if "%var2%" GTR "0" (
	echo 2: %var2%
) else (
	goto ende
)
if "%var3%" GTR "0" (
	echo 3: %var3%
) else (
	goto ende
)
if "%var4%" GTR "0" (
	echo 4: %var4%
) else (
	goto ende
)
if "%var5%" GTR "0" (
	echo 5: %var5%
) else (
	goto ende
)
if "%var6%" GTR "0" (
	echo 6: %var6%
) else (
	goto ende
)
if "%var7%" GTR "0" (
	echo 7: %var7%
) else (
	goto ende
)
if "%var8%" GTR "0" (
	echo 8: %var8%
) else (
	goto ende
)
if "%var9%" GTR "0" (
	echo 9: %var9%
) else (
	goto ende
)
:ende
echo wich one of these devices would you like to disable waking your PC?
echo please type just one number at a time or the string 'all', if you wish to disable them all.
echo if you wish to end the programm type 'end'.
set /p string=number:
:else
if %string% == end (goto finish)
REM if %string% == all 
if %string% == 1 (powercfg /DEVICEDISABLEWAKE "%var1%")
if %string% == 2 (powercfg /DEVICEDISABLEWAKE "%var2%")
if %string% == 3 (powercfg /DEVICEDISABLEWAKE "%var3%")
if %string% == 4 (powercfg /DEVICEDISABLEWAKE "%var4%")
if %string% == 5 (powercfg /DEVICEDISABLEWAKE "%var5%")
if %string% == 6 (powercfg /DEVICEDISABLEWAKE "%var6%")
if %string% == 7 (powercfg /DEVICEDISABLEWAKE "%var7%")
if %string% == 8 (powercfg /DEVICEDISABLEWAKE "%var8%")
if %string% == 9 (powercfg /DEVICEDISABLEWAKE "%var9%")
set /p string=and else?:
goto else
ENDLOCAL
pause
:finish
return 0
exit
@echo off
echo This programm shows you the devices, enabled to wake the PC up.
echo Please be aware, that this is not developed by profesionals, but in my free time.
echo.
echo DISCLAIMER:
echo I do not take responsibility for any computers being harmed!
echo Use of the programm on own risk!
pause
cls
setlocal EnableDelayedExpansion
echo The following devices are able to wake your PC:
:return
SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`powercfg devicequery wake_armed`) DO (
  SET h=%%F
  echo [!count!] !h!
  SET var!count!=!h!
  SET /a count+=1
)
pause
echo errorlevel: %errorlevel%
echo Type the number of the device you like to disable.
echo To abort type 'end'
set /p string=Disable this Device:
if "%string%"=="end" (
	goto exit
)
echo Device to disable: %string%
set count=1

pause
FOR /F "tokens=* USEBACKQ" %%N IN (`powercfg devicequery wake_armed`) DO (
	set x=%%N
	goto if
	:back
	set /a count+=1
)
goto return
:if
if "!count!"=="!string!" (
	powercfg devicedisablewake "!x!"
	goto back
)
pause
:exit
echo errorlevel: %errorlevel%
pause

Endlocal
exit 
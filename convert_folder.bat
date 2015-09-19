@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set srcdir=%~1\
set destdir=%~dp1%~nx1_converted\

echo %srcdir%
echo %destdir%
set /p ok="Is them ok? (Y/N)"
if !ok!==N exit
if !ok!==n exit

set /p del="Delete copied dds files after convert? (Y/N)"

set /p rec="Make the conversion recursively? (Y/N)"

set dorec=false
if !rec!==y set dorec=true
if !rec!==Y set dorec=true

rem copy the dds files with the folder structure
if !dorec!==true xcopy "%srcdir%*.dds" "%destdir%" /c /s /r /d /y /i /q

rem copy the dds files only one folder deep
if !dorec!==false xcopy "%srcdir%*.dds" "%destdir%" /c /r /d /y /i /q

rem flush log
break > %~dp0\convert_log.txt

rem convert the dds files to tga
for /r %destdir% %%i in (*.dds) do ( 
	set file=%%~ni
	echo [!TIME!] Converting: !file!
	%~dp0\readdxt.exe "%%i"
	echo [!TIME!] Converted: %%i >> %~dp0\convert_log.txt
)

for /r %destdir% %%i in (*.tga) do (

    set path=%%~dpi
    set tmp=%%~nxi
    set nn=%%~ni
	rem delete unwanted tga files (*01.tga, *02.tga...) 
    if not !tmp:~-6!==00.tga (
		del %%i 
		echo [!TIME!] Deleted: !tmp! >> %~dp0\convert_log.txt
	)
    if !tmp:~-6!==00.tga (
		rem rename converted tga to match the dds (remove 00 postfix)
		ren !path!!nn!.tga !nn:~0,-2!.tga
		rem remove copied dds file
		if !del!==y del !path!!nn:~0,-2!.dds
		if !del!==Y del !path!!nn:~0,-2!.dds

		echo [!TIME!] Clean up: !nn:~0,-2!.tga
		echo [!TIME!] Clean up: !path!!nn:~0,-2!.tga >> %~dp0\convert_log.txt
    )
	
)

echo [!TIME!] Convert process READY >> %~dp0\convert_log.txt
echo [!TIME!] Convert process READY

pause
exit
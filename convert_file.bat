@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set "params=!cmdcmdline:~0,-1!"
set "params=!params:*" =!"

for %%N IN (!params!) do (
	set fdir=%%~dpN
	set name=%%~nN
	set ext=%%~xN
	
	if NOT !ext!==.dds echo !name! - Not a dds file
	
	rem convert the dds files to tga
	if !ext!==.dds (
		set file=%%~nN
		echo [!TIME!] Converting: !file!
		%~dp0\readdxt.exe "%%N"
		echo [!TIME!] Converted: %%N >> %~dp0\convert_log.txt
	)
)

rem delete unwanted tga files (*01.tga, *02.tga...) 
for %%i in (!fdir!*.tga) do (
	set path=%%~dpi
	set tmp=%%~nxi
	set nn=%%~ni
	
	if not !tmp:~-6!==00.tga (
		del %%i 
		echo [!TIME!] Deleted: !tmp! >> %~dp0\convert_log.txt
	)
	if !tmp:~-6!==00.tga (
		ren !path!!nn!.tga !nn:~0,-2!.tga
	)
)

echo [!TIME!] Convert process READY

pause
exit
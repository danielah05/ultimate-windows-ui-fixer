@echo off
if exist "C:\dos" goto cdosskip
if exist "files" goto folderskip
:: create files folder
echo creating files folder
mkdir files
:folderskip
if exist "files\dos.bat" goto dosskip
:: create dos.bat
echo creating dos.bat
echo start kill.vbs > "files\dos.bat"
echo for /f "tokens=4-5 delims=. " %%%%i in ('ver') do set VERSION=%%%%i.%%%%j >> "files\dos.bat"
echo for /f "tokens=4-5 delims=[.XP " %%%%i in ('ver') do set WINXPVERSION=%%%%i.%%%%j >> "files\dos.bat"
echo if "%%winxpversion%%" == "5.2 " goto winxpsupport >> "files\dos.bat"
echo if "%%winxpversion%%" == "5.1 " goto winxpsupport >> "files\dos.bat"
echo start cmd /k "setup-path.bat & cd C:\WINDOWS & cls & echo. & echo Microsoft(R) Windows %%version%% & echo    (C)Copyright Microsoft Corp 1981-2021. & echo. & echo    Batch Script by danielah05 (@flstudiodemo)" >> "files\dos.bat"
echo goto end >> "files\dos.bat"
echo :winxpsupport >> "files\dos.bat"
echo start cmd /k "setup-path.bat & cd C:\WINDOWS & cls & echo. & echo Microsoft(R) Windows %%winxpversion%% & echo    (C)Copyright Microsoft Corp 1981-2021. & echo. & echo    Batch Script by danielah05 (@flstudiodemo)" >> "files\dos.bat"
echo goto end >> "files\dos.bat"
echo :end >> "files\dos.bat"
:dosskip
if exist "files\kill.vbs" goto vbsskip
:: create kill.vbs
echo creating kill.vbs
echo Do > "files\kill.vbs"
echo 	Set wmi = GetObject("winmgmts:") >> "files\kill.vbs"
echo 	Set cmdProcess = wmi.ExecQuery("select * from Win32_Process Where Name='cmd.exe'") >> "files\kill.vbs"
echo 	Set explorerProcess = wmi.ExecQuery("select * from Win32_Process Where Name='explorer.exe'") >> "files\kill.vbs"
echo 	If cmdProcess.Count ^< 1 Then >> "files\kill.vbs"
echo 		CreateObject("WScript.Shell").Run("exit-dos.bat")  >> "files\kill.vbs"
echo 	End If >> "files\kill.vbs"
echo 	If explorerProcess.Count ^> 0 Then >> "files\kill.vbs"
echo 		CreateObject("WScript.Shell").Run("stop.bat")  >> "files\kill.vbs"
echo 	End If >> "files\kill.vbs"
echo     WScript.Sleep 1000 >> "files\kill.vbs"
echo Loop >> "files\kill.vbs"
:vbsskip
if exist "files\stop.bat" goto stopskip
:: create stop.bat
echo creating stop.bat
echo taskkill /f /im explorer.exe > "files\stop.bat"
:stopskip
if exist "files\exit-dos.bat" goto exitdosskip
:: create exit-dos.bat
echo shutdown -s -f -t 00 > "files\exit-dos.bat"
:exitdosskip
if exist "files\setup-path.bat" goto setuppathskip
:: create setup-path.bat
echo set "PATH=%%PATH%%;C:\dos\global\" > "files\setup-path.bat"
:setuppathskip
if exist "dos" goto dosrenskip
:: rename files to dos
ren files dos
:dosrenskip
if exist "dos\global" goto dosglobalskip
:: make global folder
mkdir dos\global
:dosglobalskip
if exist "dos\global\7za.exe" goto dosglobal7zaskip
:: copy 7zip console to global folder
copy 7zip\* dos\global
:dosglobal7zaskip
if exist "C:\dos" goto cdosskip
:: move dos to c drive
move dos C:\
:cdosskip
for /f "tokens=4-5 delims=[.XP " %%i in ('ver') do set WINXPVERSION=%%i.%%j 
if "%winxpversion%" == "5.2 " goto winxpsupport
if "%winxpversion%" == "5.1 " goto winxpsupport
if exist "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\run-dos.bat" goto dosstartupskip
:: create run-dos.bat to start dos on startup
echo cd C:\dos > "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\run-dos.bat"
echo dos.bat >> "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\run-dos.bat"
:dosstartupskip
cd C:\dos
dos.bat
goto end
:winxpsupport
if exist "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\run-dos.bat" goto dosstartupskip
:: create run-dos.bat to start dos on startup
echo cd C:\dos > "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\run-dos.bat"
echo dos.bat >> "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\run-dos.bat"
cd C:\dos
dos.bat
goto end
:end
@echo off
taskkill /f /im wscript.exe
taskkill /f /im explorer.exe
timeout 1
rmdir /s /q "C:\dos"
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\run-dos.bat"
del /f /q "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\run-dos.bat"
start explorer.exe
cls
echo Successfully Uninstalled
pause
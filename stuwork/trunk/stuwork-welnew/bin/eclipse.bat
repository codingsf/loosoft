@echo off
echo [INFO] Use maven eclipse-plugin download jars and generate eclipse project files.
echo [Info] Please add "-Declipse.workspace=<path-to-eclipse-workspace>" at the end.

cd %~dp0
cd ..
call mvn eclipse:clean eclipse:eclipse -Declipse.workspace=E:\work\study\springside
cd bin
pause
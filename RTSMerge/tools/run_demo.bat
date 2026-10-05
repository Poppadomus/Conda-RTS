@echo off
setlocal
set "ROOT=%~dp0.."
set "SCRIPT=%ROOT%\demo_startscript.txt"

if defined RECOIL_ENGINE (
  set "ENGINE=%RECOIL_ENGINE%"
 ) else if exist "%ROOT%\recoil.exe" (
  set "ENGINE=%ROOT%\recoil.exe"
 ) else if exist "%ROOT%\spring.exe" (
  set "ENGINE=%ROOT%\spring.exe"
 ) else (
  where recoil.exe >nul 2>nul && set "ENGINE=recoil.exe"
  if not defined ENGINE where spring.exe >nul 2>nul && set "ENGINE=spring.exe"
 )

if not defined ENGINE (
  echo Recoil/Spring executable not found.
  echo Install Recoil, put recoil.exe in PATH, or set RECOIL_ENGINE.
  exit /b 1
 )

"%ENGINE%" "%SCRIPT%"

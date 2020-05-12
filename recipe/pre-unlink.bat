@echo off
setlocal enableextensions

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0uninstall_docker_service.ps1"
exit  %ERRORLEVEL%

@echo ooff
setlocal enableextensions

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install_docker_service.ps1" > "%PREFIX%/.messages.txt" 2>&1
exit  %ERRORLEVEL%

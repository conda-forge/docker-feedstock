setlocal enableextensions enabledelayedexpansion


xcopy %SRC_DIR%\docker %PREFIX%\Library\docker\ /E /F /Y
if %ERRORLEVEL% NEQ 0 goto FAIL

echo F | xcopy %RECIPE_DIR%\docker.cmd %PREFIX%\Scripts\docker.cmd /F /Y
if %ERRORLEVEL% NEQ 0 goto FAIL

echo F | xcopy %RECIPE_DIR%\dockerd.cmd %PREFIX%\Scripts\dockerd.cmd /F /Y
if %ERRORLEVEL% NEQ 0 goto FAIL

echo F | xcopy %RECIPE_DIR%\install_docker_service.ps1 %PREFIX%\Scripts\install_docker_service.ps1 /F /Y
if %ERRORLEVEL% NEQ 0 goto FAIL

echo F | xcopy %RECIPE_DIR%\uninstall_docker_service.ps1 %PREFIX%\Scripts\uninstall_docker_service.ps1 /F /Y
if %ERRORLEVEL% NEQ 0 goto FAIL

exit /B 0

:FAIL
echo Command failed with ERRORLEVEL %ERRORLEVEL%
exit /B 1
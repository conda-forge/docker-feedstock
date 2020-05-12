$ErrorActionPreference = 'Stop';


# Only uninstall the service if it was installed by conda
$svc = Get-CimInstance Win32_Service -Filter 'Name = "docker"'
if ($svc.Description -ne 'conda-docker') {
    Exit 0
}

Get-Service docker | Stop-Service

dockerd --unregister-service
exit $LASTEXITCODE

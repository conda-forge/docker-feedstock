$ErrorActionPreference = 'Stop';


# If the `Containers` feature is not already enabled a restart is required
dism /Online /Quiet /NoRestart /Enable-Feature /All /FeatureName:Containers

# Try creating a DockerUsers group if it doesn't already exist
$dockerArgs = @(
    '--register-service',
    '-H tcp://localhost:2375',
    '-H npipe://'
)
try {
    Get-LocalGroup -Name 'DockerUsers' -ErrorAction Stop;
    $dockerArgs += '-G DockerUsers'
} catch {
    try {
        New-LocalGroup -Name 'DockerUsers' -Description 'Members can talk to the docker daemon';
        $dockerArgs += '-G DockerUsers'
    } catch {}
}

# Create the 'docker' service
$proc = Start-Process dockerd.cmd -ArgumentList $dockerArgs -NoNewWindow -Wait -PassThru;
if ($proc.ExitCode -ne 0) {
    Write-Host "WARNING: Couldn't create the service!"
    Write-Host $proc.StandardError
    Exit 0
}
# Tag the service so conda know whether or not to uninstall it
Set-Service docker -Description 'conda-docker'

try {
    Start-Service docker
} catch {
    Write-Host "WARNING: The docker service didn't start! A reboot may be required."
}

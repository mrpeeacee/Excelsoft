$serviceName = "UserSyncExcelearn"  # Replace with the actual name of the service

while ($true) {
    $service = Get-Service -Name $serviceName
    if ($service.Status -ne "Running") {
        Write-Host "Service '$serviceName' is not running. Starting the service..."
        Start-Service -Name $serviceName
    }
    
    Start-Sleep -Seconds 60  # Sleep for 2 minutes before checking again
}

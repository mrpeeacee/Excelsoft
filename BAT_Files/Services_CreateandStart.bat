# Define service parameters for the first service
$service1 = @{
    Name = "CronJobStatusService"
    Path = "D:\Project\Scheduler_Tasks\CronJobStatusService\SchedulerTasksService.exe"
    DisplayName = "CronJobStatusService"
    Description = "This is the first custom Windows service created using PowerShell."
	ServiceAccount = "mdirect\Admin"
    Password = "Mysore2019@21"
}

# Define service parameters for the second service
$service2 = @{
    Name = "SEAB_eMarking_RCScheduler"
    Path = "D:\Project\eMarking_RC_job\Saras.eMarking.RCScheduler.Server.exe"
    DisplayName = "SEAB_eMarking_RCScheduler"
    Description = "This is the second custom Windows service created using PowerShell."
    ServiceAccount = "mdirect\seabproduser$"
    Password = $null  # No password required for service account
}

# Function to create a service
function Create-Service {
    param (
        [string]$Name,
        [string]$Path,
        [string]$DisplayName,
        [string]$Description,
        [string]$ServiceAccount = $null,
        [string]$Password = $null
    )

    try {
        # Check if the service already exists
        if (Get-Service -Name $Name -ErrorAction SilentlyContinue) {
            Write-Output "Service '$Name' already exists. Attempting to stop and remove it first."

            # Stop the existing service
            Stop-Service -Name $Name -Force -ErrorAction Stop
            Write-Output "Service '$Name' stopped successfully."

            # Remove the existing service
            sc.exe delete $Name
            Start-Sleep -Seconds 5
            Write-Output "Service '$Name' removed successfully."
        }

        # Create the new service
        New-Service -Name $Name -BinaryPathName $Path -DisplayName $DisplayName -Description $Description -StartupType Automatic -ErrorAction Stop
        Write-Output "Service '$Name' created successfully."

        # If a service account is specified, configure the service to run under that account
        if ($ServiceAccount) {
            $scCmd = "config $Name obj= $ServiceAccount"
            if ($Password) {
                $scCmd += " password= $Password"
            }
            Invoke-Expression "sc.exe $scCmd"
            Write-Output "Service '$Name' configured to run under account '$ServiceAccount'."
        }

        # Start the new service
        Start-Service -Name $Name -ErrorAction Stop
        Write-Output "Service '$Name' started successfully."
    } catch {
        Write-Output "Error creating service '$Name': $_" | Out-File -Append "C:\transcript.txt"
        Write-Error "Error creating service '$Name': $_"
    }
}

# Create the first service
Create-Service @service1

# Create the second service
Create-Service @service2

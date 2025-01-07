#Create a VD and deploy along with applciation pool
Import-Module WebAdministration

#create application pool
#New-WebAppPool -Name "MyAppPool"

$appPoolName = "MyAppPool"
New-WebAppPool -Name $appPoolName
$appPool = Get-Item "IIS:\AppPools\$appPoolName"
$appPool.processModel.identityType = 3
#$appPool.processModel.username = "someUser"
#$appPool.processModel.password = "somePassword"
$appPool.managedRuntimeVersion = "v4.0"
$appPool.managedPipeLineMode = "Integrated"
$appPool.idleTimeout = "0"



-------------------------------------------
Working code for application pool ( add for loop and add queue length value)

Import-Module WebAdministration	
$AppPoolName = "Visap"

# Retrieve the application pool object from IIS
$AppPool = Get-Item "IIS:\AppPools\$AppPoolName"

# Configure advanced settings
$appPool.processModel.idleTimeout = "0"
$AppPool.processModel.identityType = 3  # Use a specific user identity
$AppPool.processModel.username = "pooluser"  # Specify the username
$AppPool.processModel.password = "p00L!@#$"  # Specify the password
$AppPool.processModel.idleTimeout = [TimeSpan]::FromMinutes(0)  # Set the idle timeout to 20 minutes
$AppPool.recycling.periodicRestart.time = [TimeSpan]::FromMinutes(0)  # Set the periodic restart time to 12 hours
#$AppPool.recycling.periodicRestart.schedule.clear()  # Clear any existing restart schedule
#$AppPool.recycling.periodicRestart.schedule.add("01:00")  # Add a restart time of 1:00 AM daily
$AppPool.failure.rapidFailProtection = $true  # Enable rapid fail protection
$AppPool.failure.rapidFailProtectionInterval = [TimeSpan]::FromMinutes(1)  # Set the rapid fail interval to 5 minutes
$AppPool.failure.rapidFailProtectionMaxCrashes = 20  # Set the maximum number of crashes to 5

# Save the changes to the application pool object
$AppPool | Set-Item


===========================================================================
Working ( Add for loop and multiple )

#Create a VD and deploy along with applciation pool
Import-Module WebAdministration

#create application pool
New-WebAppPool -Name "Visap"

$AppPool = Get-Item "IIS:\AppPools\Visap"

Set-ItemProperty IIS:\AppPools\Visap -name managedRuntimeVersion -value v4.0
Set-ItemProperty IIS:\AppPools\Visap -name managedPipelineMode -value Integrated
Set-ItemProperty IIS:\AppPools\Visap -name enable32BitAppOnWin64 -value $false
Set-ItemProperty IIS:\AppPools\Visap -name queueLength -value 9000
Set-ItemProperty IIS:\AppPools\Visap -Name processModel.idleTimeout -Value ([TimeSpan]::FromMinutes(0))
Set-ItemProperty IIS:\AppPools\Visap -name startMode -value AlwaysRunning
Set-ItemProperty IIS:\AppPools\Visap -name recycling.periodicRestart.time -value ([TimeSpan]::FromMinutes(0))
Set-ItemProperty IIS:\AppPools\Visap -name failure.rapidFailProtectionInterval -Value ([TimeSpan]::FromMinutes(1))
Set-ItemProperty IIS:\AppPools\Visap -name failure.rapidFailProtectionMaxCrashes -Value 20


#Create Web application and assign custom application pool
New-WebApplication -Name "Visap" -Site "Default Web Site" -PhysicalPath "D:\Visap\ViSAP" -ApplicationPool "Visap"
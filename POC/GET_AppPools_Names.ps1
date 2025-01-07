Import-Module WebAdministration

# Get all application pools
$applicationPools = Get-ChildItem IIS:\AppPools

# Create an array to store the application pool names
$poolNames = @()

# Iterate through each application pool and retrieve its name
foreach ($appPool in $applicationPools) {
    $appPoolName = $appPool.Name
    $poolNames += $appPoolName
}

# Output the application pool names to a text file
$poolNames | Out-File -FilePath "D:\AppPools.txt"

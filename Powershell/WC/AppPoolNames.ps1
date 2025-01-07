# Import the WebAdministration module
Import-Module WebAdministration

# Get all application pools
$applicationPools = Get-ChildItem IIS:\AppPools

# Get application pool names
$poolNames = $applicationPools.Name

# Specify the file path for the output text file
$outputFilePath = "C:\Path\To\AppPools.txt"

# Output the application pool names to a text file
$poolNames | Out-File -FilePath $outputFilePath

# Remote server
$remoteServer = "Internet-RPweb1"

# Hardcoded username and password
$username = "admin"
$password = "Mysore2019@21" | ConvertTo-SecureString -AsPlainText -Force

# Create a PSCredential object
$credentials = New-Object System.Management.Automation.PSCredential($username, $password)

# Invoke command on the remote server to retrieve application pool names
$poolNames = Invoke-Command -ComputerName $remoteServer -ScriptBlock {
    param ()
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

    # Return the application pool names
    $poolNames
} -Credential $credentials  # You may need to provide credentials for remote access

# Output the application pool names to a text file
$poolNames | Out-File -FilePath "D:\AppPools.txt"


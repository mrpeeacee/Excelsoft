# Define your credentials for Nexus
$NexusUsername = "-8ZK2X65"
$NexusPassword = "FL9XOj3FldaLx-PR1_kZ94MvxRiv-eZTfm26lg-HmU1u"
$NexusCred = New-Object -TypeName PSCredential -ArgumentList $NexusUsername, (ConvertTo-SecureString $NexusPassword -AsPlainText -Force)

# Define your credentials for the network share
$NetworkUsername = "excelindia\sarasbuilder"  # Your network username
$NetworkPassword = "Bu!d!@#$"  # Your network password
$NetworkCred = New-Object -TypeName PSCredential -ArgumentList $NetworkUsername, (ConvertTo-SecureString $NetworkPassword -AsPlainText -Force)

# Define the base URI for uploads
$baseUri = "https://nexus.ship.gov.sg/repository/seab-eexam2-Package/18SEP2024/"

# List of file paths to upload (using network share paths)
$filesToUpload = @(
    "\\10.10.2.63\d$\Workspace\MOE-SEAB-R3-UAT\ReleaseEngineeringINC\UAT_INC_Package\DataAnalytics_12092024.zip",
    "\\10.10.2.63\d$\Workspace\MOE-SEAB-R3\ReleaseEngineeringINC\cloudpackage\cloudpackage_mohan_13092024.zip",
    "\\10.10.2.63\d$\Workspace\MOE-SEAB\ReleaseEngineeringINC_CLOUD\CloudINCBuild.zip"
)

# Map the network drive
$networkDrive = "Z:"
New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\10.10.2.63\d$" -Credential $NetworkCred -Persist

# Loop through each file
foreach ($filePath in $filesToUpload) {
    # Adjust file path to use the mapped drive
    $mappedFilePath = $filePath -replace '\\10.10.2.63\d$', 'Z:'

    # Check if the file exists
    if (Test-Path -Path $mappedFilePath) {
        # Construct the target URI by appending the file name
        $fileName = [System.IO.Path]::GetFileName($mappedFilePath)
        $targetUri = $baseUri + $fileName

        try {
            # Use Invoke-WebRequest to upload the file
            Invoke-WebRequest -Uri $targetUri `
                -Method Put `
                -InFile $mappedFilePath `
                -Credential $NexusCred `
                -UseBasicParsing

            Write-Host "Uploaded: $mappedFilePath to $targetUri" -ForegroundColor Green
        } catch {
            Write-Host "Failed to upload: $mappedFilePath. Error: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "File not found: $mappedFilePath" -ForegroundColor Yellow
    }
}

# Clean up the mapped drive
Remove-PSDrive -Name "Z" -Force

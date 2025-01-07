$folderPath = "D:\NOW"
$folderName = "NOW"
$path = "D:"
$userNames = @("Administrators", "IIS_IUSRS", "IUSR", "NETWORK", "NETWORK SERVICE")
$permission = "F"

# Get the current date in the "yyyy-MM-dd" format
$dateString = (Get-Date).ToString("yyyy-MM-dd")

# Check if the folder exists
if (!(Test-Path -Path $path)) {
    # Create new folder if it does not exist
    New-Item -ItemType Directory -Path "$path"
} else {
    # Rename old folder if it exists
    if (Test-Path -Path "$path\$folderName") {
        Rename-Item -Path "$path\$folderName" -NewName "NOW_$dateString"
    }
}
# Create new folder
New-Item -ItemType Directory -Path "$path\$folderName" -force

#permission to folder and its files
foreach ($userName in $userNames) 
{
	icacls $folderPath /grant ${userName}:"(OI)(CI)F" /t

    #icacls $folderPath /grant "${userName}:${permission}" /t
}

#$subFolderPath = "D:\Project\Corp"
#icacls $subFolderPath /inheritance:r



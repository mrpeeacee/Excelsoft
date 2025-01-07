# Set the file path and backup folder path
$FilePath = "C:\Path\To\Your\File.txt"
$BackupFolder = "C:\Path\To\Your\BackupFolder"

# Get the current date and format it
$CurrentDate = Get-Date -Format "yyyy_MM_dd"

# Construct the backup file name with the current date
$BackupFileName = "Backup_$CurrentDate.zip"
$BackupFilePath = Join-Path -Path $BackupFolder -ChildPath $BackupFileName

# Create a zip file containing the backup
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($FilePath, $BackupFilePath)

# Move the original file to the backup folder
$BackupFile = Join-Path -Path $BackupFolder -ChildPath (Split-Path -Path $FilePath -Leaf)
Move-Item -Path $FilePath -Destination $BackupFile

Write-Host "Backup created and file moved to backup folder."

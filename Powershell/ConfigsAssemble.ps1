# Define the source and destination root directories
$sourceRoot = "D:\Workspace\TQUKDev"
$destinationRoot = "D:\Workspace\TQUKDev\ReleaseEngineering\Test"

# Get all web.config files recursively from the source directory
$sourceFiles = Get-ChildItem -Path $sourceRoot -Filter "web.config" -Recurse

foreach ($file in $sourceFiles) {
    # Build the destination path by replacing the source root with the destination root
    $destinationPath = $file.FullName -replace [regex]::Escape($sourceRoot), $destinationRoot

    # Create the destination directory if it doesn't exist
    $destinationDirectory = Split-Path -Path $destinationPath
    if (-not (Test-Path -Path $destinationDirectory)) {
        New-Item -Path $destinationDirectory -ItemType Directory -Force
    }

    # Copy the file to the destination
    Copy-Item -Path $file.FullName -Destination $destinationPath -Force
}

Write-Host "Copying web.config files completed."

# Define the root directory to start the search
$rootDirectory = "D:\Project\MOE"

# Define the output file path
$outputFile = "D:\Project\MOE\LogFolders.txt"

# Initialize an array to store the log folder paths
$logFolderPaths = @()

# Recursively search for folders named "log"
$logFolders = Get-ChildItem -Path $rootDirectory -Recurse -Directory -Filter "log"

# Add each found log folder path to the array
foreach ($logFolder in $logFolders) {
    $logFolderPaths += $logFolder.FullName
}

# Output the log folder paths to the text file
$logFolderPaths | Out-File -FilePath $outputFile

Write-Host "Log folder paths have been written to $outputFile"

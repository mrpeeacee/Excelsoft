$remoteServer = "Internet-RPweb1"
$folders = @("eOral", "eORALTryOut")
$BaseFolderPath = "D:\Project\MOE"

# Define the script block to be executed on the remote server
$scriptBlock = {
    param($folders, $BaseFolderPath)

    foreach ($folder in $folders) {
        $folderPath = Join-Path -Path $BaseFolderPath -ChildPath $folder

        if (Test-Path -Path $folderPath -PathType Container) {
            # Delete the contents of the assets folder excluding app-config.json
            $assetsFolderPath = Join-Path -Path $folderPath -ChildPath "assets"
            Get-ChildItem -Path $assetsFolderPath -Recurse | Where-Object { $_.Name -ne "app-config.json" } | Remove-Item -Force -Recurse

            # Delete the contents of the folder excluding web.config and assets folder
            Get-ChildItem -Path $folderPath -Exclude ("web.config", "assets") | Remove-Item -Force -Recurse
        }
        else {
            Write-Host "Folder not found: $folderPath"
        }
    }
}

# Invoke the script block on the remote server
Invoke-Command -ComputerName $remoteServer -ScriptBlock $scriptBlock -ArgumentList $folders, $BaseFolderPath

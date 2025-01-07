#SoftwaresInstallation
# Define the software packages to install
$softwarePackages = @{
    "7zip" = "https://www.7-zip.org/a/7z2201-x64.exe"
    "Chrome" = "https://dl.google.com/chrome/install/standalone/enterprise/GoogleChromeStandaloneEnterprise64.msi"
    "Notepad++" = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.2/npp.8.5.2.Installer.x64.exe"
	"dotnet4.8" = "https://go.microsoft.com/fwlink/?linkid=2088631"
}

# Download and install each software package
foreach ($softwareName in $softwarePackages.Keys) {
    $softwareUrl = $softwarePackages[$softwareName]
    $softwareExe = "$env:TEMP\$softwareName.exe"

    Write-Host "Downloading $softwareName from $softwareUrl..."
    Invoke-WebRequest -Uri $softwareUrl -OutFile $softwareExe

    Write-Host "Installing $softwareName..."
    Start-Process -FilePath $softwareExe -ArgumentList "/S" -Wait
}

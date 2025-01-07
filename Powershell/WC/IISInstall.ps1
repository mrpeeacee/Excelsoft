Import-Module WebAdministration -ErrorAction SilentlyContinue

# IIS Installation
Set-ExecutionPolicy Bypass -Scope Process
Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools
get-windowsoptionalfeature -online -featurename IIS-FTP* | disable-windowsoptionalfeature -online -norestart
Get-WindowsFeature -Name Net-* | Install-WindowsFeature
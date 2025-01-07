Import-Module WebAdministration
Import-Module ServerManager

New-Item IIS:\AppPools\MyAppPool -Force
New-WebApplication IIS:\Sites\DefaultWebSite\App1 -physicalPath D:\TrialnError\Powershell\IIS\App1 -Force
New-WebApplication IIS:\Sites\DefaultWebSite\App2 -physicalPath D:\TrialnError\Powershell\IIS\App2 -Force

Set-ItemProperty IIS:\AppPools\MyAppPool -name managedRuntimeVersion -value v4.0
Set-ItemProperty IIS:\AppPools\MyAppPool -name managedPipelineMode -value Integrated
Set-ItemProperty IIS:\AppPools\MyAppPool -name enable32BitAppOnWin64 -value $false
Set-ItemProperty IIS:\AppPools\MyAppPool -name idleTimeout -Value ([TimeSpan]::FromMinutes(0))
Set-ItemProperty IIS:\AppPools\MyAppPool -name IdleTime-out -value 0

Set-ItemProperty IIS:\Sites\DefaultWebSite\App1 -name applicationPool -value MyAppPool
Set-ItemProperty IIS:\Sites\DefaultWebSite\App2 -name applicationPool -value MyAppPool
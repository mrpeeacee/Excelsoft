#Create a VD and deploy along with applciation pool
Import-Module WebAdministration

#create application pool
New-WebAppPool -Name "Visap"

Set-ItemProperty IIS:\AppPools\Visap -name managedRuntimeVersion -value v4.0
Set-ItemProperty IIS:\AppPools\Visap -name managedPipelineMode -value Integrated
Set-ItemProperty IIS:\AppPools\Visap -name enable32BitAppOnWin64 -value $true
Set-ItemProperty IIS:\AppPools\Visap -name queueLength -value 9000
Set-ItemProperty IIS:\AppPools\Visap -Name processModel.idleTimeout -Value ([TimeSpan]::FromMinutes(0))
Set-ItemProperty IIS:\AppPools\Visap -name startMode -value AlwaysRunning


#Create Web application and assign custom application pool
New-WebApplication -Name "Visap" -Site "Default Web Site" -PhysicalPath "D:\Visap\ViSAP" -ApplicationPool "Visap"
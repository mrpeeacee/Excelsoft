#Create a VD and deploy along with applciation pool
Import-Module WebAdministration

#create application pool
New-WebAppPool -Name "Visap"

Set-ItemProperty IIS:\AppPools\MyAppPool -name managedRuntimeVersion -value v4.0
Set-ItemProperty IIS:\AppPools\MyAppPool -name managedPipelineMode -value Integrated
Set-ItemProperty IIS:\AppPools\MyAppPool -name enable32BitAppOnWin64 -value $false

#Create Web application and assign custom application pool
New-WebApplication -Name "Visap" -Site "Default Web Site" -PhysicalPath "D:\Visap\ViSAP" -ApplicationPool "Visap"
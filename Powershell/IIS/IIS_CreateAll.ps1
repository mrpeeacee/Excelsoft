Import-Module WebAdministration
Import-Module ServerManager
#Install-WindowsFeature
#Import-Module WindowsFeature
#Add-WindowsFeature Web-Scripting-Tools

New-Item IIS:\AppPools\MyAppPool
#New-Item IIS:\Sites\Default Web Site -bindings @{protocol=&quot;http=&quot;;bindingInformation="&quot";*:80:"&quot";} -physicalPath C:\inetpub\wwwroot\MySite
New-Item IIS:\Sites\Default Web Site -physicalPath C:\inetpub\wwwroot
New-Item IIS:\Sites\Default Web Site\App1 -physicalPath C:\inetpub\wwwroot\MySite\App1
New-Item IIS:\Sites\Default Web Site\App2 -physicalPath C:\inetpub\wwwroot\MySite\App2

Set-ItemProperty IIS:\AppPools\MyAppPool -name managedRuntimeVersion -value v4.0
Set-ItemProperty IIS:\AppPools\MyAppPool -name managedPipelineMode -value Integrated
Set-ItemProperty IIS:\AppPools\MyAppPool -name enable32BitAppOnWin64 -value $false
Set-ItemProperty IIS:\AppPools\MyAppPool -name QueueLength -value 9000
Set-ItemProperty IIS:\AppPools\MyAppPool -name IdleTime-out -value 0

Set-ItemProperty IIS:\Sites\Default Web Site\App1 -name applicationPool -value MyAppPool
Set-ItemProperty IIS:\Sites\Default Web Site\App2 -name applicationPool -value MyAppPool


#New-Item IIS:\Sites\Default Web Site -bindings @{protocol=&quot;http=&quot;;bindingInformation="&quot";*:80:"&quot";} -physicalPath C:\inetpub\wwwroot\MySite
#Install-WindowsFeature
#Import-Module WindowsFeature
#Add-WindowsFeature Web-Scripting-Tools
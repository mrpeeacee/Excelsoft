Import-Module WebAdministration

#creating physical path MOE
New-Item -Path D:\Project\MOE\eORAL -ItemType Directory -Force
New-Item -Path D:\Project\MOE\ELC -ItemType Directory -Force
New-Item -Path D:\Project\MOE\TestPlayer -ItemType Directory -Force
New-Item -Path D:\Project\MOE\TestPrepAdmin -ItemType Directory -Force

#creating Apppools
$ApplicationPoolNames=@("MOE","eORAL","ELC","Testplayer","TestPrepAdmin")
$user=@("")
#$pwd=@("")

ForEach ($ApplicationPool in $ApplicationPoolNames)
{
New-Item IIS:\AppPools\$ApplicationPool -Force
}
ForEach ($ApplicationPool in $ApplicationPoolNames)
 {
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name enable32BitAppOnWin64 -value false
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name queueLength -value 65535
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name startMode -value AlwaysRunning
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name processModel.idleTimeout -Value ([TimeSpan]::FromMinutes(0)) 
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name recycling.periodicRestart.time -Value ([TimeSpan]::FromMinutes(0))
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name processModel -value @{userName="$user";password="";identitytype=3} 
   
   }
#creating VD's
New-WebApplication -Name "MOE" -Site "Default Web Site" -PhysicalPath "D:\Project\MOE" -ApplicationPool "MOE" -Force
New-WebApplication -Name "eORAL" -Site "Default Web Site\MOE" -PhysicalPath "D:\Project\MOE\eORAL" -ApplicationPool "eORAL" -Force
New-WebApplication -Name "ELC" -Site "Default Web Site\MOE" -PhysicalPath "D:\Project\MOE\ELC" -ApplicationPool "ELC" -Force
New-WebApplication -Name "Testplayer" -Site "Default Web Site\MOE" -PhysicalPath "D:\Project\MOE\Testplayer" -ApplicationPool "Testplayer" -Force
New-WebApplication -Name "TAAdmin" -Site "Default Web Site\MOE" -PhysicalPath "D:\Project\MOE\TestPrepAdmin" -ApplicationPool "TestPrepAdmin" -Force
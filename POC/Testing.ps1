Import-Module WebAdministration

#creating Apppools
$ApplicationPoolNames=@("MOE","eORAL","ELC","Testplayer","TestPrepAdmin","EMS")

ForEach ($ApplicationPool in $ApplicationPoolNames)
{
New-Item IIS:\AppPools\$ApplicationPool -Force

}


ForEach ($ApplicationPool in $ApplicationPoolNames)
 {
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name enable32BitAppOnWin64 -value True
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name queueLength -value 65535
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name startMode -value AlwaysRunning 
   
   }

   if(Test-Path IIS:\AppPools\$ApplicationPoolNames)
{
"AppPool is already there"
return $true;
else
{
"AppPool is not present"
"Creating new AppPool"
return $false;
}

Import-Module WebAdministration

# reusable variables

$folderPath = "D:\Project\MOE"
$folderName = "MOE"
$path = "D:\Project"
$userNames = @("Administrators", "IIS_IUSRS", "IUSR", "NETWORK", "NETWORK SERVICE")
$permission = "F"

# Get the current date in the "yyyy-MM-dd" format

$dateString = (Get-Date).ToString("yyyy-MM-dd")

# Check if the folder exists

if (!(Test-Path -Path $path)) {
    # Create new folder if it does not exist
    New-Item -ItemType Directory -Path "$path"
	Write-Host "New directory $folderName created."
} else {
    # Rename old folder if it exists
    if (Test-Path -Path "$path\$folderName") {
        Rename-Item -Path "$path\$folderName" -NewName "MOE_$dateString"
		Write-Host "Directory $folderName renamed."
    }
}
# Create new folder
New-Item -ItemType Directory -Path "$path\$folderName" -force
Write-Host "Renamed directory and new $folderName directory created."

#creating physical path for VD's
New-Item -Path D:\Project\MOE\eORAL -ItemType Directory -Force
New-Item -Path D:\Project\MOE\ELC -ItemType Directory -Force
New-Item -Path D:\Project\MOE\TestPlayer -ItemType Directory -Force
New-Item -Path D:\Project\MOE\TestPrepAdmin -ItemType Directory -Force
Write-Host "Physical path created."

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
  Set-ItemProperty "IIS:\AppPools\$ApplicationPool" -Name "failure.rapidFailProtection" -Value $false
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -Name failure -Value @{ rapidFailProtectionInterval = "00:01:00"; rapidFailProtectionMaxCrashes = 20 }
    }
	
Write-Host "Apppools $ApplicationPoolNames  created."
	
#creating VD's
New-WebApplication -Name "MOE" -Site "Default Web Site" -PhysicalPath "D:\Project\MOE" -ApplicationPool "MOE" -Force
New-WebApplication -Name "eORAL" -Site "Default Web Site\MOE" -PhysicalPath "D:\Project\MOE\eORAL" -ApplicationPool "eORAL" -Force
New-WebApplication -Name "ELC" -Site "Default Web Site\MOE" -PhysicalPath "D:\Project\MOE\ELC" -ApplicationPool "ELC" -Force
New-WebApplication -Name "Testplayer" -Site "Default Web Site\MOE" -PhysicalPath "D:\Project\MOE\Testplayer" -ApplicationPool "Testplayer" -Force
New-WebApplication -Name "TAAdmin" -Site "Default Web Site\MOE" -PhysicalPath "D:\Project\MOE\TestPrepAdmin" -ApplicationPool "TestPrepAdmin" -Force

Write-Host "Webapplications created and assigned to respective pools
."


#setting enabled protocols for required VD's
#Set-ItemProperty "IIS:\sites\Default Web Site\MOESLSSupplementaryAPI" -name enabledProtocols -value "http,net.tcp"
#Set-ItemProperty 'IIS:\sites\Default Web Site\MOE" -name preloadEnabled -Value "True"

#recycling Apppools
 ForEach ($ApplicationPool in $ApplicationPoolNames)
   {

   Start-WebAppPool $ApplicationPool
   #Restart-WebAppPool $ApplicationPool -Force

   }

   #permission to folder and its files
foreach ($userName in $userNames) 
{
	icacls $folderPath /grant ${userName}:"(OI)(CI)F" /t
	Write-Host "Folder permissions for $userNames granted."

  #icacls $folderPath /grant "${userName}:${permission}" /t
}
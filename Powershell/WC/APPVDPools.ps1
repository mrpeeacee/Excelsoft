#Create a VD and deploy along with applciation pool
	Import-Module WebAdministration

# Define variables
	$appPoolNames = @("MOESLSCourseAPIPool", "MOESLSFileHandlerAPIPool", "MOESLSMainAPIPool", "MOESLSPrimaryAPIPool", "MOESLSProgramAPIPool", "MOELSReportsAPIPool", "MOELSServicePool" , "MOELSSupplementaryAPIPool", "MOELSTPAPIPool")
	#$identityType = "specificUser"
	$userName = "repousr"
	$password = "repoU$3r"

# Create application pools and set advanced settings
	foreach ($appPoolName in $appPoolNames) {
# Create application pool
    New-Item "IIS:\AppPools\$appPoolName"

# Set Queue Length for application pool to 9000
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -name queueLength -value 9000

# Set identity type, username, and password for application pool
	$identity = @{
    identityType = "SpecificUser"
    username = $username
    password = $password
		}
	Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name "processModel" -Value $identity

# Set idle timeout for application pool to 20 minutes
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -name processModel.idleTimeout -Value ([TimeSpan]::FromMinutes(0))

# Set time interval for periodic restarts of application pool to 12 hours
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -name recycling.periodicRestart.time -Value ([TimeSpan]::FromHours(0))

# Enable rapid fail protection for application pool
	Set-ItemProperty "IIS:\AppPools\$appPoolName" -name failure.rapidFailProtection -Value $true

# Set interval for rapid fail protection to 5 minutes
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -name failure.rapidFailProtectionInterval -Value ([TimeSpan]::FromMinutes(1))

# Set maximum number of crashes allowed by rapid fail protection to 5
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -name failure.rapidFailProtectionMaxCrashes -Value 20
}

#Creating Application Directories for VDs
	mkdir "D:\Project\Corp\MOESLSCourseAPI"
	mkdir "D:\Project\Corp\MOESLSFileHandlerAPI"
	mkdir "D:\Project\Corp\MOESLSMainAPI"
	mkdir "D:\Project\Corp\MOESLSPrimaryAPI"
	mkdir "D:\Project\Corp\MOESLSProgramAPI"
	mkdir "D:\Project\Corp\MOESLSReportsAPI"
	mkdir "D:\Project\Corp\MOESLSServiceAPI"
	mkdir "D:\Project\Corp\MOESLSSupplementaryAPI"
	mkdir "D:\Project\Corp\MOESLSTrainingAPI"
	
#Folder permissions
	$folderPath = "D:\Project"
	$userNames = @("repousr", "Administrators", "IIS_IUSRS", "IUSR", "NETWORK", "NETWORK SERVICE")
	$permission = "F"

	foreach ($userName in $userNames) {
	icacls $folderPath /grant ${userName}:"(OI)(CI)F" /t

#Create Web applications and assign specific pools
	New-WebApplication -Name "MOESLSCourseAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSCourseAPI" -ApplicationPool "MOESLSCourseAPIPool"
	New-WebApplication -Name "MOESLSFileHandlerAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSFileHandlerAPI" -ApplicationPool "MOESLSFileHandlerAPIPool"
	New-WebApplication -Name "MOESLSMainAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSMainAPI" -ApplicationPool "MOESLSMainAPIPool"
	New-WebApplication -Name "MOESLSPrimaryAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSPrimaryAPI" -ApplicationPool "MOESLSPrimaryAPIPool"
	New-WebApplication -Name "MOESLSProgramAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSProgramAPI" -ApplicationPool "MOESLSProgramAPIPool"
	New-WebApplication -Name "MOESLSReportsAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSReportsAPI" -ApplicationPool "MOELSReportsAPIPool"
	New-WebApplication -Name "MOESLSServiceAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSServiceAPI" -ApplicationPool "MOELSServicePool"
	New-WebApplication -Name "MOESLSSupplementaryAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSSupplementaryAPI" -ApplicationPool "MOELSSupplementaryAPIPool"
	New-WebApplication -Name "MOESLSTrainingAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSTrainingAPI" -ApplicationPool "MOELSTPAPIPool"

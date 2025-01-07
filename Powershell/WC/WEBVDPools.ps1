#Create a VD and deploy along with applciation pool
	Import-Module WebAdministration

# Define variables
	$appPoolNames = @("HelpFilesPool", "iCorpLMSPool", "MOESLSPool", "MOESLS_Scheduler_ServicePool", "MOESLSAPIPool", "MOESLSAssignEvaluatorsPool", "MOESLSCDNPool" , "MOESLSChatToolPool", "MOESLSCollaborationsPool", "MOESLSCoursePlayerPool", "MOESLSKnowledgeManagementPool", "MOESLSReportsPool", "MOESLSSarasFileViewerPool", "MOESLSSurveyPool", "MOESLSTMSPool", "MOESLSVideoPlayerPool")
	$identityType = "specificUser"
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
	mkdir "D:\Project\Corp\HelpFiles"
	mkdir "D:\Project\Corp\iCorpLMS"
	mkdir "D:\Project\Corp\MOESLS"
	mkdir "D:\Project\Corp\MOESLS_Scheduler_Service"
	mkdir "D:\Project\Corp\MOESLSAPI"
	mkdir "D:\Project\Corp\MOESLSAssignEvaluators"
	mkdir "D:\Project\Corp\MOESLSCDN"
	mkdir "D:\Project\Corp\MOESLSChatTool"
	mkdir "D:\Project\Corp\MOESLSCollaborations"
	mkdir "D:\Project\Corp\MOESLSCoursePlayer"
    mkdir "D:\Project\Corp\MOESLSKnowledgeManagement"
    mkdir "D:\Project\Corp\MOESLSReports"
    mkdir "D:\Project\Corp\MOESLSSarasFileViewer"
    mkdir "D:\Project\Corp\MOESLSSurvey"
    mkdir "D:\Project\Corp\MOESLSTMS"
    mkdir "D:\Project\Corp\MOESLSVideoPlayer"
#Folder permissions
	$folderPath = "D:\Project"
	$userNames = @("repousr", "Administrators", "IIS_IUSRS", "IUSR", "NETWORK", "NETWORK SERVICE")
	$permission = "F"

	foreach ($userName in $userNames) {
	icacls $folderPath /grant ${userName}:"(OI)(CI)F" /t

#Create Web applications and assign specific pools
	New-WebApplication -Name "HelpFiles" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\HelpFiles" -ApplicationPool "HelpFilesPool"
	New-WebApplication -Name "iCorpLMS" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\iCorpLMS" -ApplicationPool "iCorpLMSPool"
	New-WebApplication -Name "MOESLS" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLS" -ApplicationPool "MOESLSPool"
	New-WebApplication -Name "MOESLS_Scheduler_Service" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLS_Scheduler_Service" -ApplicationPool "MOESLS_Scheduler_ServicePool"
	New-WebApplication -Name "MOESLSAPI" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSAPI" -ApplicationPool "MOESLSAPIPool"
	New-WebApplication -Name "MOESLSAssignEvaluators" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSAssignEvaluators" -ApplicationPool "MOESLSAssignEvaluatorsPool"
	New-WebApplication -Name "MOESLSCDN" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSCDN" -ApplicationPool "MOESLSCDNPool"
	New-WebApplication -Name "MOESLSChatTool" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSChatTool" -ApplicationPool "MOESLSChatToolPool"
	New-WebApplication -Name "MOESLSCollaborations" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSCollaborations" -ApplicationPool "MOESLSCollaborationsPool"
    New-WebApplication -Name "MOESLSCoursePlayer" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSCoursePlayer" -ApplicationPool "MOESLSCoursePlayerPool"
    New-WebApplication -Name "MOESLSKnowledgeManagement" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSKnowledgeManagement" -ApplicationPool "MOESLSKnowledgeManagementPool"
    New-WebApplication -Name "MOESLSReports" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSReports" -ApplicationPool "MOESLSReportsPool"
	New-WebApplication -Name "MOESLSSarasFileViewer" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSSarasFileViewer" -ApplicationPool "MOESLSSarasFileViewerPool"
	New-WebApplication -Name "MOESLSSurvey" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSSurvey" -ApplicationPool "MOESLSSurveyPool"
	New-WebApplication -Name "MOESLSTMS" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSTMS" -ApplicationPool "MOESLSTMSPool"
	New-WebApplication -Name "MOESLSVideoPlayer" -Site "Default Web Site" -PhysicalPath "D:\Project\Corp\MOESLSVideoPlayer" -ApplicationPool "MOESLSVideoPlayerPool"


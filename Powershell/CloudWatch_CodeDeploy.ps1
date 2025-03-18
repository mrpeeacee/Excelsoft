#Download the cloudwatch-agent :
Invoke-WebRequest -Uri "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi" -OutFile "C:\amazon-cloudwatch-agent.msi"
 
#Start-instal
Start-Process msiexec.exe -Wait -ArgumentList "/i C:\amazon-cloudwatch-agent.msi"


Define the region and construct the URL for the CodeDeploy agent
$region = "ap-southeast-1" # Change to your region if different
$installerUrl = "https://aws-codedeploy-$region.s3.amazonaws.com/latest/codedeploy-agent.msi"
$installerPath = "$env:TEMP\codedeploy-agent.msi"
 
#Download the CodeDeploy agent installer
Write-Host "Downloading CodeDeploy agent installer from $installerUrl"
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
 
Write-Host ("Adding Windows Defender exclude for CodeDeploy...")
Add-MpPreference -ExclusionPath ("C:\ProgramData\Amazon\CodeDeploy","$env:windir\Temp")
 
#Install the CodeDeploy agent
Write-Host "Installing CodeDeploy agent"
Start-Process -FilePath msiexec.exe -ArgumentList "/i $installerPath /quiet /l*v install.log" -NoNewWindow -Wait
Get-Service -Name codedeployagent
Stop-Service -Name codedeployagent
Add-Content C:\ProgramData\Amazon\CodeDeploy\conf.yml "`n:proxy_uri: http://100.114.160.10:3128" -Force
Restart-Service -Name codedeployagent
 
#Start the CodeDeploy agent service
Write-Host "Starting CodeDeploy agent service"
Start-Service -Name codedeployagent
 
#Verify the CodeDeploy agent service is running
$service = Get-Service -Name codedeployagent
if ($service.Status -eq 'Running') {
Write-Host "CodeDeploy agent is running"
} else {
Write-Host "Failed to start CodeDeploy agent. Check the service status and install.log for details."
}
 
#Clean up the installer
Remove-Item -Path $installerPath -Force

Replace region and other values proxy ip and port
After configuring the agent, verify the config file for proxy reference and ensure that the CodeDeployAgent service is running.

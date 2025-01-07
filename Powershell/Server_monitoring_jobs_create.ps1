#cron_job creation at system startup
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -RunLevel Highest
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File C:\Scripts\StartupTask.ps1"
Register-ScheduledTask -TaskName "Startup Task" -Description "Run cronjob script at system startup" -Trigger $Trigger -Principal $Principal -Action $Action
schtasks /change /TN "Cron_Job" /RU SYSTEM /RP "" /IT

#IIS log compress and Delete
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -RunLevel Highest
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File C:\Scripts\StartupTask.ps1"
Register-ScheduledTask -TaskName "Startup Task" -Description "Run cronjob script at system startup" -Trigger $Trigger -Principal $Principal -Action $Action
schtasks /change /TN "IIS_compress_1day" /RU "%USERNAME%" /RP "" /IT

#App pool monitoring
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -RunLevel Highest
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File C:\Scripts\StartupTask.ps1"
Register-ScheduledTask -TaskName "App_Pool_Monitor" -Description "App pool monitoring" -Trigger $Trigger -Principal $Principal -Action $Action
schtasks /change /TN "App_Pool_Monitor" /RU "%USERNAME%" /RP "" /IT

#Drive Space notification
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -RunLevel Highest
$Action = New-ScheduledTaskAction -Execute "DiskManagement.exe"
Register-ScheduledTask -TaskName "Startup Task" -Description "Drive Space Alerts" -Trigger $Trigger -Principal $Principal -Action $Action
schtasks /change /TN "DriveSpaceNotofication" /RU "%USERNAME%" /RP "" /IT

#Ping Status Alert
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -RunLevel Highest
$Action = New-ScheduledTaskAction -Execute "HostMonitoringTool.exe"
Register-ScheduledTask -TaskName "Startup Task" -Description "Ping Status Alerts" -Trigger $Trigger -Principal $Principal -Action $Action
schtasks /change /TN "PingStatus" /RU "%USERNAME%" /RP "" /IT

#File Modified Alert
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -RunLevel Highest
$Action = New-ScheduledTaskAction -Execute "RecentModifiedFiles.exe"
Register-ScheduledTask -TaskName "Startup Task" -Description "Ping Status Alerts" -Trigger $Trigger -Principal $Principal -Action $Action
schtasks /change /TN "PingStatus" /RU "%USERNAME%" /RP "" /IT

#User session logoff
$trigger = New-ScheduledTaskTrigger -Daily -At 10pm -RepetitionInterval (New-TimeSpan -Minutes 30)
$Principal = New-ScheduledTaskPrincipal -RunLevel Highest
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File C:\Scripts\StartupTask.ps1"
$Settings = New-ScheduledTaskSettingsSet -RunOnlyIfLoggedOn $false
$task = New-ScheduledTask -Trigger $Trigger -Principal $Principal -Action $Action -Settings $Settings
Register-ScheduledTask -TaskName "User_session_logoff" -Description "User_session_logoff if idle" -InputObject $task
schtasks /change /TN "User_session_logoff" /RU "%USERNAME%" /RP "" /IT



#$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 2)
#$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionDuration ([timespan]::MaxValue) -RepetitionInterval (New-TimeSpan -Minutes 5)
#$trigger = New-ScheduledTaskTrigger -Daily -At 7am -RepetitionInterval (New-TimeSpan -Minutes 2)
#$trigger = New-ScheduledTaskTrigger -Daily -At 7am
#$task.Settings.RunOnlyIfLoggedOn = $false or $true
#$Settings = New-ScheduledTaskSettingsSet -RunOnlyIfLoggedOn $false to run a job with user logged on or not


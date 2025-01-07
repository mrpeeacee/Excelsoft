Unregister-ScheduledTask -TaskName 'GenerateQpack' -Confirm:$false
$Action = New-ScheduledTaskAction -Execute 'D:\Project\Scheduler_Tasks\GenerateQpack\QPack-ETL.exe'
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 2)
$Task = New-ScheduledTask  -Trigger $Trigger -Action $Action
Register-ScheduledTask -TaskName 'GenerateQpack' -InputObject  $Task
schtasks /change /TN \"GenerateQpack" /RU mdirect.local\seabproduser$ /RP

Unregister-ScheduledTask -TaskName 'UploadQPack' -Confirm:$false
$Action = New-ScheduledTaskAction -Execute 'D:\Project\Scheduler_Tasks\UploadQPack\PackageTransfer.exe'
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 2)
$Task = New-ScheduledTask  -Trigger $Trigger -Action $Action
Register-ScheduledTask -TaskName 'UploadQPack' -InputObject  $Task
schtasks /change /TN \"UploadQPack" /RU mdirect.local\seabproduser$ /RP






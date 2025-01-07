# Get task names from the Task Scheduler library
$scheduledTaskNames = Get-ScheduledTask | Where-Object { $_.TaskPath -eq '\' } | Select-Object -ExpandProperty TaskName

# Display task names
foreach ($taskName in $scheduledTaskNames) {
    Write-Host $taskName
}
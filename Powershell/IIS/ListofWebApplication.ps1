Import-Module WebAdministration
$applications = Get-ChildItem -Path 'IIS:\Sites\Default Web Site' | Where-Object {$_.NodeType -eq 'application'} | Select-Object Name, @{Name='PhysicalPath'; Expression={$_.PhysicalPath}}

$applications | Format-Table -AutoSize | Out-String -Width 500 | Out-File -FilePath 'D:\AppnList.txt'

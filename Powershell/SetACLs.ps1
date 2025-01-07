$folderPath = "C:\MyFolder"
$userName = "MyDomain\MyUser"
$permission = "FullControl"

$acl = Get-Acl $folderPath
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($userName, $permission, "Allow")
$acl.SetAccessRule($accessRule)
Set-Acl $folderPath $acl


#Inherit permissions
$subFolderPath = "C:\MyFolder\MySubfolder"

$acl = Get-Acl $subFolderPath
$acl.SetAccessRuleProtection($false, $true)
Set-Acl $subFolderPath $acl


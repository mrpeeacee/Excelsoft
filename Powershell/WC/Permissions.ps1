$folderPath = "D:\Project"
$userNames = @("Administrators", "IIS_IUSRS", "IUSR", "NETWORK", "NETWORK SERVICE")
$permission = "F"

foreach ($userName in $userNames) {
	icacls $folderPath /grant ${userName}:"(OI)(CI)F" /t
#icacls $folderPath /grant "${userName}:${permission}" /t
}

#$subFolderPath = "D:\Project\Corp"
#icacls $subFolderPath /inheritance:r
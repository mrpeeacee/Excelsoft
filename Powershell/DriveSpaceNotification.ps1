# Read the XML file
$Drives = [xml](Get-Content D:\My_Docs\XML\Drivelist.xml)

# Loop through each drive element
foreach ($Drive in $Drives.Drives.Drive) {

# Get the drive name and threshold
$Name = $Drive.Name
$Threshold = $Drive.Threshold

# Get the drive object using WMI
$Disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='${Name}:'"

# Calculate the free space percentage
$FreeSpacePercent = [Math]::Round(($Disk.FreeSpace / $Disk.Size) * 100)

# Compare the free space with the threshold
if ($FreeSpacePercent -lt $Threshold) {

# Send an email notification using SMTP
$SmtpServer = "smtp.excelindia.com"
$SmtpPort = 587
$SmtpUser = "es.email@excelindia.com"
$SmtpPassword = "E$ma!l@098"
$ToEmail = "nikhil.mg@excelsoftcorp.com"
$FromEmail = "es.email@excelindia.com"
$Subject = "Low disk space warning on drive $Name"
$Body = "Drive $Name has only $FreeSpacePercent% free space left."

# Create a SMTP client object
$SmtpClient = New-Object Net.Mail.SmtpClient($SmtpServer, $SmtpPort)

# Set the credentials and enable SSL if needed
$SmtpClient.Credentials = New-Object Net.NetworkCredential($SmtpUser, $SmtpPassword)
#$SmtpClient.EnableSsl = $true

# Create a mail message object
$MailMessage = New-Object Net.Mail.MailMessage($FromEmail, $ToEmail, $Subject, $Body)

# Send the mail message
$SmtpClient.Send($MailMessage)
}
}
Write-Host "Email has been sent to $ToEmail"
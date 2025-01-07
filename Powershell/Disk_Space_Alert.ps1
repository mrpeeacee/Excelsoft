$drives = Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, FreeSpace, Size

# Define drive-specific thresholds in GB
$thresholds = @{
    'C:' = 20
    'D:' = 10
# Add more drive thresholds as needed
}

$smtpServer = "email-smtp.us-east-1.amazonaws.com"
$smtpPort = 587  # Change to your SMTP server's port
$smtpUsername = "AKIAJYKCU2HYQ72LDROQ"
$smtpPassword = "ApXU4f6HI/NWPfgmsIBydMmtzfnH4jzVLnOdUYNtnVqx"
$useSSL = $true   # Change to $false if not using SSL

$hostname = $env:COMPUTERNAME
$privateIP = (Test-Connection -ComputerName $hostname -Count 1).IPV4Address.IPAddressToString

$alertMessage = ""

foreach ($drive in $drives) {
    $driveLetter = $drive.DeviceID
    $freeSpaceGB = [math]::Round($drive.FreeSpace / 1GB, 2)
    $totalSizeGB = [math]::Round($drive.Size / 1GB, 2)

    if ($thresholds.ContainsKey($driveLetter) -and $freeSpaceGB -lt $thresholds[$driveLetter]) {
        $threshold = $thresholds[$driveLetter]
        $alertMessage += "Drive $driveLetter - Free Space: ${freeSpaceGB}GB / Total Size: ${totalSizeGB}GB (Threshold: ${threshold}GB)`r`n"
    }
}

if ($alertMessage -ne "") {
    $subject = "Low Disk Space Alert for Server: $hostname"
    $body = "The following drive(s) on server $hostname have low disk space:`r`n`r`n$alertMessage`r`nServer Hostname: $hostname`r`nPrivate IP Address: $privateIP`r`n`r`nThanks & Regards,`r`nDevOps Team"
    $recipient = @(
	"sarasdeployment@excelindia.com",
    "sarasdba@excelindia.com",
	"essarassupport@excelindia.com"
)


        $smtpSecureStringPassword = ConvertTo-SecureString $smtpPassword -AsPlainText -Force
        $smtpCredential = New-Object System.Management.Automation.PSCredential ($smtpUsername, $smtpSecureStringPassword)

        $emailParams = @{
            From = "es.email@excelindia.com"
            To = $recipient
            Subject = $subject
            Body = $body
            SmtpServer = $smtpServer
            Port = $smtpPort
            UseSsl = $useSSL
            Credential = $smtpCredential
        }

        Send-MailMessage @emailParams
    }
exit
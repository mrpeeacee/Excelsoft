# Configuration
$services = @(
    "LeaderboardSyncToErpWatcher",
    "LeaderBoardWatcher_SIDC"
)
$from = "es.email@excelindia.com"
$recipients = @("nikhil.mg@excelsoftcorp.com", "chethan.k@excelsoftcorp.com", "nimbargi.gautam@excelindia.com")
$smtpServer = "smtppro.zoho.com"
$smtpPort = 587
$smtpUsername = "es.email@excelindia.com"
$smtpPassword = "Ectv3183FPwc"
$useSSL = $true

# Function to send email
function Send-Email {
    param (
        [string]$Subject,
        [string]$Body,
        [string[]]$Recipients
    )

    $smtp = New-Object Net.Mail.SmtpClient($smtpServer, $smtpPort)
    $smtp.EnableSsl = $useSSL
    $smtp.Credentials = New-Object System.Net.NetworkCredential($smtpUsername, $smtpPassword)

    $message = New-Object Net.Mail.MailMessage
    $message.From = $from
    foreach ($recipient in $Recipients) {
        $message.To.Add($recipient)
    }
    $message.Subject = $Subject
    $message.Body = $Body

    $smtp.Send($message)
}

# Get the hostname
$hostname = $env:COMPUTERNAME

# Check the status of each service
foreach ($serviceName in $services) {
    $status = (Get-Service -Name $serviceName).Status
    if ($status -ne "Running") {
        Write-Host "Service '$serviceName' is not running. Starting the service..."
        try {
            Start-Service -Name $serviceName
            Send-Email -Subject "Service $serviceName Started on $hostname" -Body "The service $serviceName was not running and has been started on $hostname." -Recipients $recipients
        } catch {
            Write-Host "Failed to start service '$serviceName': $_"
            Send-Email -Subject "Failed to Start Service $serviceName on $hostname" -Body "Failed to start service $serviceName on $hostname. Error: $_" -Recipients $recipients
        }
    } else {
        Write-Host "Service '$serviceName' is running."
        Send-Email -Subject "Service $serviceName Status on $hostname" -Body "The service $serviceName is currently running on $hostname." -Recipients $recipients
    }
}

# Exit the script
Write-Host "Script execution completed. Exiting..."
exit

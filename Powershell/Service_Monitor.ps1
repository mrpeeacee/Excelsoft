# Configuration
$serviceName = "LeaderboardSyncToErpWatcher"
$from = "es.email@excelindia.com"
$recipients = @("nikhil.mg@excelsoftcorp.com", "chethan.k@excelsoftcorp.com")
$smtpServer = "email-smtp.us-east-1.amazonaws.com"
$smtpPort = 587
$smtpUsername = "AKIAJYKCU2HYQ72LDROQ"
$smtpPassword = "ApXU4f6HI/NWPfgmsIBydMmtzfnH4jzVLnOdUYNtnVqx"
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

# Check the status and send email if changed
$serviceStatusFile = "C:\serviceStatus.txt"

while ($true) {
    $status = (Get-Service -Name $serviceName).Status
    if ($status -ne "Running") {
        Write-Host "Service '$serviceName' is not running. Starting the service..."
        try {
            Start-Service -Name $serviceName
            Send-Email -Subject "Service $serviceName Started on $hostname" -Body "The service $serviceName has been started on $hostname." -Recipients $recipients
        } catch {
            Write-Host "Failed to start service '$serviceName': $_"
            Send-Email -Subject "Failed to Start Service $serviceName on $hostname" -Body "Failed to start service $serviceName on $hostname. Error: $_" -Recipients $recipients
        }
    }

    Start-Sleep -Seconds 120  # Sleep for 2 minutes before checking again
}

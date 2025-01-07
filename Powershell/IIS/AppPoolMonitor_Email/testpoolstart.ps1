Import-Module WebAdministration

# Configuration
$appPoolNames = @("DefaultAppPool", "DW", "IpurMobile", "IpurProtalServices", "iSarasPortal", "Learning4.0", "Learning4.0-32bit", "LearningMobile4.0", "LearningMobileServiceReviewTest", "LearningMobileServiceSecuredOAuthV1", "LearningMonitoringTool", "LearningService4.0", "LearningTA4.0", "LearningTAEssayEvaluation", "LearningTAService4.0", "LearningTP4.0", "LMS2.0", "LMS4.0", "LMS-4.0", "LMS4.0-32bit", "LMSMonitoringTool", "LMSService4.0", "LMSTA4.0", "LMSTP4.0", "MobileApps", "NotificationService", "RootRepo", "Saafalya_Corp", "Saafalya_Service", "Saafalya_TA", "SaafalyaTP", "scoplayer", "SSOIpru", "SSOLearning", "nikhil")

$from = "es.email@excelindia.com"
$recipients = @("nikhil.mg@excelsoftcorp.com","saras.alerts@excelindia.com")
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

    try {
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
        Write-Host "Email sent: $Subject"
    } catch {
        Write-Host "Failed to send email: $_"
    }
}

# Main function to monitor app pools
function Main {
    $dt = Get-Date
    $ComputerName = $env:COMPUTERNAME

    foreach ($appPoolName in $appPoolNames) {
        Write-Host "Checking App Pool: $appPoolName"

        try {
            if ((Get-WebAppPoolState -Name $appPoolName).Value -eq "Stopped") {
                Write-Host "App Pool '$appPoolName' is stopped. Attempting to restart..."
                Start-WebAppPool -Name $appPoolName
                Start-Sleep -Seconds 30

                if ((Get-WebAppPoolState -Name $appPoolName).Value -eq "Stopped") {
                    Write-Host "Failed to restart App Pool '$appPoolName'"
                    Send-Email -Subject "App Pool Restart Failed" -Body "App Pool '$appPoolName' on $ComputerName failed to restart. This may affect operations.\nTimestamp: $dt" -Recipients $recipients
                } else {
                    Write-Host "App Pool '$appPoolName' restarted successfully."
                    Send-Email -Subject "App Pool Restart Successful" -Body "App Pool '$appPoolName' on $ComputerName was stopped but has been successfully restarted.\nTimestamp: $dt" -Recipients $recipients
                }
            } else {
                Write-Host "App Pool '$appPoolName' is running."
            }
        } catch {
            Write-Host "Error monitoring App Pool '$appPoolName': $_"
            Send-Email -Subject "Error Monitoring App Pool" -Body "An error occurred while monitoring App Pool '$appPoolName' on $ComputerName.\nError: $_\nTimestamp: $dt" -Recipients $recipients
        }
    }
}

# Call the main function
Main

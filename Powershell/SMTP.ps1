

# Create a SMTP client object using the default port
$SmtpClient = New-Object Net.Mail.SmtpClient ("smtp.example.com")

# Create a SMTP client object using a custom port
$SmtpClient = New-Object Net.Mail.SmtpClient ("smtp.example.com", 587)

# Enable SSL encryption for the connection
$SmtpClient.EnableSsl = $true

# Set the credentials for authentication
$SmtpClient.Credentials = New-Object System.Net.NetworkCredential ("user@example.com", "password")

# Set the time-out period to 60 seconds
$SmtpClient.Timeout = 60000

To send an email message using the SMTP client object, you need to create a Net.Mail.MailMessage object that represents the email message, and then pass it to the Send method of the SMTP client object. For example:

# Create a mail message object
$MailMessage = New-Object Net.Mail.MailMessage

# Set the sender, recipient, subject and body of the message
$MailMessage.From = "sender@example.com"
$MailMessage.To.Add ("recipient@example.com")
$MailMessage.Subject = "Test email"
$MailMessage.Body = "This is a test email"

# Send the mail message using the SMTP client object
$SmtpClient.Send ($MailMessage)


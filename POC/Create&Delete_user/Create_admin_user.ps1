# Set the username and password for the new user
$Username = "nikhil"
$Password = "n1k#!l!@#"

# Create a new user account
$UserAccount = New-LocalUser -Name $Username -Password (ConvertTo-SecureString -String $Password -AsPlainText -Force) -PasswordNeverExpires

# Add the user to the administrators group
$AdminGroup = Get-LocalGroup -Name "Administrators"
Add-LocalGroupMember -Group $AdminGroup -Member $UserAccount

Write-Host "user nikhil created and added to admin group."

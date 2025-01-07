Import-Module WebAdministration

# Define variables
$appPoolNames = @("hellonik", "hinik")
$identityType = "specificUser"
$userName = "sarasrepousr"
$password = ConvertTo-SecureString "repou$3r" -AsPlainText -Force

# set advanced settings
foreach ($appPoolName in $appPoolNames) {

    # Set identity type, username, and password for application pool
    $identity = @{
        identityType = "SpecificUser"
        username = $userName
        password = $password
    }
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name "processModel" -Value $identity
}

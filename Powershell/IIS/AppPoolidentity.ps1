Import-Module WebAdministration

# Define variables
	$appPoolNames = @("ETLDashBoardApplicationpool", "MOEApppool")
	$identityType = "specificUser"
	$userName = "mdirect\seabproduser$"

# set advanced settings
	foreach ($appPoolName in $appPoolNames) {


# Set Queue Length for application pool to 65535
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -name queueLength -value 65535

# Set identity type, username for application pool
	$identity = @{
    identityType = "SpecificUser"
    username = $username
		}
	Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name "processModel" -Value $identity

# Set idle timeout for application pool to 0 minutes
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -name processModel.idleTimeout -Value ([TimeSpan]::FromMinutes(0))
	
}

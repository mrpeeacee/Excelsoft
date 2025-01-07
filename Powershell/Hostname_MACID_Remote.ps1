# Remote server
$remoteServer = "Internet-RPweb1"

# Invoke command on the remote server to retrieve host name and MAC addresses
$networkInfo = Invoke-Command -ComputerName $remoteServer -ScriptBlock {
    # Get the host name of the remote server
    $hostname = $env:COMPUTERNAME

    # Import the NetAdapter module
    Import-Module NetAdapter

    # Get MAC address(es) of all network adapters
    $networkAdapters = Get-NetAdapter | Select-Object -Property InterfaceAlias, MacAddress

    # Create a custom object to store the results
    [PSCustomObject]@{
        HostName = $hostname
        MACAddresses = $networkAdapters
    }
}

# Display the results
Write-Host "Host Name: $($networkInfo.HostName)"
Write-Host "MAC Addresses:"
foreach ($adapter in $networkInfo.MACAddresses) {
    Write-Host "  $($adapter.InterfaceAlias): $($adapter.MacAddress)"
}

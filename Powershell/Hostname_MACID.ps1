# Get the host name
$hostname = [System.Net.Dns]::GetHostName()

# Get MAC address(es) of all network adapters
$networkAdapters = Get-NetAdapter | Select-Object -Property InterfaceAlias, MacAddress

# Display the results
Write-Host "Host Name: $hostname"
Write-Host "MAC Addresses:"
foreach ($adapter in $networkAdapters) {
    Write-Host "  $($adapter.InterfaceAlias): $($adapter.MacAddress)"
}
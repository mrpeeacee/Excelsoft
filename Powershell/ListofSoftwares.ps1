$outputFile = "D:\SoftwareList.txt"

# Get the list of installed software using WMI
$softwareList = Get-WmiObject -Class Win32_Product | Select-Object -Property Name, Version, Vendor

# Output the software list to a text file
$softwareList | Out-File -FilePath $outputFile

Write-Host "Software list exported to $outputFile."

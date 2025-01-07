Import-Module WebAdministration

#remove VD's

$VDnames=@("MOE","eORAL","ELC","Testplayer","TestPrepAdmin","EMS")
ForEach ($WebApplication in $VDnames)
{
Remove-WebApplication -Name $WebApplication -site "Default Web Site\"
}

#Remove AppPools

$ApplicationPoolNames=@("MOE","eORAL","ELC","Testplayer","TestPrepAdmin","EMS")
ForEach ($ApplicationPool in $ApplicationPoolNames)
{
Remove-Item IIS:\AppPools\$ApplicationPool -Recurse
}


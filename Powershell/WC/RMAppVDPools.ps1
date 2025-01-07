Import-Module WebAdministration

$appPoolNames = @("MOESLSCourseAPIPool", "MOESLSFileHandlerAPIPool", "MOESLSMainAPIPool", "MOESLSPrimaryAPIPool", "MOESLSProgramAPIPool", "MOELSReportsAPIPool", "MOELSServicePool" , "MOELSSupplementaryAPIPool", "MOELSTPAPIPool")
$vdNames = @("MOESLSCourseAPI", "MOESLSFileHandlerAPI", "MOESLSMainAPI", "MOESLSPrimaryAPI", "MOESLSProgramAPI", "MOESLSReportsAPI", "MOESLSServiceAPI" , "MOESLSSupplementaryAPI", "MOESLSTrainingAPI")
$siteName = "Default Web Site"

foreach ($vdName in $vdNames) {
    Remove-WebApplication -Site $siteName -Name $vdName
}

foreach ($appPoolName in $appPoolNames) {
    Remove-WebAppPool -Name $appPoolName
}

Rmdir "D:\Project"
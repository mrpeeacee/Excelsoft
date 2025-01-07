Import-Module WebAdministration

#creating Apppools
$ApplicationPoolNames=@(
"ABEM4.0","ABEMSSO","ABFM4.0","ABFMAPI4.0","AppUsage","Dashboard4.0","DBUsage","Landingpage","Reports","Student4.0")
<# $user=@("sarasrepousr")
$pwd=@("R3p0u$Er") #>

ForEach ($ApplicationPool in $ApplicationPoolNames)
{
New-Item IIS:\AppPools\$ApplicationPool -Force
}
ForEach ($ApplicationPool in $ApplicationPoolNames)
 {
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name enable32BitAppOnWin64 -value false
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name queueLength -value 9000
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name startMode -value OnDemand
  Set-ItemProperty IIS:\AppPools\$ApplicationPool -name processModel.idleTimeout -Value ([TimeSpan]::FromMinutes(90)) 
  #Set-ItemProperty IIS:\AppPools\$ApplicationPool -name processModel -value @{userName="$user";password="$pwd";identitytype=3} 
   
   }
#creating VD's                                                                                                                                                                      
New-WebApplication -Name "ABEM" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\LandingPage" -ApplicationPool "Landingpage" -Force
New-WebApplication -Name "ABEM_RootRepository" -Site "Default Web Site" -PhysicalPath "\\ABEM-Prod-db\ABEM_RootRepository" -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "Admin" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\Admin" -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "Itemauthoring" -Site "Default Web Site\Admin" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\Itemauthoring" -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "Assetlibrary" -Site "Default Web Site\Admin" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\Assetlibrary " -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "EMS" -Site "Default Web Site\Admin" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\EMS" -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "ReportInterface" -Site "Default Web Site\Admin" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\ReportInterfacev3" -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "Tryout" -Site "Default Web Site\Admin" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\Tryout" -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "ABEMServices" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\TASERVICES" -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "Export2p0" -Site "Default Web Site\ABEMServices" -PhysicalPath "C:\SarasApplication\Saras_ABEM\TASERVICES\Export2p0" -ApplicationPool "ABEM4.0" -Force

New-WebApplication -Name "ABFM" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABFM\Manifest\LandingPage" -ApplicationPool "ABFM4.0" -Force
New-WebApplication -Name "API" -Site "Default Web Site\ABFM" -PhysicalPath "C:\SarasApplication\Saras_ABFM\Manifest\APIv2" -ApplicationPool "ABFMAPI4.0" -Force
New-WebApplication -Name "ReportInterface" -Site "Default Web Site\ABFM" -PhysicalPath "C:\SarasApplication\Saras_ABFM\Manifest\ReportInterface" -ApplicationPool "ABFM4.0" -Force
New-WebApplication -Name "CustomReports" -Site "Default Web Site\ABFM" -PhysicalPath "C:\SarasApplication\Saras_ABFM\Manifest\CustomReports" -ApplicationPool "Reports" -Force
New-WebApplication -Name "Testplayer" -Site "Default Web Site\ABFM" -PhysicalPath "C:\SarasApplication\Saras_ABFM\Manifest\TestPlayer" -ApplicationPool "ABFM4.0" -Force
New-WebApplication -Name "SSO" -Site "Default Web Site\ABFM" -PhysicalPath "C:\SarasApplication\Saras_ABFM\Manifest\SSO" -ApplicationPool "ABEMSSO" -Force

New-WebApplication -Name "AppUsage" -Site "Default Web Site" -PhysicalPath "C:\AppUsage" -ApplicationPool "AppUsage" -Force
New-WebApplication -Name "DBUsage" -Site "Default Web Site" -PhysicalPath "C:\DBUsage" -ApplicationPool "DBUsage" -Force
New-WebApplication -Name "DBUsage_Mirr" -Site "Default Web Site" -PhysicalPath "C:\DBUsage_Mirr" -ApplicationPool "DBUsage" -Force
New-WebApplication -Name "VolunteerDashboard" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\VolunteerDashboard\VolunteerDashboardv2" -ApplicationPool "Dashboard4.0" -Force
New-WebApplication -Name "Undermaintenance" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\UnderMaint" -ApplicationPool "ABFMAPI4.0" -Force
New-WebApplication -Name "TeacherManagement" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\TeacherManagement" -ApplicationPool "ABEM4.0" -Force
New-WebApplication -Name "StudentLiveDashboard" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\StudentLiveDashboard" -ApplicationPool "Dashboard4.0" -Force
New-WebApplication -Name "Student" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\TestPrep" -ApplicationPool "Student4.0" -Force
New-WebApplication -Name "ServiceLogDashboard" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\TASERVICES\ServiceLogDashboard" -ApplicationPool "Dashboard4.0" -Force
New-WebApplication -Name "SARASABEMSSO" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\SARASABEMSSOv2" -ApplicationPool "ELC" -Force
New-WebApplication -Name "SARASABEMAPIV1" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\SARASABEMAPIV1" -ApplicationPool "Reports" -Force
New-WebApplication -Name "ReportViewer" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\ReportViewer" -ApplicationPool "Dashboard4.0" -Force
New-WebApplication -Name "ReportInterface" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\AdvancedReportInterfacev2" -ApplicationPool "Reports" -Force
New-WebApplication -Name "SSO" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\ABEMSSO" -ApplicationPool "ABEMSSO" -Force
New-WebApplication -Name "Testplayer" -Site "Default Web Site" -PhysicalPath "C:\SarasApplication\Saras_ABEM\Manifest\TestPlayerV2" -ApplicationPool "ABFMAPI4.0" -Force
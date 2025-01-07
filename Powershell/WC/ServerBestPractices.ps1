# Set visual effects to best performance mode
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name UserPreferencesMask -Value 90
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -Name VisualFXSetting -Value 2

# Disable Shutdown button using Group Policy
$policyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
New-ItemProperty -Path $policyPath -Name "NoClose" -PropertyType DWORD -Value 1 -Force | Out-Null

# Disable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False


# Set the website limits
Set-WebConfigurationProperty -Filter "/system.applicationHost/sites/site[@name='Default Web Site']/limits" -Name "connectionTimeout" -Value "00:10:00"

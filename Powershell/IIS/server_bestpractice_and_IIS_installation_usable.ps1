# IIS Installation

$proxy = '100.114.160.10:3128'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

[system.net.webrequest]::defaultwebproxy = new-object system.net.webproxy($proxy)

Import-Module WebAdministration

Install-WindowsFeature Web-Server
Install-WindowsFeature Web-WebServer
Install-WindowsFeature Web-Common-Http
Install-WindowsFeature Web-Default-Doc
Install-WindowsFeature Web-Dir-Browsing
Install-WindowsFeature Web-Http-Errors
Install-WindowsFeature Web-Static-Content
Install-WindowsFeature Web-Http-Redirect
Install-WindowsFeature Web-Health
Install-WindowsFeature Web-Http-Logging
Install-WindowsFeature Web-Custom-Logging
Install-WindowsFeature Web-Log-Libraries
Install-WindowsFeature Web-ODBC-Logging
Install-WindowsFeature Web-Request-Monitor
Install-WindowsFeature Web-Http-Tracing
Install-WindowsFeature Web-Performance
Install-WindowsFeature Web-Stat-Compression
Install-WindowsFeature Web-Dyn-Compression
Install-WindowsFeature Web-Security
Install-WindowsFeature Web-Filtering
Install-WindowsFeature Web-Basic-Auth
Install-WindowsFeature Web-CertProvider
Install-WindowsFeature Web-Client-Auth
Install-WindowsFeature Web-Digest-Auth
Install-WindowsFeature Web-Cert-Auth
Install-WindowsFeature Web-IP-Security
Install-WindowsFeature Web-Url-Auth
Install-WindowsFeature Web-Windows-Auth
Install-WindowsFeature Web-App-Dev
Install-WindowsFeature Web-Net-Ext45
Install-WindowsFeature Web-AppInit
Install-WindowsFeature Web-ASP
Install-WindowsFeature Web-Asp-Net45
Install-WindowsFeature Web-CGI
Install-WindowsFeature Web-ISAPI-Ext
Install-WindowsFeature Web-ISAPI-Filter
Install-WindowsFeature Web-Includes
Install-WindowsFeature Web-WebSockets
Install-WindowsFeature Web-Mgmt-Tools
Install-WindowsFeature Web-Mgmt-Console
Install-WindowsFeature Web-Mgmt-Compat
Install-WindowsFeature Web-Metabase
Install-WindowsFeature Web-Lgcy-Mgmt-Console
Install-WindowsFeature Web-Lgcy-Scripting
Install-WindowsFeature Web-WMI
Install-WindowsFeature Web-Scripting-Tools
Install-WindowsFeature Web-Mgmt-Service	
Install-WindowsFeature -Name NET-Framework-Features -IncludeAllSubFeature -Source D:\sources\sxs
Install-WindowsFeature -Name NET-Framework-45-ASPNET
Install-WindowsFeature -Name Web-Net-Ext -IncludeManagementTools
Install-WindowsFeature -Name Web-Asp-Net -IncludeManagementTools
Install-WindowsFeature -Name NET-WCF-HTTP-Activation45 -IncludeManagementTools -Restart
Install-WindowsFeature -Name NET-WCF-MSMQ-Activation45, NET-WCF-Pipe-Activation45, NET-WCF-TCP-Activation45, NET-WCF-TCP-PortSharing45 -IncludeManagementTools -Restart


# Set the Default website limits
Set-WebConfigurationProperty -Filter "/system.applicationHost/sites/site[@name='Default Web Site']/limits" -Name "connectionTimeout" -Value "00:10:00"

# Set the value of logging in IIS 
Import-Module WebAdministration
Set-WebConfigurationProperty -Filter '/system.applicationHost/sites/site[@name="Default Web Site"]/logFile' -Name 'truncateSize' -Value 3000000

# Telnet Client windows feature
Install-WindowsFeature -Name Telnet-Client

# Set visual effects to best performance mode
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name UserPreferencesMask -Value 90
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -Name VisualFXSetting -Value 2

# Disable Shutdown button using Group Policy
$policyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
New-ItemProperty -Path $policyPath -Name "NoClose" -PropertyType DWORD -Value 1 -Force | Out-Null

# Disable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#Enable TLS 1.2

#SSL 2.0

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

#SSL 3.0

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

#TLS 1.0

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

#TLS 1.1

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

#TLS 1.2

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

If (-Not (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client')) {
    New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Force | Out-Null
}
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null

# Install Chocolatey (if not already installed)
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
# Define list of packages to install
choco install 7zip.install -y
choco install googlechrome -y
choco install aspnetmvc1.install -y
choco install aspnetmvc2.install -y
choco install aspnetmvc3.install -y
choco install aspnetmvc4.install -y
choco install notepadplusplus -y
choco install reportviewer2008 -y
choco install reportviewer2010 -y
choco install reportviewer2012 -y
choco install site24x7-apminsight-dotnet -ia license.key=<in_99c8a386cf344d4fc80d3ec744b5a892>
choco install microsoftsecurityessentials

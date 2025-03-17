# IIS Installation Script

$proxy = '100.114.160.10:3128'

# Set security protocol to TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Configure proxy
[system.net.webrequest]::defaultwebproxy = New-Object system.net.webproxy($proxy)

# Import IIS Administration Module
Import-Module WebAdministration

# Install IIS Core Features
Install-WindowsFeature Web-Server

# Install Common HTTP Features
Install-WindowsFeature Web-WebServer, Web-Common-Http, Web-Default-Doc, Web-Dir-Browsing, Web-Http-Errors, Web-Static-Content, Web-Http-Redirect

# Install Health and Diagnostics Features
Install-WindowsFeature Web-Health, Web-Http-Logging, Web-Custom-Logging, Web-Log-Libraries, Web-ODBC-Logging, Web-Request-Monitor, Web-Http-Tracing

# Install Performance Features
Install-WindowsFeature Web-Performance, Web-Stat-Compression, Web-Dyn-Compression

# Install Security Features
Install-WindowsFeature Web-Security, Web-Filtering, Web-Basic-Auth, Web-CertProvider, Web-Client-Auth, Web-Digest-Auth, Web-Cert-Auth, Web-IP-Security, Web-Url-Auth, Web-Windows-Auth

# Install Application Development Features
Install-WindowsFeature Web-App-Dev, Web-Net-Ext45, Web-AppInit, Web-ASP, Web-Asp-Net45, Web-CGI, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Includes, Web-WebSockets

# Install IIS Management Tools
Install-WindowsFeature Web-Mgmt-Tools, Web-Mgmt-Console, Web-Mgmt-Compat, Web-Metabase, Web-Lgcy-Mgmt-Console, Web-Lgcy-Scripting, Web-WMI, Web-Scripting-Tools, Web-Mgmt-Service

# Install .NET Framework Features
Install-WindowsFeature -Name NET-Framework-Features -IncludeAllSubFeature -Source D:\sources\sxs
Install-WindowsFeature -Name NET-Framework-45-ASPNET
Install-WindowsFeature -Name Web-Net-Ext -IncludeManagementTools
Install-WindowsFeature -Name Web-Asp-Net -IncludeManagementTools

# Install WCF Services Features
Install-WindowsFeature -Name NET-WCF-HTTP-Activation45 -IncludeManagementTools -Restart
Install-WindowsFeature -Name NET-WCF-MSMQ-Activation45, NET-WCF-Pipe-Activation45, NET-WCF-TCP-Activation45, NET-WCF-TCP-PortSharing45 -IncludeManagementTools -Restart

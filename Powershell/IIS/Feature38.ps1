# IIS Installation

# $proxy = '172.31.90.18:3128'

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

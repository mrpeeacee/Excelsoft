# Specify the name of the server to install IIS on
$server_name = "localhost"

# Specify the list of IIS features to install
$iis_features = "Web-Server", "Web-Common-HTTP", "Web-Default-Doc", "Web-Dir-Browsing", "Web-Http-Errors", "Web-Static-Content", "Web-Http-Redirect", "Web-Health", "Web-Http-Logging", "Web-Log-Libraries", "Web-Request-Monitor", "Web-Performance", "Web-Stat-Compression"

# Install the IIS features without prompt
Install-WindowsFeature -Name $iis_features -IncludeAllSubFeature -Confirm:$false

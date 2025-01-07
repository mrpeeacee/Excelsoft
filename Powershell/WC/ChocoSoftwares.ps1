# Install Chocolatey (if not already installed)
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Define list of packages to install
$packages = @(
    "googlechrome",
    "made2010",
	"made-2016",
    "notepadplusplus",
    "7zip",
	"aspnetmvc4.install",
	"netfx-4.8.1",
	"reportviewer2008",
	"reportviewer2012",
	"reportviewer2010sp1",
	"urlrewrite",
	"wkhtmltopdf"
)

# Install each package using Chocolatey
foreach ($package in $packages) {
    choco install $package -y
}

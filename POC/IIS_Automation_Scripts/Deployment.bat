
psexec \\192.168.3.49 -s cmd /c "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe /t:StopServices d:\Project\Installer\Deployment.xml

psexec \\192.168.3.49 -s cmd /c "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe /t:CreateApppool d:\Project\Installer\Deployment.xml 

psexec \\192.168.3.49 -s cmd /c "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe /t:CreateWebApp d:\Project\Installer\Deployment.xml

psexec \\192.168.3.49 -s cmd /c "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe /t:protocol d:\Project\Installer\Deployment.xml

psexec \\192.168.3.49 -s cmd /c "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe /t:StartServices d:\Project\Installer\Deployment.xml
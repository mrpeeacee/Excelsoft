@Echo OFF
SET WebServer1=100.64.113.74
SET WebServer2=100.64.113.11
SET WebServer3=100.64.113.53
SET WebServer4=100.64.113.82
SET WebServer5=100.64.113.68
SET WebServer6=100.64.113.8
SET WebServer7=100.64.113.43
SET WebServer8=100.64.113.71


SET AppServer1=100.64.113.251
SET AppServer3=100.64.113.144
SET AppServer4=100.64.113.208
SET AppServer5=100.64.113.199
SET AppServer6=100.64.113.166
SET AppServer7=100.64.113.170
SET AppServer8=100.64.113.203
SET AppServer2=100.64.113.179

SET username=Prod-local\nikhil
SET Password=Excel#876
SET BuildDIR=D:\BuildPackages\ProdAuth

SET WebSharedPath1="\\%WebServer1%\d$\Project\MOE"
SET WebSharedPath2="\\%WebServer2%\d$\Project\MOE"
SET WebSharedPath3="\\%WebServer3%\d$\Project\MOE"
SET WebSharedPath4="\\%WebServer4%\d$\Project\MOE"
SET WebSharedPath3b="\\%WebServer3%\d$\Project\Xchange"
SET WebSharedPath4b="\\%WebServer4%\d$\Project\Xchange"

SET AppsharedPath1="\\%AppServer1%\d$\Project\MOE"
SET AppsharedPath2="\\%AppServer2%\d$\Project\MOE"
SET AppsharedPath3="\\%AppServer3%\d$\Project\MOE"
SET AppsharedPath4="\\%AppServer4%\d$\Project\MOE"
SET AppsharedPath3b="\\%AppServer3%\d$\Project\Xchange"
SET AppsharedPath4b="\\%AppServer4%\d$\Project\Xchange"

psexec.exe -i \\%WebServer1% -u %username% -p %Password% -s cmd /c iisreset


psexec.exe -i \\%WebServer2% -u %username% -p %Password% -s cmd /c iisreset


psexec.exe -i \\%WebServer3% -u %username% -p %Password% -s cmd /c iisreset

 psexec.exe -i \\%WebServer4% -u %username% -p %Password% -s cmd /c iisreset
 
 psexec.exe -i \\%WebServer5% -u %username% -p %Password% -s cmd /c iisreset
 
 psexec.exe -i \\%WebServer6% -u %username% -p %Password% -s cmd /c iisreset
 
 psexec.exe -i \\%WebServer7% -u %username% -p %Password% -s cmd /c iisreset
 
 psexec.exe -i \\%WebServer8% -u %username% -p %Password% -s cmd /c iisreset


 psexec.exe -i \\%AppServer1% -u %username% -p %Password% -s cmd /c iisreset


 psexec.exe -i \\%AppServer2% -u %username% -p %Password% -s cmd /c iisreset


 psexec.exe -i \\%AppServer3% -u %username% -p %Password% -s cmd /c iisreset


 psexec.exe -i \\%AppServer4% -u %username% -p %Password% -s cmd /c iisreset
 
 psexec.exe -i \\%AppServer5% -u %username% -p %Password% -s cmd /c iisreset
 
 psexec.exe -i \\%AppServer6% -u %username% -p %Password% -s cmd /c iisreset
 
 psexec.exe -i \\%AppServer7% -u %username% -p %Password% -s cmd /c iisreset
 
 psexec.exe -i \\%AppServer8% -u %username% -p %Password% -s cmd /c iisreset



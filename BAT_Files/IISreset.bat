@echo off

set remoteServer=192.168.3.49

echo Resetting IIS on %remoteServer%...
psexec \\%remoteServer% iisreset /restart

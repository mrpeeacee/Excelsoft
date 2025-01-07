@echo off
setlocal

:: Set log file path
set logfile=C:\path\to\your\logfile.txt

:: Initialize the log file
echo %date% %time% - Starting Windows services... >> %logfile%

:: List of services to start
set services=bits TrustedInstaller msiserver wuauserv

:: Loop through each service and start it
for %%s in (%services%) do (
    echo %date% %time% - Configuring %%s to start automatically... >> %logfile%
    sc config %%s start= auto >> %logfile% 2>&1
    
    echo %date% %time% - Starting %%s... >> %logfile%
    net start %%s >> %logfile% 2>&1
    
    if %errorlevel% neq 0 (
        echo %date% %time% - Failed to start %%s >> %logfile%
    ) else (
        echo %date% %time% - %%s started successfully >> %logfile%
    )
)

echo %date% %time% - All services have been processed. >> %logfile%
echo All services have been processed.

:: Ensure the script exits
endlocal
exit /b 0

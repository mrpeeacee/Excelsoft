@echo off
setlocal
set "LogFile=D:\logs\service_setup.log"
echo Script started at %DATE% %TIME% > "%LogFile%"

REM Define variables for the services
set "Service1Name=useruto"
set "Service2Name=cronjobservice"
set "Service1ExePath=D:\Project\Scheduler_Tasks\UserAutoDeletionService\UserAutoDeletionService.exe"
set "Service2ExePath=D:\Project\Scheduler_Tasks\CronJobStatusService\SchedulerTasksService.exe"
set "ServiceAccount=mdirect\seabproduser$"

REM Check if Service 1 exists
sc query "%Service1Name%" >nul 2>&1
if %errorlevel% equ 0 (
    echo Service %Service1Name% already exists. >> "%LogFile%"
) else (
    echo Creating service %Service1Name%... >> "%LogFile%"
    sc create "%Service1Name%" binPath= "%Service1ExePath%" obj= "%ServiceAccount%" >> "%LogFile%" 2>&1
    sc config "%Service1Name%" start= auto >> "%LogFile%" 2>&1
    net start "%Service1Name%" >> "%LogFile%" 2>&1
    if %errorlevel% neq 0 echo Error starting %Service1Name%. Check permissions and account details. >> "%LogFile%"
)

REM Check if Service 2 exists
sc query "%Service2Name%" >nul 2>&1
if %errorlevel% equ 0 (
    echo Service %Service2Name% already exists. >> "%LogFile%"
) else (
    echo Creating service %Service2Name%... >> "%LogFile%"
    sc create "%Service2Name%" binPath= "%Service2ExePath%" obj= "%ServiceAccount%" >> "%LogFile%" 2>&1
    sc config "%Service2Name%" start= auto >> "%LogFile%" 2>&1
    net start "%Service2Name%" >> "%LogFile%" 2>&1
    if %errorlevel% neq 0 echo Error starting %Service2Name%. Check permissions and account details. >> "%LogFile%"
)

echo Script completed at %DATE% %TIME% >> "%LogFile%"
endlocal

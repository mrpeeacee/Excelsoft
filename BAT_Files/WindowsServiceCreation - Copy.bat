@echo off
setlocal

REM Define variables for the services
set "Service1Name=useruto"
set "Service2Name=cronjobservice"
REM set "ExePath=D:\Project\eMarking_RC_job\Saras.eMarking.RCScheduler.Server.exe"    REM Path to your .exe
set "ServiceAccount=mdirect\seabproduser$"
REM set "Password=YourPassword"

REM Check if Service 1 exists
sc query "%Service1Name%" >nul 2>&1
if %errorlevel% equ 0 (
    echo Service %Service1Name% already exists.
) else (
    REM Install the .exe if it is required for Service 1
    REM echo Installing %ExePath%...
    REM "%ExePath%" /install  REM Adjust the install command if different

    REM Create Service 1 with specific parameters
    echo Creating service %Service1Name%...
    sc create "%Service1Name%" binPath= "D:\Project\Scheduler_Tasks\UserAutoDeletionService\UserAutoDeletionService.exe" obj= "%ServiceAccount%"

    REM Set the service to start automatically
    sc config "%Service1Name%" start= auto

    REM Start the service
    echo Starting service %Service1Name%...
    net start "%Service1Name%"
)

REM Check if Service 2 exists
sc query "%Service2Name%" >nul 2>&1
if %errorlevel% equ 0 (
    echo Service %Service2Name% already exists.
) else (
    REM Create Service 2 without an exe installation
    echo Creating service %Service2Name%...
    sc create "%Service2Name%" binPath= "D:\Project\Scheduler_Tasks\CronJobStatusService\SchedulerTasksService.exe" 
	REM obj= "%ServiceAccount%" password= "%Password%"

    REM Set the service to start automatically
    sc config "%Service2Name%" start= auto

    REM Start the service
    echo Starting service %Service2Name%...
    net start "%Service2Name%"
)

echo Script completed.
endlocal

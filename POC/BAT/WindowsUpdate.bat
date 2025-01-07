@echo off
setlocal

REM List of services to start
set "services=bits msiserver wuauserv TrustedInstaller"

REM Loop through the services
for %%s in (%services%) do (
    net start %%s
    if %errorlevel% equ 0 (
        echo %%s service has been started successfully.
    ) else (
        echo Error: Failed to start %%s service.
    )
)

endlocal

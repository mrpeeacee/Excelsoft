@echo off
setlocal

REM List of services to stop
set "services=bits msiserver wuauserv TrustedInstaller"

REM Loop through the services
for %%s in (%services%) do (
    net stop %%s
    if %errorlevel% equ 0 (
        echo %%s service has been stopped successfully.
    ) else (
        echo Error: Failed to stop %%s service.
    )
)

endlocal

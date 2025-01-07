@echo off

REM Invoke the PowerShell script
powershell.exe -ExecutionPolicy Bypass -File "D:\Project\TestPOC\Create_admin_user.ps1"

REM Check the exit code of the PowerShell script
if %errorlevel% neq 0 (
    echo PowerShell script encountered an error.
) else (
    echo PowerShell script executed successfully.
)

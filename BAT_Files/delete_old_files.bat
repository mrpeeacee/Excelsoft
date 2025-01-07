@echo off
setlocal

:: Define the folder path
set folderPath="D:\PythonVideo_Analysis\Videos\1"

:: Define the number of days
set days=2

:: Find and delete files older than the specified number of days
forfiles /p %folderPath% /s /m *.* /d -%days% /c "cmd /c del /q @path && set /a deletedFilesCount+=1"

:: Wait for a short time to ensure all deletions are completed
timeout /t 5 /nobreak >nul

:: Find and delete empty folders
for /f "delims=" %%d in ('dir %folderPath% /ad /s /b ^| sort /r') do (
    rd "%%d" 2>nul
)

:: Optional: Log the operation
echo %date% %time% - Deleted %deletedFilesCount% files older than %days% days in %folderPath% >> C:\path\to\your\logfile.txt

endlocal



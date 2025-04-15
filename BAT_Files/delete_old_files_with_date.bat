@echo off
forfiles /p "C:\path\to\your\directory" /s /m *.zip /d -01/01/2023 /c "cmd /c del @path"
echo Deletion complete.
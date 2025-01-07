
if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  

$Source = "C:\inetpub\logs\LogFiles\W3SVC1" 
[string]$strippedFileName = [System.IO.Path]::GetFileNameWithoutExtension($Source);
[string]$extension = [System.IO.Path]::GetExtension($Source);
[string]$newFileName = $strippedFileName +"_"+ [DateTime]::Now.ToString("MMddyyyy_HHmmss") + $extension;

$Target = "C:\inetpub\logs\LogFiles\"+$newFileName+".zip"

sz a -mx=9 $Target $Source

# set folder path
$dump_path = "C:\inetpub\logs\LogFiles\"

# set min age of files
$max_days = "-30"
 
# get the current date
$curr_date = Get-Date

# determine how far back we go based on current date
$del_date = $curr_date.AddDays($max_days)

# delete the files
Get-ChildItem $dump_path -Recurse | Where-Object { $_.LastWriteTime -lt $del_date } | Remove-Item
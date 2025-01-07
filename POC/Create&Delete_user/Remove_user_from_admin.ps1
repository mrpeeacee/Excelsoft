$Username = "nikhil"

# Check if the user exists in the administrators group
$AdminGroup = Get-LocalGroup -Name "Administrators"
$UserToDelete = Get-LocalUser -Name $Username

if ($UserToDelete -and $AdminGroup) {
    # Remove the user from the administrators group
    Remove-LocalGroupMember -Group $AdminGroup -Member $UserToDelete
    Remove-LocalUser -Name $Username -Confirm:$false
    Write-Host "User $Username has been removed from the administrators group and local."
} else {
    Write-Host "User $Username or administrators group not found."
}


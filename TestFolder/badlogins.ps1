# This script generates a report to show users that have bad login attempts

#Ask the user for the department they wish to search

$Department = Read-Host -Prompt 'What department do you want to search?'

#Use the input to filter Get-ADUser
$Users = Get-ADUser -Filter "Department -eq '$Department'" | Select-Object Name


foreach ($User in $Users){
    if ($_.badPwdCount -gt 0 ) {
        Write-Host "$User is having trouble logging in!"
    }
    else {
        Write-Host "$User is ok."
    }
}




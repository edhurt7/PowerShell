# This script generates a report to show users that have bad login attempts

##############################################################################
## For the purpose of this exercise, I have to make sure the members of the ##
## sales group are added to the Remote Desktop Users Group. This will allow ##
## me to login as users to generate bad login attempts.                     ##
##############################################################################

#Set my Variables
$sourceGroup = "Sales"


#Get all users from Sales
$groupMembers = Get-ADGroupMember -Identity $sourceGroup | Where-Object {$_.objectClass -eq 'user'}

#Foreach loop to add users to Remote Desktop Users group
foreach ($member in $groupMembers) {
    #Get the distinguished name of the user
    $userDN = (Get-ADUser -Identity $member.distinguishedName).distinguishedName

    #Add the user to the Remote Desktop Users group
    Add-ADGroupMember -Identity "Remote Desktop Users" -Members "$userDN"
}


#Ask the user for the department they wish to search

$Department = Read-Host -Prompt 'What department do you want to search?'

#Use the input to filter Get-ADUser
$Users = Get-ADUser -Filter "Department -eq '$Department'" | Select-Object -ExpandProperty Name


foreach ($User in $Users){
    if ($User.badPwdCount -gt 3 ) {
        Set-ADAccountControl -Identity $User -Enabled $true
        Write-Host "$($User.Name)'s account has been locked due to 3 unsuccessful login attempts."
    }
 }
 
 Write-Host "All other users are having no login issues."





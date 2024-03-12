# This script generates a report to show users that have bad login attempts

##############################################################################
## For the purpose of this exercise, I have to make sure the members of the ##
## sales group are added to the Remote Desktop Users Group. This will allow ##
## me to login as users to generate bad login attempts.                     ##
##############################################################################

#Set my Variables
$sourceGroup = "Sales"
$targetGroup = "CN=Remote Desktop Users,CN=Builtin,DC=Adatum,DC=com"

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
$Users = Get-ADUser -Filter "Department -eq '$Department'" | Select-Object Name


foreach ($User in $Users){
    if ($_.badPwdCount -gt 0 ) {
        Write-Host "$User is having trouble logging in!"
    }
    else {
        Write-Host "$User is ok."
    }
}




# This script generates a report to show users that have multiple bad login attempts.

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

#################################################################################
## After you perform the above step, you must go into Group Policy Editor      ##
## by using gpedit.msc in a Run prompt.  Expand Computer Policy >              ##
## Administrative Templates > Windows Components > Remote Desktop Services >   ##
## Remote Desktop Session Host, and then Security.                             ##                                 ##
################################################################################# 


#Ask the user for the department they wish to search

$Department = Read-Host -Prompt 'What department do you want to search?'

# Get the current date and time
$CurrentDate = Get-Date

# Calculate the start of the current week (Sunday)
$StartOfWeek = $CurrentDate.AddDays(-1 * [int]$CurrentDate.DayOfWeek)

# Filter users in the Sales department
$SalesUsers = Get-ADUser -Filter "Department -eq 'Sales'" -Properties badPwdCount,Name

# Iterate through each user
foreach ($User in $SalesUsers) {
    # Check if the user has bad login attempts this week
    if ($User.badPwdCount -gt 0) {
        Write-Host "$($User.Name) has $($User.badPwdCount) bad login attempts this week, their last attempt was on $($User.LastBadPasswordAttempt)."
    }
}







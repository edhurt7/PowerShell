
# Define the action to execute the PowerShell script
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\script.ps1"

# Create a trigger for daily execution
$trigger = New-ScheduledTaskTrigger -Daily -At "3:39pm"

# Register the scheduled task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "MyDailyTask5" -Description "This task runs script.ps1 daily at 3:39pm"


#Start the Task
Start-ScheduledTask -TaskName "MyDailyTask5"



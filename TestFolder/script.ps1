
#Gets a list of Plug-n-Play devices with a status of OK

Get-PnpDevice -PresentOnly |Where-Object {$_.Status -eq 'OK'} | ft -Property Status,FriendlyName,Manufacturer,PSComputerName | Out-File C:\report.txt




# Objects in the Pipeline: Filtering, Grouping, Measuring, Formatting

Return "This is a presentation script file."

#region ForEach-Object

#typical behavior
notepad && notepad && notepad
Get-Process notepad | Stop-Process

#sometimes you need to process objects individually
1..10 | ForEach-Object { $_ * 3 }
"john", "paul", "george", "ringo" | ForEach-Object { $_.toUpper() -replace "[aeio]", "*" }

#endregion

#region Filtering

#filter early
help get-service
Get-Service -Name b*
Get-Service -Name b* -Exclude bits
Get-Process -Name w*

#filter late
Get-Service | Where-Object { $_.starttype -eq 'manual' } | Select-Object Name, Status, StartType
Get-Service | Where-Object { $_.starttype -eq 'automatic' -AND $_.status -ne 'running' } | Select-Object Name, Status, StartType

#alternate syntax
Get-Process -Name w* | Where-Object ws -GE 10MB

#endregion

#region sorting

help Sort-Object

1, 11, 5, 12, 44, 2, 6, 3 | Sort-Object
1, 11, 5, 12, 44, 2, 6, 3 | Sort-Object -Descending

Get-Process | Sort-Object WorkingSet -Descending | Select-Object -Property ID, Name, WorkingSet -First 20

#endregion

#region Converting

Get-Service bits | ConvertTo-Json
#sometimes it helps to be specific
Get-Service bits | Select-Object Name, Displayname, Can*, StartType, Status, ServiceType | ConvertTo-Json
Get-Service bits | Select-Object Name, Displayname, Can*, StartType, Status, ServiceType | ConvertTo-Json | Out-File bits.json
Get-Content bits.json
Get-Content bits.json | ConvertFrom-Json

Get-Process | Select-Object Name, Id, WorkingSet, StartTime, @{Name = "RunTime"; Expression = { (Get-Date) - $_.startTime } } |
ConvertTo-Html

Get-Process | Where-Object { $_.name -ne 'idle' } | Select-Object Name, Id, WorkingSet, StartTime, @{Name = "RunTime"; Expression = { (Get-Date) - $_.startTime } } |
Sort-Object -Property Runtime -Descending |
ConvertTo-Html -Title "Process Report" -PreContent "<H1>$env:computername</H1>" -PostContent "<i>$(Get-Date)</i>" -css .\sample.css |
Out-File .\processes.html

Invoke-Item .\processes.html

Get-Command -Verb Convert*

#endregion

#region Exporting

Get-Process | Where-Object { $_.name -ne 'idle' } | Select-Object Name, Id, WorkingSet, StartTime, @{Name = "RunTime"; Expression = { (Get-Date) - $_.startTime } } |
Export-Csv .\processes.csv

Import-Csv .\processes.csv
Import-Csv .\processes.csv | Where-Object name -EQ 'svchost'

#best for serializing
Get-Service b* | Export-Clixml .\services.xml
Import-Clixml .\services.xml
Import-Clixml .\services.xml | Get-Member
Import-Clixml .\services.xml | Select-Object -First 1 -Property *

Get-Command -Verb export
#endregion

#region Grouping

help Group-Object

Get-Service | Group-Object -Property StartType

Get-Process -IncludeUserName | Where-Object { $null -ne $_.username } | Group-Object username -NoElement | Sort-Object Count -Descending

#endregion

#region Measuring

help measure-object

1, 3, 5, 7, 11, 13, 17, 19, 23, 29 | Measure-Object -Sum

Get-Process w* | Measure-Object -Property WorkingSet -Sum

#this doesn't have to be a single pipelined expression
Get-ChildItem c:\scripts -File | Where-Object { $_.extension -match "\.\w+" } | Group-Object -Property extension |
Select-Object Count, Name,
@{Name = "TotalSize"; Expression = { $_.group | Measure-Object -Property length -Sum | Select-Object -ExpandProperty Sum } } |
Sort-Object TotalSize -Descending | Select-Object -First 10

$files = Get-ChildItem c:\scripts -File | Where-Object { $_.extension -match "\.\w+" }
$grouped = $files | Group-Object -Property extension
$measured = $grouped | Select-Object Count, Name,
@{Name = "TotalSize"; Expression = { $_.group | Measure-Object -Property length -Sum | Select-Object -ExpandProperty Sum } }
$measured | Sort-Object TotalSize -Descending | Select-Object -First 10
#you could turn this into a PowerShell script or function

#there's no end
$measured | Sort-Object TotalSize -Descending | Select-Object -First 10 | ConvertTo-Json | Out-File .\extensions.json
Get-Content .\extensions.json | ConvertFrom-Json | ConvertTo-Html

#endregion

#region formatting

#explain how formatting works Out-Default | Out-Host
Get-Service
Get-Service | Out-Default | Out-Host
Get-Service | Format-List

Get-Process | Select-Object ID, name, ws, company, starttime
#override the default format
Get-Process | Select-Object ID, name, ws, company, starttime | Format-Table

#formatting must be last
Get-Process | Select-Object ID, name, ws, company, starttime | Format-Table | Sort-Object -Property WS -Descending
#get-member is your friend
Get-Process | Select-Object ID, name, ws, company, starttime | Format-Table | Get-Member

Get-Process | Select-Object ID, name, ws, company, starttime | Sort-Object -Property WS -Descending | Format-Table
help format-table
help format-list
help format-wide

#endregion


# PowerShell 7 Fundamentals Crash Course

Return "This is a presentation script file."

#region What is PowerShell?

# Have you heard of PowerShell or use it?

<#
  object-based management engine
  interactive command-line console
  Scripting languages

  Manage on-premises servers and platforms
  Manage cloud-based services like Azure and AWS
  Not the only automation language but a primary one

#>

# Windows PowerShell vs PowerShell 7

# Resources:
# https://microsoft.com/powershell
# https://www.manning.com/books/learn-powershell-in-a-month-of-lunches
# https://www.pluralsight.com/paths/powershell-7-fundamentals
# https://jdhitsolutions.com/blog/essential-powershell-resources/

#endregion

#region PowerShell 7 Installation

# https://github.com/powershell/powershell

# Install from the MS Store
# https://www.microsoft.com/store/apps/9MZ1SNWT0N5D

# Exercise: Install PowerShell 7 from the MS Store

#endregion

#region Launching the Shell

# non-elevated vs elevated

$PSVersionTable

#endregion

#region Basic navigation

#show tab-completion
dir
cd C:\
dir c:\windows\*.exe
dir 'C:\Program Files\' -directory
dir 'C:\Program Files\powershell\*.exe' -Recurse

#run apps
notepad

#run PowerShell commands
# you will learn more about PowerShell commands
Get-Date
Get-Service
Get-Process
Get-Winevent -LogName System -maxEvents 10

Show-Command Get-CimInstance

#did you show finding command history

#endregion

#region Using help

help dir

Update-Help

# review sections of help

help dir -full
help dir -examples
help Get-ChildItem -online
help Get-Service -showwindow

#show inline help from PSReadline in the console

#decode syntax

help process
help get-process
get-process p*

#about topics
help powershell
help about_powershell_editions
help about*

#no online help for about topics
# https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about?view=powershell-7.2

#endregion

#region Finding commands
get-command
get-command *service
# explain command types
#verb-noun naming convention

Get-Verb

Get-Command -noun service

help restart-service

restart-service bits -PassThru

get-command notepad
get-command dir

help get-command
#endregion

#region Aliases

#explain the purpose of aliases
Get-Alias

# What command would you use to create an alias?
<#
    new-alias -name d -value Get-ChildItem
    # aliases only last for the duration of your session
#>

Get-Alias -definition Get-ChildItem

#endregion

#region PSDrives & Providers

cd hklm:
cd software
dir
cd cert:\localmachine\trustedpublisher
dir

cd c:\
Get-PSDrive
Get-Command -noun psdrive
Get-PSprovider

help about*provider
help about_registry_provider

#endregion

#region The PowerShell pipeline

Get-Process | Where-Object {$_.workingset -gt 100MB} | Sort-Object -property WorkingSet -Descending

Get-Service Bits | Stop-Service
help Stop-Service
#inputobject and Name parameters

Get-Service Bits | Stop-Service -PassThru

help about_operators
help about_pipelines

#endregion

#region Objects, not text

Get-Service | Get-Member
Get-Process | Get-Member

#there is more than meets the eye
Get-Process -id $pid
Get-Process -id $pid | Select-Object -property *
Get-Process -id $pid | Select-Object -property ID,StartTime,WS,Commandline | Format-Table -wrap

#formatting commands are always last except for saving to a file or printer
Get-Service | Where-Object {$_.status -eq 'running'} |
Select-Object Name,StartType,Description |
Format-Table -wrap | Out-File $env:temp\services.txt

notepad $env:temp\services.txt

#endregion


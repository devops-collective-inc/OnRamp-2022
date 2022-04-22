#demonstrate PowerShell remoting

Return "This is a demo script file"

#region remoting fundamentals

<#
What is PowerShell remoting?
Why does it matter?
Remoting concepts and terms
 endpoint
 pscredential
 runspace

#>

#endregion

#region enabling remoting

#remoting requirements

Enable-PSRemoting

#enabling remoting is merely the first step. You still need to secure it.

#you can disable remoting at any time
# Disable-PSRemoting

#endregion

#region winrm

Get-Service winrm
Test-WSMan

Test-WSMan -ComputerName srv1

#also test credentials
$cred = Get-Credential company\artd

Test-WSMan -ComputerName srv1 -Credential $cred -Authentication Default

#bad credential
Test-WSMan -ComputerName srv1 -Credential foo -Authentication Default

#endregion

#region one-to-one
#run this in a console session, not VSCode
Enter-PSSession -ComputerName SRV1 -Credential company\artd
hostname
Get-Host
#notice the version
$PSVersionTable

Get-PSSessionConfiguration

Get-Volume

cd HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation
Get-Item .
Exit

#use a specific endpoint
Enter-PSSession -ComputerName SRV1 -Credential $cred -ConfigurationName "Powershell.7"
$PSVersionTable
Get-Date && Get-TimeZone
whoami
Exit

#endregion

#region one-to-many

Invoke-Command -ScriptBlock { Get-Service bits } -ComputerName SRV1, SRV2 -Credential $cred


Invoke-Command -ScriptBlock { $x = 123 ; $x+$x } -ComputerName SRV1 -Credential $cred
Invoke-Command -ScriptBlock { $x} -ComputerName SRV1 -Credential $cred

#PSSessions
#what if I didn't specify the endpoint?
$s = New-PSSession -computer dom1, srv1, srv2 -Credential $cred #-ConfigurationName "Powershell.7"
$s

#now persistance
Invoke-Command -ScriptBlock { $x = 123 ; $x+$x } -session $s
Invoke-command {$x} -session $s

#manage at scale
Invoke-Command { Get-Service bits } -Session $s
$sb = {
    if (-Not (Test-Path C:\Data)) {
        New-Item -Path C:\ -Name Data -ItemType Directory
    }
    Get-Process | Sort-Object -Property WorkingSet -Descending |
    Select-Object -First 10 | Export-Clixml c:\data\topproc.xml
}

Invoke-Command -ScriptBlock $sb -Session $s
Invoke-Command { Test-Path c:\data } -Session $s

Invoke-Command { Import-Clixml c:\data\topproc.xml } -Session $s

Invoke-Command { Import-Clixml c:\data\topproc.xml } -Session $s | Sort-Object PSComputername, WorkingSet |
Format-Table -GroupBy PSComputername

#demo reset
# Invoke-command { remove-item c:\data -Recurse -force } -session $s

#endregion

#region ssh

# ssh is an open source protocol. Installed separately from PowerShell
Get-CimInstance win32_service -Filter "name='sshd'" -ComputerName srv1, srv2, dom1,dom2
#run this in a console session, not VSCode
Enter-PSSession -HostName srv1 -UserName artd
$PSVersionTable
whoami
Exit

Invoke-Command -ScriptBlock { dir c:\ } -HostName srv1 -UserName artd
#run commands cross-platform
#setting up ssh with shared keys makes this easier
New-PSSession -HostName fred-company-com -UserName jeff  #Linux
New-PSSession -HostName srv1 -UserName artd
New-PSSession -HostName srv2 -UserName artd

#create a wsman session
New-PSSession -ComputerName dom2 -Credential company\artd

$all = Get-PSSession
$all

Invoke-Command { Get-Process | Sort-Object -Property Workingset -Descending | Select-Object -First 1 } -Session $all

Get-PSSession | Remove-PSSession

#endregion


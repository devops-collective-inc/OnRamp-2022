#demo PowerShell scope

#run this in a traditional PowerShell session
if ($host.name -match "ise|code") {
   Write-Warning "Run this in a traditional PowerShell session"
   #Bail out
   return
}

$Name = "Foo"

"Hello $Name"

New-PSDrive SW -PSProvider registry -Root HKLM:\SOFTWARE

dir sw: | select Name


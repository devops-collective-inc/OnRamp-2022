
#dot source the functions

Get-Childitem $PSScriptRoot\functions\*.ps1 |
Foreach-Object {. $_.fullname}

# uncomment if not using a module manifest
# Export-ModuleMember -function Get-TopProcess,Get-HotFixReport,Get-ComputerUptime -alias hfr
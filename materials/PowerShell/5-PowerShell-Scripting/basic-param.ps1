Param(
    [string[]]$Computername = $env:COMPUTERNAME,
    [pscredential]$Credential
)

#there are better ways to pass parameter values.
if ($Credential) {
    $hot = Get-HotFix -ComputerName $Computername -Credential $Credential
}
else {
    $hot = Get-HotFix -ComputerName $Computername
}

$hot | Select-Object -Property @{Name = "Computername"; Expression = { $_.PSComputername } },
HotFixID, Description, InstalledBy,
@{Name = "Installed"; Expression = { $_.InstalledOn -as [datetime] } },
@{Name = "Online"; Expression = { $_.Caption } } |
Sort-Object -Property Installed

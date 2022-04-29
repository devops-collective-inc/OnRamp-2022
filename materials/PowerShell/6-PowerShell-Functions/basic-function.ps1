
<#
 Use the Verb-noun naming convention
 Get-Verb
#>

Function Get-HotFixReport {
    Param(
        [string[]]$Computername = $env:COMPUTERNAME,
        [pscredential]$Credential
    )

    #this function lacks error handling
    #there are better ways to pass parameter values.
    if ($Credential) {
        $hot = Get-HotFix -ComputerName $Computername -Credential $Credential
    }
    else {
        $hot = Get-HotFix -ComputerName $Computername
    }

    #functions should write one-kind of object to the pipeline
    #this version adds a new property
    $hot | Select-Object -Property @{Name = "Computername"; Expression = { $_.PSComputername } },
    HotFixID, Description, InstalledBy,
    @{Name = "Installed"; Expression = { $_.InstalledOn -as [datetime] } },
    @{Name = "Online"; Expression = { $_.Caption } },
    @{Name = "ReportDate" ; Expression = { Get-Date } } |
    Sort-Object -Property Installed
}
#requires -version 7.2

#this function lacks error handling


Function Get-HotFixReport {
    <#
    .SYNOPSIS
    Get a hot fix report
    .DESCRIPTION
    Run this command to create a hot fix report for one or more remote computers.
    .PARAMETER Computername
    Specify the name of one or more remote computers. You must have adminstrator rights on the remote computer.
    The default is the local computer. The parameter has an alias of CN.
    .PARAMETER Credential
    Specify an alternate credential for the remote computer. The parameter has an alias of RunAs.
    .EXAMPLE
    PS C:\> Get-HotFixReport -ComputerName srv1

    Computername : SRV1
    HotFixID     : KB3192137
    Description  : Update
    InstalledBy  :
    Installed    : 9/12/2016 12:00:00 AM
    Online       : http://support.microsoft.com/?kbid=3192137
    ReportDate   : 4/22/2022 10:36:28 AM

    Computername : SRV1
    HotFixID     : KB3211320
    Description  : Update
    InstalledBy  :
    Installed    : 1/7/2017 12:00:00 AM
    Online       : http://support.microsoft.com/?kbid=3211320
    ReportDate   : 4/22/2022 10:36:28 AM

    Computername : SRV1
    HotFixID     : KB5011570
    Description  : Security Update
    InstalledBy  : NT AUTHORITY\SYSTEM
    Installed    : 4/4/2022 12:00:00 AM
    Online       : https://support.microsoft.com/help/5011570
    ReportDate   : 4/22/2022 10:36:28 AM
    .LINK
    Get-HotFix
    #>
    [cmdletbinding()]
    [alias("hfr")]
    Param(
        [Parameter(Position = 0)]
        [alias("CN")]
        [ValidateNotNullOrEmpty()]
        [string[]]$Computername = $env:COMPUTERNAME,

        [ValidateNotNullOrEmpty()]
        [alias("runas")]
        [pscredential]$Credential
    )

    Write-Verbose "Running Get-HotFixReport"
    Write-Verbose "Getting hotfixes from $computername"
    #there are better ways to pass parameter values.

    #the PowerShell 7 way using the ternary operator
    #help about_If
    $hot = $credential ? (Get-HotFix -ComputerName $Computername -Credential $Credential) : (Get-HotFix -ComputerName $Computername)

    <#
        the legacy way to test the parameter using an If statement
        if ($Credential) {
            Write-Verbose "Using an alternate credential"
            $hot = Get-HotFix -ComputerName $Computername -Credential $Credential
        }
        else {
            $hot = Get-HotFix -ComputerName $Computername
        }
    #>

    #functions should write one-kind of object to the pipeline
    #this version adds a new property
    $hot | Select-Object -Property @{Name = "Computername"; Expression = { $_.PSComputername } },
    HotFixID, Description, InstalledBy,
    @{Name = "Installed"; Expression = { $_.InstalledOn -as [datetime] } },
    @{Name = "Online"; Expression = { $_.Caption } },
    @{Name = "ReportDate" ; Expression = { Get-Date } } |
    Sort-Object -Property Installed

    Write-Verbose "Finishing Get-HotFixReport"
} #close function
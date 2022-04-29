#demonstrate basic PowerShell functions

Return "This is a demonstration script file"

#region what is a function?

Dir Function:

Get-command -CommandType function

help about_function*

#endregion

#region writing a function

psedit .\basic-function.ps1

#endregion

#region using a function

#this won't work the way you might expect
.\basic-function.ps1
Get-HotFixReport
Get-Command -name Get-HotFixReport
#do you remember why?
. .\basic-function.ps1
Get-HotFixReport
help Get-HotFixReport

#endregion

#region enhancing the function

psedit .\basic-function2.ps1

. .\basic-function2.ps1
help Get-HotFixReport

Get-HotFixReport -computername $null
Get-HotFixReport

Get-Command hfr
hfr -cn srv1,srv2,dom2,dom1 -runas $cred -verbose -OutVariable hot | Sort-object Computername |
Export-CSV .\hotfixreport.csv

$hot

import-csv .\hotfixreport.csv

#endregion
#Intro to PowerShell scripting

Return "This is a demonstration script file"

#region scripting intro

# what is a script and why is it useful?
# why automation?

#endregion

#region scripting security

# code signing
# code path
# Execution Policy
Get-ExecutionPolicy
help Set-ExecutionPolicy
#run elevated
Set-executionPolicy RemoteSigned

#endregion

#region scope

psedit .\demo-scope.ps1

#run in session
cd 'C:\Training\OnRamp\2022\materials\PowerShell\5-PowerShell-Scripting'
#set variable in global session, re-run script
.\demo-scope.ps1

#explain scope rules
help new-psdrive -parameter scope

# demo dot-sourcing
. .\demo-scope.ps1

help about_Scope
#endregion

#region a basic script

psedit .\basic.ps1

#test execution policy at console
Set-executionpolicy restricted -force
#extens not required
.\basic
Set-executionpolicy remotesigned -force
#I like to be explicit
.\Basic.ps1

#endregion

#region parameters

psedit .\basic-param.ps1

.\basic-param.ps1

.\basic-param.ps1 -Computername srv1 -Credential company\artd

#don't include formatting in the script
.\basic-param.ps1 -Computername srv1,srv2,dom1,dom2 -Credential company\artd |
Sort-Object Computername,Description,Installed |
Format-Table -GroupBy Computername -Property Description,HotFixID,Installed*

#endregion


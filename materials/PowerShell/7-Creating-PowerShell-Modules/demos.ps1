#demo PowerShell module fundamentals


#region What is a module?

help about_modules

# definition
# why?

#endregion

#region module fundamentals

#.psm1 file extension

psedit .\MyReporting.psm1
Import-Module .\MyReporting.psm1 #-force
Get-Module MyReporting
Get-Command -Module MyReporting

Get-TopProcess -Computername srv1 -Credential company\artd -Verbose

Get-ComputerUptime srv1, srv2, dom1 -Credential company\artd

#revisit $env:PSModulePath

#endregion

#region module layout

#describe folder and naming requirements

#look at module layout
dir .\MyReporting -Recurse

#endregion

#region module manifest
help New-ModuleManifest

<#
I might need to clear some defaults I am using
$PSDefaultParameterValues['disabled'] = $true
#>
New-ModuleManifest -Path .\MyReporting\MyReporting.psd1 -RootModule myreporting.psm1 -Author "Art Deco"
#fill out the manifest
psedit .\MyReporting\MyReporting.psd1

#my finished manifest
psedit .\baked.psd1
copy .\baked.psd1 -Destination .\MyReporting\myreporting.psd1

#reset the environment
Remove-Module myreporting
Import-Module .\MyReporting -Force
Get-Module myreporting

#public functions only
Get-Command -Module MyReporting

#endregion

#region adding help

# Install-Module Playtps
Import-Module platyps
#move to the module root so paths are relative
cd .\myreporting
import-module .\MyReporting.psd1 -force
#generate intermediate markdown
New-MarkdownHelp -Module MyReporting -OutputFolder .\docs\

#edit
psedit .\docs\Get-TopProcess.md
#comment-based help is automatically imported
psedit .\docs\Get-HotFixReport.md

#generate external help
New-ExternalHelp -Path .\docs\ -OutputPath .\en-us\ -Force

import-module .\MyReporting.psd1 -force
help Get-TopProcess
help hfr

#endregion


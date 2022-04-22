#Demonstrate extending powershell with modules

Return "This is a presentation script file"

#region intro

#introduce the concept of a PowerShell module

help about_modules
#endregion

#region installed modules
Get-Module

Get-Module -ListAvailable

Import-Module NetAdapter
Get-Module
Get-Command -Module NetAdapter

help Get-netadapter
Get-NetAdapter

#remove module
Remove-Module NetAdapter
Get-Module net*

#automatic importing
$env:PSModulePath
Get-NetAdapter
Get-Module net*

#endregion

#region PowerShellGet and Find-Module

Start-Process https://powershellgallery.com
Get-Module powershellget -ListAvailable

# install-module powershellget

#you might need this if you get errors accessing the PwoerShell Gallery
# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Find-Module PSTeachingtools
Find-Module -Tag file
#pipe to Get-Member to discover property names
Find-Module -Tag file | Select-Object Name, Version, PublishedDate, Author, Description, ProjectURI,
@{Name = "Functions"; Expression = { $_.AdditionalMetadata.Functions.split() } } |
Sort-Object PublishedDate

#endregion

#region install module

#explain installation scope

#find-module AdminToolbox.FileManagement | Install-Module
Install-Module AdminToolbox.FileManagement -Scope allusers
Import-Module AdminToolbox.FileManagement
Get-Command -Module AdminToolbox.FileManagement

help get-fileowner
Get-FileOwner . -Report .\fileowners.csv
Get-Content .\fileowners.csv
Import-Csv .\fileowners.csv

help get-foldersize
Get-FolderSize c:\scripts MB

#use Update-Module to get latest version
# Update-Module
# Update-Module AdminToolbox.FileManagement

#endregion

#region uninstall module
Remove-Module AdminToolbox.FileManagement
Uninstall-Module AdminToolbox.FileManagement
#commands are gone
Get-FolderSize . MB

#endregion


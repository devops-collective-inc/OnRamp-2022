#requires -version 5.1

Get-Hotfix |
Select-Object -Property @{Name="Computername";Expression={$_.PSComputername}},
HotFixID,Description,InstalledBy,
@{Name="Installed";Expression={$_.InstalledOn -as [datetime]}},
@{Name="Online";Expression={$_.Caption}} |
Sort-Object -Property Installed


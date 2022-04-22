#
# Module manifest for module 'MyReporting'
# this version deletes unused sections

@{

# Script module or binary module file associated with this manifest.
RootModule = 'myreporting.psm1'

# Version number of this module.
ModuleVersion = '0.1.0'

# Supported PSEditions
CompatiblePSEditions = @('Core')

# ID used to uniquely identify this module
GUID = '1d64a464-cb5e-4990-87a2-dc2037ae4a5b'

# Author of this module
Author = 'Art Deco'

# Company or vendor of this module
CompanyName = 'Company.pri'

# Copyright statement for this module
Copyright = '(c) Art Deco. All rights reserved.'

# Description of the functionality provided by this module
 Description = 'A set of PowerShell reporting tools. The module is written to be run from a PowerShell 7 desktop but can query Windows PowerShell-based servers.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '7.2'

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Get-ComputerUptime','Get-HotFixReport','Get-TopProcess'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = ''

# Variables to export from this module
VariablesToExport = ''

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'hfr'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable


}


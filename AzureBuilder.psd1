@{

# Script module or binary module file associated with this manifest.
RootModule = 'AzureBuilder.psm1'

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = '259bb578-a739-42ba-be17-b411f07cdbed'

# Author of this module
Author = 'Jamie Taffurelli'

# Copyright statement for this module
Copyright = '(c) 2019 Jamie Taffurelli. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This module aim to provide a set of cmdlets and templates to deploy and modify resources in a security compliant way'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @('az')

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/JamieTaffurelli/AzureBuilder'

}


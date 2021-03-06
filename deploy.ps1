[CmdletBinding()]
param
(
    [Parameter(Mandatory = $true)]
    [string]
    $rgName,

    [Parameter(Mandatory = $true)]
    [string]
    $templateName,

    [Parameter(Mandatory = $true)]
    [string]
    $templateParametersName,

    [Parameter(Mandatory = $true)]
    [string]
    $templateSas
)

$secTemplateSas = ConvertTo-SecureString -String $templateSas -AsPlainText -Force

New-AzResourceGroupDeployment `
    -Name (New-Guid) `
    -ResourceGroupName $rgName `
    -TemplateParameterFile ".\examples\${templateParametersName}.parameters.json" `
    -TemplateFile ".\examples\${templateName}.json" `
    -TemplatesSas $secTemplateSas `
    -Verbose

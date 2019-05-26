function Test-AzBuildBlobItem
{
    <#
        .DESCRIPTION
        

        .EXAMPLE
        
    #>
    [CmdletBinding(DefaultParameterSetName = 'DynamicAuth')]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $StorageAccountName,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $ContainerName,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Blob,

        [Parameter(ParameterSetName = 'DynamicAuth')]
        [ValidateSet('OAuth', 'Key', 'Anonymous')]
        [String]
        $AuthMethod = 'OAuth',

        [Parameter(Mandatory = $true, ParameterSetName = 'StaticKeyAuth')]
        [ValidateNotNullOrEmpty()]
        [String]
        $StorageAccountKey,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'StaticSasAuth')]
        [ValidateNotNullOrEmpty()]
        [String]
        $SasToken,

        [Parameter(Mandatory = $true, ParameterSetName = 'StorageContext')]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Azure.Commands.Common.Authentication.Abstractions.IStorageContext]
        $StorageContext
    )
    begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"

        switch($PSCmdlet.ParameterSetName)
        {
            "DynamicAuth"
            {
                $context = New-AzBuildStorageContext -StorageAccountName $StorageAccountName -AuthMethod $AuthMethod
                break
            }
            "StaticKeyAuth"
            {
                $context = New-AzBuildStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
                break
            }
            "StaticSasAuth"
            {
                $context = New-AzBuildStorageContext -StorageAccountName $StorageAccountName -SasToken $SasToken
                break
            }
            "StorageContext"
            {
                $context = $StorageContext
                break
            }
            default
            {
                throw "Parameter set not recognised"
            }
        }
    }
    process
    {
        try
        {   
            if(Get-AzStorageBlob -Blob $Blob -Container $ContainerName -Context $context -ErrorAction Stop)
            {
                return $true
            }
            else 
            {
                return $false
            }
        }
        catch [Microsoft.WindowsAzure.Commands.Storage.Common.ResourceNotFoundException]
        {
            return $false
        }
        catch
        {
            Write-Error $PSItem
        }
    }
    end
    {
        Write-Verbose "Finished $($MyInvocation.MyCommand.Name)"
    }
}
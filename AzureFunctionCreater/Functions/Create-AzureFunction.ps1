Function Create-AzureFunction
{
<#
	.SYNOPSIS
		This will create an Azure Function.

	.DESCRIPTION
		This will create an Azure Function and all attendant files\services.

	.EXAMPLE
		Give an example of how to use it

	.EXAMPLE
		Give another example of how to use it

	.PARAMETER BaseName
		This will be the base for Resource Groups, Storage Accounts, etc.
		This must be between 3 and 20 characters due to Azure limitations.

	.PARAMETER Location
		This will be the Azure regional location

	.PARAMETER StorageSKU
		This will be the type or Storage required

	.PARAMETER CodePath
		This will be the location of the code.

	.PARAMETER Logfile
		This will be the location of the logfile.

	.INPUTS
		Input is from command line or called from a script.

	.OUTPUTS
		This will output a logfile and a Function App.

	.NOTES
		Version:			0.1
		Author:				Lars Panzerbjørn
		Creation Date:		2019.10.24
		Purpose/Change: Initial script development
#>
	[CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
	param
	(
		[Parameter(Mandatory,
			ValueFromPipeline=$True,
			ValueFromPipelineByPropertyName=$True,
			HelpMessage='What base name would you like to use?')]
		[ValidateLength(3,20)]
		[string[]]$BaseName,

		[Parameter(
			ValueFromPipeline=$True,
			ValueFromPipelineByPropertyName=$True,
			HelpMessage='What location would you like to use?')]
		[string[]]$Location = "northeurope",

		[Parameter(
			ValueFromPipeline=$True,
			ValueFromPipelineByPropertyName=$True,
			HelpMessage='What location would you like to use?')]
		[string[]]$StorageSku = 'Standard_LRS',

		[Parameter()]
		[string]$Logfile = 'errors.txt'
	)

	BEGIN
	{
		Write-Verbose "Creating log $LognPath"
		Write-LogFile -LogFilePath $Logfile -Message "Processing Begins"
		$RGName = $BaseName + "RG"
		Write-Verbose "Resource Group name is $RGName"
		$StorageAccountName = $BaseName + "SA"
		
	}

	PROCESS
	{
		Write-Verbose "Beginning process loop"
		
		Write-Verbose "Registering Providers"
		@('Microsoft.Web', 'Microsoft.Storage') | ForEach-Object {Register-AzResourceProvider -ProviderNamespace $_}

		Write-Verbose "Attempting to create Azure Resource Group $$RGName"
		Write-LogFile -LogFilePath $Logfile -Message "Attempting to create Azure Resource Group"
		$ResourceGroup = Get-AzResourceGroup -Name $RGName -ErrorAction SilentlyContinue

	}
	END
	{
		Write-Verbose "Ending $($MyInvocation.Mycommand)"
	}
}
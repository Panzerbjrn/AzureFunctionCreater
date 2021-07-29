#region Script Header
#	Thought for the day:
#	NAME: $($ModuleName).psm1
#	AUTHOR: $($Author)
#	CONTACT: GitHub: Panzerbjrn / Twitter: Panzerbjrn
#	DATE: $($Date)
#	VERSION: 0.1 - $($Date) - Module Created with Create-NewModuleStructure by Lars Panzerbjørn
#
#	SYNOPSIS:
#
#
#	DESCRIPTION:
#	$($Description)
#
#	REQUIREMENTS:
#
#endregion Script Header

#Requires -Version 4.0

[cmdletbinding()]
param()

Write-Verbose $PSScriptRoot

#Get public and private function definition files.
$Functions  = @( Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 -ErrorAction SilentlyContinue )
$Helpers = @( Get-ChildItem -Path $PSScriptRoot\Helpers\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach ($Import in @($Functions + $Helpers))
{
	Try
	{
		Write-Verbose "Processing $($Import.Fullname)"
		. $Import.Fullname
	}
	Catch
	{
		Write-Error -Message "Failed to Import function $($Import.Fullname): $_"
	}
}

Export-ModuleMember -Function $Functions.Basename

# failsafe
return

$projectPath = "C:\Sessions\PSConf.Logging"

Install-Module PSFramework

# Writing Messages
Write-PSFMessage "Foo"
Write-PSFMessage "Foo" -Verbose
Write-PSFMessage "Foo" -Level Host

# The In-Memory Log
Get-PSFMessage
$msg = Get-PSFMessage
$msg[-1] | fl

# The Logging Provider
Get-PSFLoggingProvider


# Logging and Configuration
code "$projectPath\logfile.config.psd1"
Import-PSFConfig -Path "$projectPath\logfile.config.psd1" -Schema MetaJson
Get-PSFLoggingProviderInstance

Write-PSFMessage Hello
Set-PSFLoggingProvider -Name logfile -InstanceName FromConfig -Enabled $false
Set-PSFLoggingProvider -Name logfile -InstanceName FromConfig -Enabled $true


# Multilingual
code "$projectPath\messages.de.psd1"
code "$projectPath\messages.en.psd1"

Import-PSFLocalizedString -Module PSConfDemo -Language de-DE -Path "$projectPath\messages.de.psd1"
Import-PSFLocalizedString -Module PSConfDemo -Language en-US -Path "$projectPath\messages.en.psd1"

Write-PSFMessage -Level Host -ModuleName PSConfDemo -String 'Hello.User' -StringValues Attendees
Set-PSFConfig -FullName PSFramework.Localization.Language -Value de-DE
Write-PSFMessage -Level Host -ModuleName PSConfDemo -String 'Hello.User' -StringValues Attendees

#region Protected Command
#region Too much effort
function Remove-File {
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[string[]]
		$Path
	)

	process {
		foreach ($filePath in $Path) {
			if ($PSCmdlet.ShouldProcess("Delete", $filePath)) {
				try {
					Write-PSFMessage "Deleting: $filePath"
					Remove-Item -Path $filePath -Force -Recurse -ErrorAction Stop
					Write-PSFMessage "Deleting: $filePath - Success!"
				}
				catch {
					Write-PSFMessage -Level Error "Deleting: $filePath - failed!" -ErrorRecord $_
					Write-Error $_
					continue
				}
			}
		}
	}
}
#endregion Too much effort

#region Lazy
function Remove-File {
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[string[]]
		$Path,

		[switch]
		$EnableException
	)

	process {
		foreach ($filePath in $Path) {
			Invoke-PSFProtectedCommand -Action "Deleting $filePath" -Target $filePath -ScriptBlock {
				Remove-Item -Path $filePath -Force -Recurse -ErrorAction Stop
			} -PSCmdlet $PSCmdlet -EnableException $EnableException
		}
	}
}
#endregion Lazy
#endregion Protected Command
# Waiting for Logging to Complete
Wait-PSFMessage

# The Support Package
New-PSFSupportPackage -Path C:\temp\demo
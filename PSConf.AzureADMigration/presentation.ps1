# Failsafe
return



 #----------------------------------------------------------------------------# 
 #                                   Links                                    # 
 #----------------------------------------------------------------------------# 

<#
Announcement:
https://techcommunity.microsoft.com/t5/azure-active-directory-identity/azure-ad-change-management-simplified/ba-p/2967456
-> Possibly by the end of the year
-> Licensing Assignment by August 26th
#>

<#
Docs:
> Guide:
https://docs.microsoft.com/en-us/powershell/microsoftgraph/migration-steps?view=graph-powershell-beta

> Cmdlet Mapping
https://docs.microsoft.com/en-us/powershell/microsoftgraph/azuread-msoline-cmdlet-map?view=graph-powershell-beta

> Mapping Command / Url to permissions needed:
https://docs.microsoft.com/en-us/powershell/microsoftgraph/find-mg-graph-command?view=graph-powershell-beta
#>


 #----------------------------------------------------------------------------# 
 #                                   Tools                                    # 
 #----------------------------------------------------------------------------# 

# PSAzureMigrationAdvisor
#-> Github:  https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor
#-> Gallery: https://www.powershellgallery.com/packages/PSAzureMigrationAdvisor
Install-Module PSAzureMigrationAdvisor

$presentationRoot = 'C:\Sessions\PSConf.AzureADMigration'
code "$presentationRoot\azuread.sample.ps1"

Get-Item "$presentationRoot\azuread.sample.ps1" | Read-AzScriptFile
Get-Item "$presentationRoot\azuread.sample.ps1" | Read-AzScriptFile | Export-Excel .\report.xlsx
Invoke-Item .\report.xlsx

<#
Where does the data come from?
https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor/tree/master/data
#>

#region Next Level
# AzureDevOps.Services.OpenApi
#-> Github:  https://github.com/FriedrichWeinmann/AzureDevOps.Services.OpenApi
#-> Gallery: https://www.powershellgallery.com/packages/AzureDevOps.Services.OpenApi
Install-Module AzureDevOps.Services.OpenApi

$cred = Get-Secret -Name DevOpsPAT
Connect-AdsService -Credential $cred
Get-AdsRepositoryFile -Organization fred0251 -IncludeContent -Name *.ps1,*.psm1 | Read-AzScriptFile
Get-AdsRepositoryFile -Organization fred0251 -IncludeContent -Name *.ps1,*.psm1 | Read-AzScriptFile | Export-Excel .\report2.xlsx
Invoke-Item .\report2.xlsx
Get-AdsRepositoryFile -Organization fred0251 -IncludeContent -Name *.ps1,*.psm1 | Read-AzScriptFile -ExpandDevOps | Export-Excel .\report3.xlsx
Invoke-Item .\report3.xlsx

# Any other source:
$datum = [PSCustomObject]@{
	Name = "MyCode.ps1"
	Content = @'
Get-AzureADApplication | Remove-AzureADApplication
'@
}
$datum | Read-AzScriptFile
#endregion Next Level


 #----------------------------------------------------------------------------# 
 #                                  Refactor                                  # 
 #----------------------------------------------------------------------------# 

<#
Link: https://github.com/FriedrichWeinmann/Refactor

+ Code Analysis
+ Breaking Change Scan
+ Search and Replace / Refactoring using AST, rather than plain string replacements
+ Extensible Framework
#>

Get-Command -Module Refactor
Import-ReTokenTransformationSet -Path C:\Sessions\PSConf.AzureADMigration\command.transform.psd1
Read-ReScriptCommand -Path C:\Sessions\PSConf.AzureADMigration\refactor.commands.ps1
$result = Convert-ReScriptFile -Path C:\Sessions\PSConf.AzureADMigration\refactor.commands.ps1 -Backup
$result
$result.Messages

<#
All the Links in one spot:

> Official Docs
Announcement: https://techcommunity.microsoft.com/t5/azure-active-directory-identity/azure-ad-change-management-simplified/ba-p/2967456
Migration Guide: https://docs.microsoft.com/en-us/powershell/microsoftgraph/migration-steps?view=graph-powershell-beta
Cmdlet Mapping: https://docs.microsoft.com/en-us/powershell/microsoftgraph/azuread-msoline-cmdlet-map?view=graph-powershell-beta
Mapping Command to permissions: https://docs.microsoft.com/en-us/powershell/microsoftgraph/find-mg-graph-command?view=graph-powershell-beta

> Tools
PSAzureMigrationAdvisor
-> Github:  https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor
-> Gallery: https://www.powershellgallery.com/packages/PSAzureMigrationAdvisor
-> Data:    https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor/tree/master/data
AzureDevOps.Services.OpenApi
-> Github:  https://github.com/FriedrichWeinmann/AzureDevOps.Services.OpenApi
-> Gallery: https://www.powershellgallery.com/packages/AzureDevOps.Services.OpenApi
Refactor
-> Github:  https://github.com/FriedrichWeinmann/Refactor
-> Gallery: https://www.powershellgallery.com/packages/Refactor
#>
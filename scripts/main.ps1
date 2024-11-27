#Requires -Modules GitHub

[CmdletBinding()]
param()

$requiredModules = 'Utilities', 'powershell-yaml', 'PSSemVer', 'Pester', 'PSScriptAnalyzer'
$requiredPreviewModules = 'Microsoft.PowerShell.PlatyPS'

$requiredModules | Sort-Object | ForEach-Object {
    $moduleName = $_
    LogGroup "Installing prerequisite: [$moduleName]" {
        Install-PSResource -Name $moduleName -TrustRepository -Repository PSGallery
        Write-Verbose (Get-PSResource -Name $moduleName | Select-Object * | Out-String)
    }
}
$requiredPreviewModules | Sort-Object | ForEach-Object {
    $moduleName = $_
    LogGroup "Installing prerequisite: [$moduleName] (prerelease)" {
        Install-PSResource -Name $moduleName -TrustRepository -Repository PSGallery -Prerelease
        Write-Verbose (Get-PSResource -Name $moduleName | Select-Object * | Out-String)
    }
}

Get-PSResource -Name $requiredModules -Verbose:$false | Sort-Object -Property Name |
    Format-Table -Property Name, Version, Prerelease, Repository -AutoSize -Wrap

#REQUIRES -Modules GitHub

[CmdletBinding()]
param()

$requiredModules = 'Utilities', 'powershell-yaml', 'PSSemVer', 'Pester', 'PSScriptAnalyzer', 'platyPS'

$requiredModules | ForEach-Object {
    $moduleName = $_
    LogGroup "Installing prerequisite: [$moduleName]" {
        Install-PSResource -Name $moduleName -TrustRepository -Repository PSGallery
    }
}

$requiredModules | Get-PSResource -Name $moduleName

# LogGroup 'Loading helper scripts' {
#     Get-ChildItem -Path (Join-Path -Path $env:GITHUB_ACTION_PATH -ChildPath 'scripts\helpers') -Filter '*.ps1' -Recurse |
#         ForEach-Object { Write-Verbose "[$($_.FullName)]"; . $_.FullName }
# }

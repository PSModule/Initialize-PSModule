#REQUIRES -Modules GitHub

[CmdletBinding()]
param()

'Utilities', 'powershell-yaml', 'PSSemVer', 'Pester', 'PSScriptAnalyzer', 'platyPS' | ForEach-Object {
    $moduleName = $_
    LogGroup "Installing prerequisite: [$moduleName]" {
        Install-PSResource -Name $moduleName -TrustRepository -Repository PSGallery
        Get-PSResource -Name $moduleName
    }
}

LogGroup 'Loading helper scripts' {
    Get-ChildItem -Path (Join-Path -Path $env:GITHUB_ACTION_PATH -ChildPath 'scripts\helpers') -Filter '*.ps1' -Recurse |
        ForEach-Object { Write-Verbose "[$($_.FullName)]"; . $_.FullName }
}

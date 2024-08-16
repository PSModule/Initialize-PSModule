#REQUIRES -Modules GitHub

[CmdletBinding()]
param()

'Utilities', 'powershell-yaml', 'PSSemVer', 'Pester', 'PSScriptAnalyzer', 'platyPS' | ForEach-Object {
    LogGroup "Installing prerequisite: [$_]" {
        Install-PSResource -Name $_ -TrustRepository -Repository PSGallery
        Get-Module -Name $_ | Select-Object *
    }
}

LogGroup 'Loading helper scripts' {
    Get-ChildItem -Path (Join-Path -Path $env:GITHUB_ACTION_PATH -ChildPath 'scripts\helpers') -Filter '*.ps1' -Recurse |
        ForEach-Object { Write-Verbose "[$($_.FullName)]"; . $_.FullName }
}

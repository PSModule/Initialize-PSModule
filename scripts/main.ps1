#REQUIRES -Modules GitHub

[CmdletBinding()]
param()

LogGroup 'Install RequiredResources' {
    Install-PSResource -TrustRepository -Repository PSGallery -RequiredResource @{
        Utilities         = @{}
        'powershell-yaml' = @{}
        PSSemVer          = @{}
        Pester            = @{}
        PSScriptAnalyzer  = @{}
        platyPS           = @{}
    }
}

'Utilities', 'powershell-yaml', 'PSSemVer', 'Pester', 'PSScriptAnalyzer', 'platyPS' | ForEach-Object {
    LogGroup "Installing prerequisite: [$_]" {
        Install-PSResource -Name $_ -TrustRepository -Repository PSGallery
        Import-Module -Name $_
        Get-Module -Name $_
    }
}

LogGroup 'Loading helper scripts' {
    Get-ChildItem -Path (Join-Path -Path $env:GITHUB_ACTION_PATH -ChildPath 'scripts\helpers') -Filter '*.ps1' -Recurse |
        ForEach-Object { Write-Verbose "[$($_.FullName)]"; . $_.FullName }
}

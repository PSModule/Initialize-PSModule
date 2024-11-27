#Requires -Modules GitHub

[CmdletBinding()]
param()
$requiredModules = @{
    Utilities                      = @{}
    'powershell-yaml'              = @{}
    PSSemVer                       = @{}
    Pester                         = @{}
    PSScriptAnalyzer               = @{}
    PlatyPS                        = @{}
    # 'Microsoft.PowerShell.PlatyPS' = @{
    #     Prerelease = $true
    # }
}

$requiredModules.GetEnumerator() | Sort-Object | ForEach-Object {
    $name = $_.Key
    $settings = $_.Value
    LogGroup "Installing prerequisite: [$name]" {
        Install-PSResource -Name $name -TrustRepository -Repository PSGallery @settings
        Write-Verbose (Get-PSResource -Name $name | Select-Object * | Out-String)
        Write-Verbose (Get-Command -Module $name | Out-String)
    }
}

$requiredModules.Keys | Get-InstalledPSResource -Verbose:$false | Sort-Object -Property Name |
    Format-Table -Property Name, Version, Prerelease, Repository -AutoSize -Wrap

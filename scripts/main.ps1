#Requires -Modules GitHub

[CmdletBinding()]
param()

$requiredModules = 'Utilities', 'powershell-yaml', 'PSSemVer', 'Pester', 'PSScriptAnalyzer', 'platyPS'

$requiredModules | Sort-Object | ForEach-Object {
    $moduleName = $_
    LogGroup "Installing prerequisite: [$moduleName]" {
        Install-PSResource -Name $moduleName -TrustRepository -Repository PSGallery
        Write-Verbose (Get-PSResource -Name $moduleName | Select-Object * | Out-String)
    }
}

Get-PSResource -Name $requiredModules -Verbose:$false | Sort-Object -Property Name |
    Format-Table -Property Name, Version, Prerelease, Repository -AutoSize -Wrap

LogGroup "Loading environment variables:" {
    Get-ChildItem -Path env: | Where-Object { $_.Name -like 'GITHUB_ACTION_INPUT_*' } | ForEach-Object {
        $name = $_.Name -replace '^GITHUB_ACTION_INPUT_'
        $value = $_.Value
        Write-Host "[$name] = [$value]"
        "$name=$value" | Out-File -FilePath $env:GITHUB_ENV -Append
    }
}

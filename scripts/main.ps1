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
    $envvar = $env:GITHUB_ACTION_INPUT_env
    $data = ConvertFrom-StringData -StringData $envvar -Delimiter ':'
    $data.GetEnumerator() | ForEach-Object {
        Write-Output "::add-mask::$($_.Value)"
        Write-Host "[$($_.Name)] = [$($_.Value)]"
        "$($_.Name)=$($_.Value)" | Out-File -FilePath $env:GITHUB_ENV -Append
    }
}

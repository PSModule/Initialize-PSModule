#REQUIRES -Modules Utilities

[CmdletBinding()]
param()

Install-PSResource -Name 'powershell-yaml', 'Pester', 'PSScriptAnalyzer', 'powershell-yaml', 'platyPS' -TrustRepository -Verbose
Stop-LogGroup

Start-LogGroup 'Loading helper scripts'
Get-ChildItem -Path (Join-Path -Path $env:GITHUB_ACTION_PATH -ChildPath 'scripts' 'helpers') -Filter '*.ps1' -Recurse |
    ForEach-Object { Write-Verbose "[$($_.FullName)]"; . $_.FullName }
Stop-LogGroup

Start-LogGroup 'Loading inputs'
$env:GITHUB_REPOSITORY_NAME = $env:GITHUB_REPOSITORY -replace '.+/'
Set-GitHubEnv -Name 'GITHUB_REPOSITORY_NAME' -Value $env:GITHUB_REPOSITORY_NAME
Stop-LogGroup

Start-LogGroup 'PSVersionTable'
$PSVersionTable | Format-Table -AutoSize
Stop-LogGroup

Start-LogGroup 'Installed Modules - List'
$modules = Get-PSResource | Sort-Object -Property Name
Write-Verbose ($modules | Select-Object Name, Version, CompanyName, Author | Out-String)
Stop-LogGroup

$modules.Name | Select-Object -Unique | ForEach-Object {
    $name = $_
    Start-LogGroup "Installed Modules - Details - [$name]"
    Write-Verbose ($modules | Where-Object Name -EQ $name | Select-Object * | Out-String)
    Stop-LogGroup
}

Start-LogGroup 'Environment Variables'
Write-Verbose (Get-ChildItem -Path Env: | Select-Object -Property Name, Value | Sort-Object -Property Name | Out-String)
Stop-LogGroup

Start-LogGroup 'Files and Folders'
Write-Verbose (Get-ChildItem -Path $env:GITHUB_WORKSPACE -Recurse | Select-Object -ExpandProperty FullName | Sort-Object | Out-String)
Stop-LogGroup

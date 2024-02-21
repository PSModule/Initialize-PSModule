Write-Output '::group::Initializing...'
Write-Output '-------------------------------------------'

Install-PSResource -Name Utilities, Pester, PSScriptAnalyzer, platyPS, PowerShellGet, PackageManagement -Version * -TrustRepository

Write-Output '::group::[Debug info] - PSVersionTable...'
$PSVersionTable | Format-Table -AutoSize
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - Installed Modules - List'
$modules = Get-PSResource | Sort-Object -Property Name
$modules | Select-Object Name, Version, CompanyName, Author | Format-Table -AutoSize -Wrap
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - Installed Modules - Details'
$modules.Name | Select-Object -Unique | ForEach-Object {
    $name = $_
    Write-Output "::group::[Debug info] - Installed Modules - Details - [$name]"
    $modules | Where-Object Name -EQ $name | Select-Object *
    Write-Output '::endgroup::'
}
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - Environment Variables...'
Get-ChildItem -Path Env: | Select-Object -Property Name, Value | Sort-Object -Property Name | Format-Table -AutoSize -Wrap
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - Files and Folders...'
Get-ChildItem -Path $env:GITHUB_WORKSPACE -Recurse | Select-Object -ExpandProperty FullName | Sort-Object
Write-Output '::endgroup::'

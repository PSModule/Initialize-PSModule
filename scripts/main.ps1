param(
    [string] $Version,
    [switch] $Verbose,
    [switch] $WhatIf
)

Write-Output '::group::Initializing...'
Write-Output '-------------------------------------------'
Write-Output 'Action inputs:'
$params = @{
    RequiredVersion = $Version
    Verbose         = $Verbose
    WhatIf          = $WhatIf
}
$params.GetEnumerator() | Sort-Object -Property Name
Write-Output '::endgroup::'

Write-Output '::group::[Initialize-PSModule] - Installing PSModule.FX...'
Install-Module -Name PSModule.FX -Force @params
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - PSVersionTable...'
$PSVersionTable | Format-Table -AutoSize
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - Installed Modules - List'
$modules = Get-Module -ListAvailable | Sort-Object -Property Name
$modules | Select-Object Name, Version, CompanyName, Author | Format-Table -AutoSize
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - Installed Modules - Details'
$modules.Name | Select-Object -Unique | ForEach-Object {
    $name = $_
    Write-Output "::group::[Debug info] - Installed Modules - Details - [$name]"
    $modules | Where-Object Name -eq $name | Select-Object *
    Write-Output '::endgroup::'
}
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - Environment Variables...'
Get-ChildItem -Path Env: | Select-Object -Property Name, Value | Sort-Object -Property Name | Format-Table -AutoSize
Write-Output '::endgroup::'

Write-Output '::group::[Debug info] - Files and Folders...'
Get-ChildItem -Path $env:GITHUB_WORKSPACE -Recurse | Select-Object -ExpandProperty FullName | Sort-Object
Write-Output '::endgroup::'

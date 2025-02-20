#Requires -Modules GitHub

[CmdletBinding()]
param()

$requiredModules = @{
    Hashtable         = @{}
    Utilities         = @{}
    Retry             = @{}
    'powershell-yaml' = @{}
    PSSemVer          = @{}
    Pester            = @{}
    PSScriptAnalyzer  = @{}
    PlatyPS           = @{}
    MarkdownPS        = @{}
    # 'Microsoft.PowerShell.PlatyPS' = @{
    #     Prerelease = $true
    # }
}

$requiredModules.GetEnumerator() | Sort-Object | ForEach-Object {
    $name = $_.Key
    $settings = $_.Value
    LogGroup "Installing prerequisite: [$name]" {
        $Count = 5
        $Delay = 10
        for ($i = 1; $i -le $Count; $i++) {
            try {
                Install-PSResource -Name $name -TrustRepository -Repository PSGallery @settings
                break
            } catch {
                if ($i -eq $Count) {
                    throw $_
                }
                Start-Sleep -Seconds $Delay
            }
        }
        Write-Output "Installed module: [$name]"
        Write-Output (Get-PSResource -Name $name | Select-Object * | Out-String)

        Write-Output 'Module commands:'
        Write-Output (Get-Command -Module $name | Out-String)
    }
}

$requiredModules.Keys | Get-InstalledPSResource -Verbose:$false | Sort-Object -Property Name |
    Format-Table -Property Name, Version, Prerelease, Repository -AutoSize -Wrap

$PowershellModulesArray = @(
       [pscustomobject]@{ModuleName='Az.Automation';ModuleRequiredVersion='1.3.7'}
       [pscustomobject]@{ModuleName='AZ.Compute'; ModuleRequiredVersion='4.2.1'}
       [pscustomobject]@{ModuleName='AZ.Storage'; ModuleRequiredVersion='2.3.0'}
       [pscustomobject]@{ModuleName='AZ.KeyVault'; ModuleRequiredVersion='2.0.0'}
       [pscustomobject]@{ModuleName='AZ.Network'; ModuleRequiredVersion='3.2.0'}
       [pscustomobject]@{ModuleName='AZ.Security'; ModuleRequiredVersion='0.7.4'}
)
Function Install-PowershellModule(
[String]$Modulename,
[String]$ModuleRequiredVersion    
) {
    $ListModules = Get-installedmodule -Name $Modulename -RequiredVersion $ModuleRequiredVersion -ErrorAction SilentlyContinue
    If ([string]::IsNullOrEmpty($ListModules)) {
        Write-Output "Powershell module $Modulename with version $ModuleRequiredVersion not yet installed."
        Install-Module $Modulename -RequiredVersion $ModuleRequiredVersion -Force -Scope CurrentUser
        Write-Output "Powershell module $Modulename with version $ModuleRequiredVersion now installed." 
    } 
    else {
        Write-Output "Powershell module $Modulename with version $ModuleRequiredVersion already installed."
    }
}
foreach ($PowershellModule in $PowershellModulesArray) {
    Install-PowershellModule -Modulename $PowershellModule.ModuleName -ModuleRequiredVersion $PowershellModule.ModuleRequiredVersion
}

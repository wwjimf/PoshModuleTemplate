param ($Task = 'Default')

# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

@('Psake', 'PSDeploy', 'BuildHelpers', 'PsScriptAnalyzer') | ForEach-Object {
    if (!(Get-Module -Name $_ -ListAvailable)) { Install-Module -Name $_ -Scope CurrentUser -Force }
}
if (!(Get-Module -Name Pester -ListAvailable)) { Install-Module -Name Pester -Scope CurrentUser -Force }

Import-Module Psake, BuildHelpers

Set-BuildEnvironment -Force

Invoke-psake -buildFile .\psake.ps1 -taskList $Task -nologo
exit ( [int]( -not $psake.build_success ) )
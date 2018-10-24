$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

Import-Module (Join-Path $moduleRoot "$moduleName.psm1") -force

Describe "Write-Hello" {
    It "Calling the function with a named parameter returns expected result " {
        Write-Hello -Name 'James' | Should Be 'Hello James!'
    }

    It "Calling the function from a pipeline string returns expected result" {
        'James' | Write-Hello | should Be 'Hello James!'
    }

    It "Calling the function from a pipeline customobject returns expected result" {
        $foo = [PSCustomObject]@{
            Name = 'James'
            OtherProperty = 'Bar'
        }
        $foo | Write-Hello | should Be 'Hello James!'
    }    
}
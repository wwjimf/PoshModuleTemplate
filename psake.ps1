properties {   
}

task default -depends Analyze, Test

task Analyze {
    Write-Host "Starting Static analysis for Public and Private scripts" -ForegroundColor Green
    $saResults = @()
    $saResults = Invoke-ScriptAnalyzer -Path $PSScriptRoot\$env:BHProjectName\Public -Severity @('Error', 'Warning') -Recurse -Verbose:$false
    $saResults += Invoke-ScriptAnalyzer -Path $PSScriptRoot\$env:BHProjectName\Private -Severity @('Error', 'Warning') -Recurse -Verbose:$false
    if ($saResults) {
        $saResults | Format-Table  
        Write-Error -Message 'One or more Script Analyzer errors/warnings where found. Build cannot continue!'        
    } else {
        Write-Host "Static analysis for Public and Private scripts completed." -ForegroundColor Green
    }
}

task Test {
    $testResults = Invoke-Pester -Path $PSScriptRoot -PassThru
    if ($testResults.FailedCount -gt 0) {
        $testResults | Format-List
        Write-Error -Message 'One or more Pester tests failed. Build cannot continue!'
    }
}

task Deploy -depends Analyze, Test {
    Invoke-PSDeploy -Path '.\ServerInfo.psdeploy.ps1' -Force -Verbose:$VerbosePreference
}
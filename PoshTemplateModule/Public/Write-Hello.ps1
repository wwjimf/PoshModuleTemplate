function Write-Hello {
    <#
    .SYNOPSIS
    Simple function to write 'hello $name' to the output stream
    
    .DESCRIPTION
    This is a placeholder function to demonstrate the canonical way to write a module exposed Powershell
    Advanced function. 
    
    .EXAMPLE
    Write-Hello -Name 'James'

    'James' | Write-Hello

    [pscustomobject]@{Name = 'James', OtherProperty = 'Foo'} | Write-Hello
    
    .NOTES
    Place any links or general notes about the function or references to blog posts used to write the code.
    For example, this function was written using the following MS doc for guidance:
        https://docs.microsoft.com/en-us/previous-versions/technet-magazine/hh360993(v=msdn.10)
    #>
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true,
        HelpMessage='Whow would you like to say Hello to?')]
        [string[]]$Name
    )
    # Omitting begin and end blocks for brevity.
    process {
        Write-Verbose "Beginning Process Loop"
        foreach ($n in $Name) {
            Write-Verbose "Processing $n"
            Write-Output "Hello $n!"
        }
    }
}
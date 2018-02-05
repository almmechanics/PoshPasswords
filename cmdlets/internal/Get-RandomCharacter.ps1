Set-StrictMode -Version latest
function Get-RandomCharacter
{   
    <#
    .SYNOPSIS
    Randomly choose a character from an input collection
    
    .DESCRIPTION
    Randomly choose a character from an input collection
        
    .PARAMETER InputString
    Characters to be used for testing
    
    .EXAMPLE
    Get-RandomCharacter -InputString 'ABCDEF'
    Randomly choose a character from the string 'ABCDEF'
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [String]
        $InputString
    )
    return $InputString[(Get-Random -Maximum (($InputString.Length) -1 ) )] 
}
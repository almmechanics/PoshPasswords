Set-StrictMode -Version latest
function Invoke-RandomServerName
{
    <#
    .SYNOPSIS
    Create a random computer name
    
    .DESCRIPTION
    Create a random computer name

    .PARAMETER Length
    Maximum length of the string
    
    .EXAMPLE
    Invoke-RandomServerName -Length 15
    Creates a netbios compatible computername e.g. fc5497ca-54b5-4

    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [ValidateRange(5,15)]
        [int]
        $Length
    )

    if (([GUID]::NewGuid()).ToString() -match '^\w{8}-\w{4}-\w{4}-\w{4}')   
    {
        return ( $Matches[0].Substring(0,$Length))
    }   
}
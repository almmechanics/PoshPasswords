Set-StrictMode -Version latest

function Test-StringContainsCharacter
{
    <#
    .SYNOPSIS
    Test whether string contents are in another string
    
    .DESCRIPTION
    Test whether string contents are in another string

    .PARAMETER TestString
    String to examine
    
    .PARAMETER ComparisonString
    String to perform comparison with
    
    .EXAMPLE
    Test-StringContainsCharacter -TestString 'ABCDEF' -ComparisonString 'DE'
    
    .NOTES
    General notes
    #>
    [CmdletBinding()]
    Param
    (
        [String]
        $TestString,
        [Parameter(Mandatory)]
        [String]
        [ValidateNotNullOrEmpty()]
        $ComparisonString
    )

    $characterFound = $false
    for ($i = 0; $i -lt $ComparisonString.Length; $i++)
    {
        if ($TestString.Contains($ComparisonString.SubString($i,1)))
        {
            $characterFound = $true
        }
    }
    return $characterFound
}
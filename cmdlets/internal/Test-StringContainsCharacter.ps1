Set-StrictMode -Version latest

function Test-StringContainsCharacter
{
    [CmdletBinding()]
    Param
    (
        [String]
        $string,
        [Parameter(Mandatory)]
        [String]
        $characterString
    )

    $characterFound = $false
    for ($i = 0; $i -lt $characterString.Length; $i++)
    {
        if ($string.Contains($characterString.SubString($i,1)))
        {
            $characterFound = $true
        }
    }
    return $characterFound
}
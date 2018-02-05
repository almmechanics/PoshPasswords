function Test-StringContainsCharacter([string]$string,[string]$characterString)
{
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
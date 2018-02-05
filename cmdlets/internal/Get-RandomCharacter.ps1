Set-StrictMode -Version latest
function Get-RandomCharacter
{   
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [String]
        $CharactersToChooseFrom
    )
    return $CharactersToChooseFrom[(Get-Random -Maximum (($CharactersToChooseFrom.Length) -1 ) )] 
}
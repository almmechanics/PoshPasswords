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

    $offSet = Get-Random -Minimum 0 `
                -Maximum (($CharactersToChooseFrom.Length) - 1) `
                -SetSeed ((get-date).Ticks % [int32]::MaxValue)

    return $CharactersToChooseFrom.SubString($offSet,1)
}
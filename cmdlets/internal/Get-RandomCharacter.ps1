Set-StrictMode -Version latest

function Get-RandomCharacter([string]$charactersToChooseFrom)
{
    $offSet = Get-Random -Minimum 0 -Maximum (($charactersToChooseFrom.Length) - 1) -SetSeed ((get-date).Ticks % [int32]::MaxValue)
    return $charactersToChooseFrom.SubString($offSet,1)
}
Set-StrictMode -Version latest
function Invoke-SecureSet
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [int]
        [ValidateRange(5,255)]
        $Length,
        [switch] $IncludeInstance,
        [switch] $IncludeHostName
    )
    Write-Host ('Server: {0}' -f (Invoke-RandomServerName -length $Length))
    if ($IncludeInstance.IsPresent)
    {
        Write-Host ('Instance: {0}' -f (Invoke-RandomServerName -length $Length))
    }

    if ($IncludeHostName)
    {
        Write-Host ('Host name: {0}' -f (Invoke-NewPassword -includeLowerCaseLetters -includeUpperCaseLetters -includeNumbers))
    }

    Write-Host ('User: {0}' -f (Invoke-NewPassword ))
    Write-Host ('Password: {0}' -f (Invoke-NewPassword -includeLowerCaseLetters -includeUpperCaseLetters -includeNumbers -includePunctuation))
}
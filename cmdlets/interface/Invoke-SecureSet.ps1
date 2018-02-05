Set-StrictMode -Version latest
function Invoke-SecureSet
{
    param
    (
        [ValidateRange(5,30)]
        [int]$length = 15,
        [switch] $IncludeInstance,
        [switch] $IncludeHostName
    )
    Write-Host ('Server: {0}' -f (Invoke-RandomServerName -length $length))
    if ($IncludeInstance.IsPresent)
    {
        Write-Host ('Instance: {0}' -f (Invoke-RandomServerName -length $length))
    }

    if ($IncludeHostName)
    {
        Write-Host ('Host name: {0}' -f (Invoke-NewPassword -includeLowerCaseLetters -includeUpperCaseLetters -includeNumbers))
    }

    Write-Host ('User: {0}' -f (Invoke-NewPassword ))
    Write-Host ('Password: {0}' -f (Invoke-NewPassword -includeLowerCaseLetters -includeUpperCaseLetters -includeNumbers -includePunctuation))
}
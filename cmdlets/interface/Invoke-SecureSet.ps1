Set-StrictMode -Version latest
function Invoke-SecureSet
{
    <#
    .SYNOPSIS
    Generate a collection of unique values for a new server
    
    .DESCRIPTION
    Long description
    
    .PARAMETER Length
    Length of the require password
    
    .PARAMETER IncludeInstance
    Create Instance names  
    
    .PARAMETER IncludeHostName
    Create host names
    
    .EXAMPLE
    Invoke-SecureSet -Length 10
    Generate a Server, username and password combination with a maximum of 10 characters

    Name                           Value
    ----                           -----
    Server                         fb8e5141-d7ed-4
    User                           qnwBsnjB867
    Password                       wcI*UAinLEo

    .EXAMPLE
    Invoke-SecureSet -Length 25 -IncludeInstance -IncludeHostName
    Generate a Server, username, password, instance and host combination with a maximum of 15 characters
    Name                           Value
    ----                           -----
    Host                           UVkY2P73QcKrA8SHNrpV0weIIT
    Instance                       4da2119a-0c70-4
    Server                         feb59d21-a24c-4
    Username                       pdfMeieZr8AeUMZtmIOl4NJRcs
    Password                       X7N@q29dLWre6qsmnwNZkfPTXO


    #>
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

    $SecureSetData = @{}

    # Has to be NetBios compatible for windows
    $SecureSetData['Server'] = ('{0}' -f (Invoke-RandomServerName -length 15))
    if ($IncludeInstance.IsPresent)
    {
        # Has to be NetBios compatible for windows
        $SecureSetData['Instance'] = ('{0}' -f (Invoke-RandomServerName -Length 15))
    }

    if ($IncludeHostName)
    {
        $SecureSetData['Host'] = ('{0}' -f (Invoke-NewPassword -includeLowerCaseLetters -includeUpperCaseLetters -includeNumbers -Length:$Length ))
    }

    $SecureSetData['Username'] = ('{0}' -f (Invoke-NewPassword -Length:$Length ))
    $SecureSetData['Password'] = ('{0}' -f (Invoke-NewPassword -includeLowerCaseLetters -includeUpperCaseLetters -includeNumbers -IncludeSpecial -Length:$Length))

    return $SecureSetData
}
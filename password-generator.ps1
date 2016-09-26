Set-StrictMode -Version latest

function Invoke-RandomServerName
{
    param
    (
      [ValidateRange(5,30)]
      [int]$length = 15
    )

    if (([GUID]::NewGuid()).ToString() -match '^\w{8}-\w{4}-\w{4}-\w{4}')   
    {
        $newServer = $Matches[0].Substring(0,$length)
        [System.Windows.Clipboard]::SetText(("{0}" -f $newServer))
        return $newServer
    }   
}

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

function Get-RandomCharacter([string]$charactersToChooseFrom)
{
    $offSet = Get-Random -Minimum 0 -Maximum (($charactersToChooseFrom.Length) - 1)
    return $charactersToChooseFrom.SubString($offSet,1)
}

function Invoke-NewPassword
{
   Param
   (
       [ValidateRange(5,30)]
       [int]$length = 15,
       [switch]$includeLowerCaseLetters,
       [switch]$includeUpperCaseLetters,
       [switch]$includeNumbers,
       [switch]$includePunctuation,
       [switch]$verbose
    )
    
    $useDefaults = $false
    if (!($includeLowerCaseLetters.IsPresent -or 
        $includeUpperCaseLetters.IsPresent -or
        $includeNumbers.IsPresent -or 
        $includePunctuation.IsPresent))
    {
        if ($verbose.IsPresent)
        {
            Write-Warning ('No options set ... creating defaults')
        }
        $useDefaults = $true
    }

    [bool]$passwordIsValid = $false
    [string]$lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz"
    [string]$upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    [string]$numbers = "0123456789"
    [string]$punctuation = "!@#$%^&*?-=_+()"
    [string]$passwordOptions = ""
    [int]$maximumIterations = 15
    [string]$password = [string]::Empty

    if ($useDefaults)
    {        
        $passwordOptions += $lowerCaseLetters
        $passwordOptions += $upperCaseLetters
        $passwordOptions += $numbers
        if ($verbose.IsPresent)
        {
            Write-Warning ('Length={0}, Lower case enabled, Uppercase enabled, Numbers enabled' -f $length)
        }
    }
    else
    {
        if ($includeLowerCaseLetters)
        {
            $passwordOptions += $lowerCaseLetters
        }
        if ($includeUpperCaseLetters)
        {
            $passwordOptions += $upperCaseLetters
        }
        if ($includeNumbers)
        {
            $passwordOptions += $numbers
        }
        if ($includePunctuation)
        {
            $passwordOptions += $punctuation
        }
    }
    # checking to see if the utility was called without character set switches
    if ($passwordOptions.Length -eq 0)
    {
       throw "You must select at least one set of characters."
    }
    # Checking to see if the length of password requested is shorter than that needed
    # to fit 1 example of each set.  This should not be be necessary as the attribute
    # of the length parameter restricts the value to a minimum of 5.
    if ($verbose) 
    {
       Write-Host $passwordOptions
    }

    $passwordIsValid = $false
    $iterationCount = 0
    while((-not $passwordIsValid) -and ($iterationCount -lt $maximumIterations))
    {
       $passwordIsValid = $true
       $password = [string]::Empty

       $iterationCount++
       for ($i = 1; $i -le $length; $i++)
       {
           $password += Get-RandomCharacter $passwordOptions
       }
       if ($passwordIsValid -and $includeLowerCaseLetters)
       {
           $passwordIsValid = Test-StringContainsCharacter $password $lowerCaseLetters
       }
       if ($passwordIsValid -and $includeUpperCaseLetters)
       {
           $passwordIsValid = Test-StringContainsCharacter $password $upperCaseLetters
       }
       if ($passwordIsValid -and $includeNumbers)
       {
           $passwordIsValid = Test-StringContainsCharacter $password $numbers
       }
       if ($passwordIsValid -and $includePunctuation)
       {
           $passwordIsValid = Test-StringContainsCharacter $password $punctuation
       }
    }   

    if (-not $passwordIsValid)
    {
       $password = [string]::Empty
       if ($includeLowerCaseLetters)
       {
           $password += Get-RandomCharacter $lowerCaseLetters
       }
       if ($includeUpperCaseLetters)
       {
           $password += Get-RandomCharacter $upperCaseLetters
       }
       if ($includeNumbers)
       {
           $password += Get-RandomCharacter $numbers
       }
       if ($includePunctuation)
       {
           $password += Get-RandomCharacter $Punctuation
       }
       for ($i = $password.Length + 1; $i -le $length; $i++)
       {
           $password += Get-RandomCharacter $passwordOptions
       }
    }
    return $password
}


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
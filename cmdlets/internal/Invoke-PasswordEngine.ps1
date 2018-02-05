Set-StrictMode -Version latest
function Invoke-PasswordEngine
{
   [CmdletBinding()]
   Param
   (
        [Parameter(Mandatory)]
        [ValidateRange(5,255)]
        [int]
        $Length,
        [switch]
        $IncludeLowerCaseLetters,
        [switch]
        $IncludeUpperCaseLetters,
        [switch]
        $IncludeNumbers,
        [switch]
        $IncludePunctuation
    )

    $useDefaults = $false
    if (!($includeLowerCaseLetters.IsPresent -or 
        $includeUpperCaseLetters.IsPresent -or
        $includeNumbers.IsPresent -or 
        $includePunctuation.IsPresent))
    {
        Write-Warning ('No options set ... creating defaults')
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
        Write-Verbose ('Length={0}, Lower case enabled, Uppercase enabled, Numbers enabled' -f $Length)
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
    Write-Verbose $passwordOptions
    
    $passwordIsValid = $false
    $iterationCount = 0
    $password = [string]::Empty
    while((! $passwordIsValid) -and (++$iterationCount -lt $maximumIterations))
    {
       $passwordIsValid = $true
 
       while ([string]::IsNullOrEmpty($password) -or ($password.Length -le $Length))
       {
            $password += Get-RandomCharacter $passwordOptions
       
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
    }   

    if (!$passwordIsValid)
    {
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

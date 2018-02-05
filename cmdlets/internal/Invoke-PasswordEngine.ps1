Set-StrictMode -Version latest
function Invoke-PasswordEngine
{
    <#
    .SYNOPSIS
    Engine to create complex paswords
    
    .DESCRIPTION
    Engine to create complex paswords
    
   .SYNOPSIS
    Engine to create complex paswords

    .DESCRIPTION
    Allows the Creation of complex paswords based on various criteria
    
    .PARAMETER Length
    Length of the require password
    
    .PARAMETER IncludeLowerCaseLetters
    Use of Lower case characters in the password
    
    .PARAMETER IncludeUpperCaseLetters
    Use of Upper case characters in the password
    
    .PARAMETER IncludeNumbers
    Use of numeric characters in the password
    
    .PARAMETER IncludeSpecial
    Use of punctuation or special characters in the password    

    .EXAMPLE
    Invoke-PasswordEngine -Length 10 -IncludeNumbers -IncludeSpecial
    Generate a password of 10 characters which uses only numbers and special characters

    .EXAMPLE
    Invoke-PasswordEngine -Length 10 -IncludeNumbers -Verbose
    Generate a password of 10 characters which uses only numbers, but display the characters used
    #>
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
        $IncludeSpecial
    )

    $useDefaults =  (!($IncludeLowerCaseLetters.IsPresent -or `
                        $IncludeUpperCaseLetters.IsPresent -or `
                        $IncludeNumbers.IsPresent))
 
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
        Write-Verbose ('Using defaults with Length={0}, Lower case enabled, Uppercase enabled, Numbers enabled' -f $Length)
        $passwordOptions += $lowerCaseLetters
        $passwordOptions += $upperCaseLetters
        $passwordOptions += $numbers
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
        if ($IncludeSpecial)
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
    Write-Verbose ('Using the following characters for seeding the password: "{0}"' -f $passwordOptions)
    
    $passwordIsValid = $false
    $iterationCount = 0
    $password = [string]::Empty
    while((! $passwordIsValid) -and (++$iterationCount -lt $maximumIterations))
    {
       $passwordIsValid = $true
 
       while ([string]::IsNullOrEmpty($password) -or ($password.Length -le $Length))
       {
            $password += Get-RandomCharacter -InputString $passwordOptions
       
            if ($passwordIsValid -and $includeLowerCaseLetters)
            {
                $passwordIsValid = Test-StringContainsCharacter -TestString $password -ComparisonString $lowerCaseLetters
            }
            if ($passwordIsValid -and $includeUpperCaseLetters)
            {
                $passwordIsValid = Test-StringContainsCharacter -TestString $password -ComparisonString $upperCaseLetters
            }
            if ($passwordIsValid -and $includeNumbers)
            {
                $passwordIsValid = Test-StringContainsCharacter -TestString $password -ComparisonString $numbers
            }
            if ($passwordIsValid -and $IncludeSpecial)
            {
                $passwordIsValid = Test-StringContainsCharacter -TestString $password -ComparisonString $punctuation
            } 
        }
    }   

    if (!$passwordIsValid)
    {
       if ($includeLowerCaseLetters)
       {
           $password += Get-RandomCharacter -InputString $lowerCaseLetters
       }
       if ($includeUpperCaseLetters)
       {
           $password += Get-RandomCharacter -InputString $upperCaseLetters
       }
       if ($includeNumbers)
       {
           $password += Get-RandomCharacter -InputString $numbers
       }
       if ($IncludeSpecial)
       {
           $password += Get-RandomCharacter -InputString $Punctuation
       }
       for ($i = $password.Length + 1; $i -le $length; $i++)
       {
           $password += Get-RandomCharacter -InputString $passwordOptions
       }
    }
    return $password
}

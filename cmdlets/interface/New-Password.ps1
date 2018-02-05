Set-StrictMode -Version latest
function New-Password 
{
    <#
    .SYNOPSIS
    Allows the Creation of complex paswords

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
    New-Password -Length 25 -IncludeLowerCaseLetters -IncludeUpperCaseLetters
    Create a 25 character password using Upper and Lower case characters
 
    .EXAMPLE
    New-Password -Length 10 -IncludeNumbers
    Create a 10 character password only made of numbers

    #>
   [CmdletBinding()]
   Param
   (    
        [Parameter(Mandatory)]
        [int]
        [ValidateRange(5, 255)]
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

    return (Invoke-PasswordEngine -Length:$Length `
             -IncludeLowerCaseLetters:$IncludeLowerCaseLetters `
             -IncludeUpperCaseLetters:$IncludeUpperCaseLetters `
             -IncludeNumbers:$IncludeNumbers `
             -IncludeSpecial:$IncludeSpecial)
}
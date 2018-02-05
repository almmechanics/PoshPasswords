Set-StrictMode -Version latest
function Invoke-NewPassword 
{
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
        $IncludePunctuation
    )

    return (Invoke-PasswordEngine -Length:$Length `
             -IncludeLowerCaseLetters:$IncludeLowerCaseLetters `
             -IncludeUpperCaseLetters:$IncludeUpperCaseLetters `
             -IncludeNumbers:$IncludeNumbers `
             -IncludePunctuation:$IncludePunctuation)
}
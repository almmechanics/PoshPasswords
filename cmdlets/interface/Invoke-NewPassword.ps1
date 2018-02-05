Set-StrictMode -Version latest

function Invoke-NewPasword
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

    return (Invoke-PasswordEngine -Length:$length `
        -includeLowerCaseLetters:$includeLowerCaseLetters `
        -includeUpperCaseLetters:$includeUpperCaseLetters `
        -includeNumbers:$includeNumbers `
        -includePunctuation:$includePunctuation `
        -verbose:$verbose
        )
    }
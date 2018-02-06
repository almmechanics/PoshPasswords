$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests', '' 
. "$here\..\cmdlets\internal\$sut"

Describe 'Invoke-PasswordEngine tests' {
    Context 'Interface Tests' {
        It 'ComparisonString cannot be null' {
            {Test-StringContainsCharacter -TestString 'Valid' -ComparisonString $null} | should throw
        }

        It 'ComparisonString cannot be empty' {
            {Test-StringContainsCharacter -TestString 'Valid' -ComparisonString ([string]::Empty)} | should throw
        }
    }
} 

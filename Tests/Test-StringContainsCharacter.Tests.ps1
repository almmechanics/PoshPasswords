InModuleScope PoshPasswords {
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
}
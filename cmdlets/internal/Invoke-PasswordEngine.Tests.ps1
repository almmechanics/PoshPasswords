InModuleScope PoshPasswords {
    Describe 'Invoke-PasswordEngine tests' {
        Context 'Interface Tests' {
            It 'Length is a mandatory parameter' {
                {Invoke-PasswordEngineSecureSet -Length $null} | should throw
            }

            It 'Length cannot be negative' {
                {Invoke-PasswordEngine -Length -1} | should throw
            }

            It 'Length cannot be zero' {
                {Invoke-PasswordEngine -Length 0} | should throw
            }

            It 'Length can be 5 or more' {
                Mock Invoke-PasswordEngine{} -ModuleName PoshPasswords
                {Invoke-PasswordEngine -Length 5} | should not throw
            }

            It 'Length can be upto 255 characters' {
                {Invoke-PasswordEngine -Length 255} | should not throw
            }

            It 'Length must be less than 256 characters' {
                {Invoke-PasswordEngine -Length 256} | should  throw
            }
        }
    } 
}
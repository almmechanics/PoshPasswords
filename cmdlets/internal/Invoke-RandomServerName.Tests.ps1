InModuleScope PoshPasswords {
    Describe 'Invoke-RandomServerName tests' {
        Context 'Interface Tests' {
            It 'Length is a mandatory parameter' {
                {Invoke-RandomServerName -Length $null} | should throw
            }

            It 'Length cannot be negative' {
                {Invoke-RandomServerName -Length -1} | should throw
            }

            It 'Length cannot be zero' {
                {Invoke-RandomServerName -Length 0} | should throw
            }

            It 'Length can be 5 or more' {
                {Invoke-RandomServerName -Length 5} | should not throw
            }

            It 'Length can be upto 15 characters' {
                {Invoke-RandomServerName -Length 15} | should not throw
            }

            It 'Length must be less than 16 characters' {
                {Invoke-RandomServerName -Length 16} | should  throw
            }
        }

        
    } 
}
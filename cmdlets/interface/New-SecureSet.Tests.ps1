InModuleScope PoshPasswords {
    Describe 'New-SecureSet tests' {
        Context 'Interface Tests' {
            It 'Length is a mandatory parameter' {
                {New-SecureSet -Length $null} | should throw
            }

            It 'Length cannot be negative' {
                {New-SecureSet -Length -1} | should throw
            }

            It 'Length cannot be zero' {
                {New-SecureSet -Length 0} | should throw
            }

            It 'Length can be 5 or more' {
                Mock Invoke-PasswordEngine{} -ModuleName PoshPasswords
                {New-SecureSet -Length 5} | should not throw
            }

            It 'Length can be upto 255 characters' {
                Mock Invoke-PasswordEngine{} -ModuleName PoshPasswords
                {New-SecureSet -Length 255} | should not throw
            }

            It 'Length must be less than 256 characters' {
                Mock Invoke-PasswordEngine{} -ModuleName PoshPasswords
                {New-SecureSet -Length 256} | should  throw
            }
        }

        Context 'Default options' {
            It 'Only generates 1 server name and 2 passwords' {
                Mock Invoke-RandomServerName{} -Verifiable -ModuleName PoshPasswords
                Mock New-Password{} -Verifiable -ModuleName PoshPasswords

                {New-SecureSet -Length 25} | should not throw

                Assert-MockCalled Invoke-RandomServerName -Exactly 1 -ModuleName PoshPasswords
                Assert-MockCalled New-Password -Exactly 2 -ModuleName PoshPasswords
            }
        }

        Context 'Instance configuration' {
            It 'Generates 2 server name and 2 passwords' {
                Mock Invoke-RandomServerName{} -Verifiable -ModuleName PoshPasswords
                Mock New-Password{} -Verifiable -ModuleName PoshPasswords

                {New-SecureSet -Length 25 -IncludeInstance } | should not throw

                Assert-MockCalled Invoke-RandomServerName -Exactly 2 -ModuleName PoshPasswords
                Assert-MockCalled New-Password -Exactly 2 -ModuleName PoshPasswords
            }
        }
        Context 'Host configuration' {
            It 'Only generates 1 server name and 2 passwords' {
                Mock Invoke-RandomServerName{} -Verifiable -ModuleName PoshPasswords
                Mock New-Password{} -Verifiable -ModuleName PoshPasswords

                {New-SecureSet -Length 25 -IncludeHostName} | should not throw

                Assert-MockCalled Invoke-RandomServerName -Exactly 1 -ModuleName PoshPasswords
                Assert-MockCalled New-Password -Exactly 3 -ModuleName PoshPasswords
            }
        }

        Context 'All options' {
            It '1 server name and 2 passwords' {
                Mock Invoke-RandomServerName{} -Verifiable -ModuleName PoshPasswords
                Mock New-Password{} -Verifiable -ModuleName PoshPasswords

                {New-SecureSet -Length 25 -IncludeHostName -IncludeInstance } | should not throw

                Assert-MockCalled Invoke-RandomServerName -Exactly 2 -ModuleName PoshPasswords
                Assert-MockCalled New-Password -Exactly 3 -ModuleName PoshPasswords
            }
        }
    } 
}
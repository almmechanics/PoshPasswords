$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests', '' 

. "$here\..\cmdlets\internal\Invoke-PasswordEngine.ps1"
. "$here\..\cmdlets\interface\$sut"

Describe 'New-Password tests' {
    Context 'Interface Tests' {
        It 'Length is a mandatory parameter' {
            {New-Password -Length $null} | should throw
        }

        It 'Length cannot be negative' {
            {New-Password -Length -1} | should throw
        }

        It 'Length cannot be zero' {
            {New-Password -Length 0} | should throw
        }

        It 'Length can be 5 or more' {
            Mock Invoke-PasswordEngine{} 
            {New-Password -Length 5} | should not throw
        }

        It 'Length can be upto 255 characters' {
            Mock Invoke-PasswordEngine{} 
            {New-Password -Length 255} | should not throw
        }

        It 'Length must be less than 256 characters' {
            Mock Invoke-PasswordEngine{} 
            {New-Password -Length 256} | should  throw
        }
    }
} 
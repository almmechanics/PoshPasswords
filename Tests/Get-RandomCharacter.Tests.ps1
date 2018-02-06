$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests', '' 
. "$here\..\cmdlets\internal\$sut"

Describe 'Get-RandomCharacter tests' {
    Context 'Interface Tests' {
        It 'InputString cannot be null' {
            {Get-RandomCharacter -InputString $null} | should throw
        }

        It 'InputStringcannot be empty' {
            {Get-RandomCharacter -InputString ([string]::empty)} | should throw
        }

        It 'A Valid string will not be rejected' {
            Mock Get-Random {return 0}
            {Get-RandomCharacter -InputString 'ValidString'} | should not throw
        }           
    }
    Context 'Random Characters' {
        It 'A random value of "0" will return the first character' {
            Mock Get-Random {return 0}
            Get-RandomCharacter -InputString 'ValidString' | should be 'V'
        }
    }
} 
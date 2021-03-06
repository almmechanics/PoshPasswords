Set-StrictMode -Version Latest

$cmdletsPath = Join-Path $PSScriptRoot 'cmdlets'

$interfacePath = Join-Path $cmdletsPath 'interface'
. (Join-Path $interfacePath 'New-Password.ps1')
. (Join-Path $interfacePath 'New-SecureSet.ps1')

$internalPath = Join-Path $cmdletsPath 'internal'
. (Join-Path $internalPath 'Get-RandomCharacter.ps1')
. (Join-Path $internalPath 'Invoke-PasswordEngine.ps1')
. (Join-Path $internalPath 'Invoke-RandomServerName.ps1')
. (Join-Path $internalPath 'Test-StringContainsCharacter.ps1')
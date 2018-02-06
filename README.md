# PoshPasswords
Password helper for working with Azure

## Usage

### New-Password
1. Create a 25 character password using Upper and Lower case characters

    New-Password -Length 25 -IncludeLowerCaseLetters -IncludeUpperCaseLetters

1. Create a 10 character password only made of numbers

    New-Password -Length 10 -IncludeNumbers
    
### New-SecureSet    
1. Generate a Server, username and password combination with a maximum of 10 characters

    New-SecureSet -Length 10
  
This generates a set of values as follows:

|Name|Value|
|-|-|
|Server|fb8e5141-d7ed-4|
|User|qnwBsnjB867|
|Password|wcI*UAinLEo|

1. Generate a Server, username, password, instance and host combination with a maximum of 15 characters
 
     New-SecureSet -Length 25 -IncludeInstance -IncludeHostName

This generates a set of values as follows:


|Name|Value|
|-|-|
|Host|UVkY2P73QcKrA8SHNrpV0weIIT|
|Instance|4da2119a-0c70-4|
|Server|feb59d21-a24c-4|
|Username|pdfMeieZr8AeUMZtmIOl4NJRcs|
|Password|X7N@q29dLWre6qsmnwNZkfPTXO|
    
## Build Status
[![AppVeyor status](https://ci.appveyor.com/api/projects/status/8tlrgfy9fbdji20e/branch/master?svg=true)](https://ci.appveyor.com/project/almmechanics/poshpasswords/branch/master) ![VSTS status](https://almmechanics.visualstudio.com/_apis/public/build/definitions/0a813601-24f8-412a-8e8a-15aad4c0d629/15/badge) [![codecov](https://codecov.io/gh/almmechanics/poshpasswords/branch/master/graph/badge.svg)](https://codecov.io/gh/almmechanics/poshpasswords)

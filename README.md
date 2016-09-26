# PoshPasswords
Password helper for working with Azure

## Usage 
    Invoke-SecureSet
Will generate name suitable for Azure naming conventions

    Invoke-SecureSet -IncludeInstance 
Adds an instance name to the set (useful for databases)

    Invoke-SecureSet -includeHostName
Adds a host name to the set (useful for IaaS servers etc.)


## Todo
* Add Pester Tests
* Add usage into the code
* Simplify interface

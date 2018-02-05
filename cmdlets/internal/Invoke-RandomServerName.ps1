Set-StrictMode -Version latest
function Invoke-RandomServerName
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [ValidateRange(5,255)]
        [int]
        $Length
    )

    if (([GUID]::NewGuid()).ToString() -match '^\w{8}-\w{4}-\w{4}-\w{4}')   
    {
        $newServer = $Matches[0].Substring(0,$length)
        [System.Windows.Clipboard]::SetText(("{0}" -f $newServer))
        return $newServer
    }   
}
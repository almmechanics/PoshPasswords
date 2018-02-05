function Invoke-RandomServerName
{
    param
    (
      [ValidateRange(5,30)]
      [int]$length = 15
    )

    if (([GUID]::NewGuid()).ToString() -match '^\w{8}-\w{4}-\w{4}-\w{4}')   
    {
        $newServer = $Matches[0].Substring(0,$length)
        [System.Windows.Clipboard]::SetText(("{0}" -f $newServer))
        return $newServer
    }   
}
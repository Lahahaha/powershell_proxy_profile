& {
    function Get-WindowsProxyUri
    {
        param(
            [string] $ProxyServer,
            [string] $Scheme
        )

        if ([string]::IsNullOrWhiteSpace($ProxyServer))
        {
            return $null
        }

        $defaultProxy = $null
        foreach ($entry in $ProxyServer -split ';')
        {
            $parts = $entry -split '=', 2
            if ($parts.Length -eq 1)
            {
                $defaultProxy = $parts[0].Trim()
                continue
            }

            if ($parts[0].Trim().Equals($Scheme, [System.StringComparison]::OrdinalIgnoreCase))
            {
                $defaultProxy = $parts[1].Trim()
                break
            }
        }

        if ([string]::IsNullOrWhiteSpace($defaultProxy))
        {
            return $null
        }

        if ($defaultProxy -notmatch '^[a-z][a-z0-9+.-]*://')
        {
            $defaultProxy = "http://$defaultProxy"
        }

        return $defaultProxy
    }

    $internetSettings = Get-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -ErrorAction SilentlyContinue
    if ($internetSettings.ProxyEnable -eq 1)
    {
        $httpProxy = Get-WindowsProxyUri -ProxyServer $internetSettings.ProxyServer -Scheme 'http'
        $httpsProxy = Get-WindowsProxyUri -ProxyServer $internetSettings.ProxyServer -Scheme 'https'

        if ($httpProxy)
        {
            $env:http_proxy = $httpProxy
        }
        else
        {
            Remove-Item -LiteralPath Env:http_proxy -ErrorAction SilentlyContinue
        }

        if ($httpsProxy)
        {
            $env:https_proxy = $httpsProxy
        }
        else
        {
            Remove-Item -LiteralPath Env:https_proxy -ErrorAction SilentlyContinue
        }
    }
    else
    {
        Remove-Item -LiteralPath Env:http_proxy -ErrorAction SilentlyContinue
        Remove-Item -LiteralPath Env:https_proxy -ErrorAction SilentlyContinue
    }
}

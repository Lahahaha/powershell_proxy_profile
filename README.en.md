# PowerShell Proxy Auto-Configuration

[中文](./README.md) | **English**

This repository provides a PowerShell Profile script that automatically reads Windows system proxy settings on PowerShell startup and applies them as environment variables (`http_proxy` / `https_proxy`), eliminating the need to manually set the proxy each time.

## Usage

Place the `Microsoft.PowerShell_profile.ps1` file into the appropriate Profile directory:

| PowerShell Version | Profile Directory |
|---|---|
| Windows built-in PowerShell (5.x) | `%USERPROFILE%\Documents\WindowsPowerShell\` |
| PowerShell 7 (pwsh) | `%USERPROFILE%\Documents\PowerShell\` |

> `%USERPROFILE%` refers to the current user's home directory, e.g. `C:\Users\<your-username>`. You can also use `$HOME` or `$env:USERPROFILE` in PowerShell to reference the same path.

Full path examples:

- **PowerShell 5.x**: `%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
- **PowerShell 7**: `%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

## How It Works

Every time PowerShell starts, the script automatically:

1. Reads the Windows system proxy configuration from the registry (`HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings`).
2. If the system proxy is enabled, writes the HTTP / HTTPS proxy address to the environment variables `http_proxy` and `https_proxy` respectively.
3. If the system proxy is disabled, clears those environment variables.

This way, simply toggling the system proxy in Windows Settings will synchronize the proxy state in PowerShell — no extra steps required.

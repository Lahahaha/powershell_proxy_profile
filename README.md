# PowerShell 代理自动配置

**中文** | [English](./README.en.md)

本仓库提供一个 PowerShell Profile 脚本，可在启动 PowerShell 时自动读取 Windows 系统代理设置，并将其应用为环境变量（`http_proxy` / `https_proxy`），无需每次手动设置代理。

## 使用方法

将 `Microsoft.PowerShell_profile.ps1` 文件放置到对应的 Profile 目录下：

| PowerShell 版本 | Profile 目录 |
|---|---|
| Windows 自带 PowerShell（5.x） | `%USERPROFILE%\Documents\WindowsPowerShell\` |
| PowerShell 7（pwsh） | `%USERPROFILE%\Documents\PowerShell\` |

> `%USERPROFILE%` 对应当前登录用户的主目录，例如 `C:\Users\<你的用户名>`。在 PowerShell 中也可以用 `$HOME` 或 `$env:USERPROFILE` 引用同一路径。

完整路径示例：

- **PowerShell 5.x**：`%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
- **PowerShell 7**：`%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

## 工作原理

每次启动 PowerShell 时，脚本会自动：

1. 读取注册表中 Windows 系统代理配置（`HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings`）。
2. 若系统代理已启用，则将 HTTP / HTTPS 代理地址分别写入环境变量 `http_proxy` 和 `https_proxy`。
3. 若系统代理未启用，则自动清除上述环境变量。

这样，只需在 Windows 设置中开关系统代理，PowerShell 中的代理状态即可同步生效，无需任何额外操作。

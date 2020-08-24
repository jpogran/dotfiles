Copy-Item -Force -Path (Join-Path $PSScriptRoot "git/*") -Destination ${HOME}
Copy-Item -Force -Path (Join-Path $PSScriptRoot "ruby/*") -Destination ${HOME}
Copy-Item -Force -Path (Join-Path $PSScriptRoot "vim/*") -Destination ${HOME}
Copy-Item -Force -Path (Join-Path $PSScriptRoot "zsh/*") -Destination ${HOME}

switch ($PSVersionTable.PSVersion.Major) {
  7 {
    New-Item -itemType Directory -Force -Path (Join-Path ${HOME} "/Documents/PowerShell") | Out-Null
    Copy-Item -Force -Path (Join-Path $PSScriptRoot "pwsh/pwsh.ps1") -Destination (Join-Path ${HOME} "/Documents/PowerShell/Microsoft.PowerShell_profile.ps1")
  }
  5 {
    New-Item -itemType Directory -Force -Path (Join-Path ${HOME} "/Documents/WindowsPowerShell") | Out-Null
    Copy-Item -Force -Path (Join-Path $PSScriptRoot "pwsh/pwsh.ps1") -Destination (Join-Path ${HOME} "/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1")
  }
}

New-Item -itemType Directory -Force -Path (Join-Path $env:APPDATA "/Code/User") | Out-Null
Copy-Item -Force -Path (Join-Path $PSScriptRoot "vscode/settings.json") -Destination (Join-Path $env:APPDATA "/code/user/settings.json")
Copy-Item -Force -Path (Join-Path $PSScriptRoot "vscode/keybindings.json") -Destination (Join-Path $env:APPDATA "/code/user/keybindings.json")

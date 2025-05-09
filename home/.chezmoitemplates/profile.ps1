#Requires -Version 7.2

using namespace System
using namespace System.Management.Automation

# Set-StrictMode -Version Latest
# stop even on non-critical errors
$global:ErrorActionPreference = "Stop"
#$global:PSDefaultParameterValues["*:ErrorAction"] = $ErrorActionPreference
# throw error when native command returns non-zero exit code
$global:PSNativeCommandUseErrorActionPreference = $true
# show Information log stream
$global:InformationPreference = "Continue"

# Terminal theming based on user preferences
$ThemeName = "{{ .data.theme.name }}"
$AccentColor = "{{ .data.theme.colors.accent }}"
$SurfaceColor = "{{ .data.theme.colors.surface }}"
$TextColor = "{{ .data.theme.colors.text }}"

# Set environment variables
$env:EDITOR = '{{ .data.editor }}'
# set env:LANG, which makes `git diff` and other originally Linux commands print stuff with correct encoding
$env:LANG = "UTF-8"
$env:LESSCHARSET = 'UTF-8'
$OutputEncoding = [Console]::OutputEncoding = [Console]::InputEncoding = [System.Text.UTF8Encoding]::new()

$env:HOMEDRIVE = $env:SystemDrive
if ($env:USERPROFILE) {
  $env:HOMEPATH = $env:USERPROFILE | Split-Path -NoQualifier
}

# The XDG standard says use the variable and tells us how to calculate a fallback
# $DataHome = [Environment]::GetFolderPath("LocalApplicationData") # $ENV:XDG_DATA_HOME    .local/share  # scripts and modules
# $ConfigHome = [Environment]::GetFolderPath("ApplicationData")    # $ENV:XDG_CONFIG_HOME  .config       # profile and settings
$DataHome = if ($ENV:XDG_CONFIG_HOME -and $ENV:XDG_DATA_HOME) {
  $ENV:XDG_DATA_HOME
}
else {
  [IO.Path]::Combine($HOME, ".local", "share")
}

# Import utility modules
if (Test-Path "$env:USERPROFILE\.local\share\powershell\Scripts\utility.ps1") {
  . "$env:USERPROFILE\.local\share\powershell\Scripts\utility.ps1"
}
else {
  . "$($DataHome)/powershell/Scripts/utility.ps1"
}

# Set up PSReadLine configuration
if (Test-Path "$env:USERPROFILE\.local\share\powershell\Scripts\psreadline.ps1") {
  . "$env:USERPROFILE\.local\share\powershell\Scripts\psreadline.ps1"
}
else {
  . "$($DataHome)/powershell/Scripts/psreadline.ps1"
}

Import-Module posh-git

$alias:count = 'Measure-Object'
$alias:ll = 'Get-ChildItem'
$alias:mc = 'Measure-Command'
$alias:time = 'Measure-Command'
$alias:bat = 'Get-Content'

$alias:w = 'Where-Object'
$alias:f = 'ForEach-Object'
$alias:s = 'Select-Object'
$alias:m = 'Measure-Object'
$alias:n = 'New-Object'
$alias:new = 'New-Object'
$alias:os = 'Out-String'
$alias:string = 'Out-String'

$PSDefaultParameterValues = @{
  'ConvertTo-Csv:NoTypeInformation'   = $true
  'Export-Csv:NoTypeInformation'      = $true
  'Install-Module:AllowClobber'       = $true
  'Install-Module:Force'              = $true
  'Install-Module:SkipPublisherCheck' = $true
  'Install-Module:Scope'              = 'CurrentUser'
  'Install-Package:Repository'        = 'PSGallery'
  'Out-Default:OutVariable'           = 'LastResult'
  'Out-File:Encoding'                 = 'utf8'
}

# Apply theme settings to PSReadLine if available
if (Get-Module -ListAvailable -Name PSReadLine) {
  Set-PSReadLineOption -Colors @{
    Command          = $AccentColor
    Parameter        = $TextColor
    InlinePrediction = 'DarkGray'
    Default          = $TextColor
  }
}

# Operating system specific settings
{ { if eq .chezmoi.os "windows" - } }
# Windows specific settings
$env:TERMINAL = '{{ .data.windows.terminal }}'
{ { else if eq .chezmoi.os "darwin" - } }
# macOS specific settings
$env:TERMINAL = '{{ .data.macos.terminal }}'
{ { else if eq .chezmoi.os "linux" - } }
# Linux specific settings
$env:TERMINAL = '{{ .data.linux.terminal }}'
{ { end - } }

# Tool version settings
$env:NODE_VERSION = '{{ .data.versions.node }}'
$env:PYTHON_VERSION = '{{ .data.versions.python }}'
$env:GO_VERSION = '{{ .data.versions.go }}'
$env:RUST_VERSION = '{{ .data.versions.rust }}'

# Username settings
$env:GIT_USERNAME = '{{ .data.username }}'
$env:GIT_EMAIL = '{{ .data.email }}'

# if ($null -ne $env:TERM_PROGRAM -and $env:TERM_PROGRAM -eq "VSCODE") {
# 		Write-host "VSCODE!" -f green;
# 		. (Join-Path $env:util "Powershell\vsprompt.ps1")
# 		return;
# }

$PSStyle.FileInfo.Directory = "`e[96;1m"

$env:PATH = "/opt/homebrew/opt/curl/bin:$($env:PATH)"
$env:PATH = "$HOME/.local/share/mise/shims:$($env:PATH)"

# Configure Starship if available
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

# Custom prompt if Starship is not available
function prompt {
  $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = [Security.Principal.WindowsPrincipal] $identity
  $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

  $prefix = "PS "
  if ($principal.IsInRole($adminRole)) {
    $prefix = "[ADMIN] PS "
  }

  $location = Get-Location

  Write-Host "$prefix" -NoNewline -ForegroundColor $AccentColor
  Write-Host "$($location)" -NoNewline -ForegroundColor $TextColor

  if (Get-Command git -ErrorAction SilentlyContinue) {
    try {
      $gitStatus = git status --porcelain 2>$null
      $gitBranch = git symbolic-ref --short HEAD 2>$null
      if ($gitBranch) {
        if ($gitStatus) {
          Write-Host " [$gitBranch *]" -NoNewline -ForegroundColor Red
        }
        else {
          Write-Host " [$gitBranch]" -NoNewline -ForegroundColor Green
        }
      }
    }
    catch {}
  }

  return " > "
}

$(/opt/homebrew/bin/brew shellenv) | Invoke-Expression
Invoke-Expression (& { (gh completion -s powershell | Out-String) })

Invoke-Expression (starship init powershell)

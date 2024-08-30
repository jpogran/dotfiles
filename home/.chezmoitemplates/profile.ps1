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

# set env:LANG, which makes `git diff` and other originally Linux commands print stuff with correct encoding
$env:LANG = "C.UTF-8"
$env:EDITOR = "code -w"
$env:PATH = "/opt/homebrew/opt/curl/bin:" + $env:PATH

$OutputEncoding = [Console]::OutputEncoding = [Console]::InputEncoding = [System.Text.UTF8Encoding]::new()

$env:HOMEDRIVE = $env:SystemDrive
if ($env:USERPROFILE) {
  $env:HOMEPATH = $env:USERPROFILE | Split-Path -NoQualifier
}

. "$($DataHome)/powershell/Scripts/utility.ps1"
. "$($DataHome)/powershell/Scripts/psreadline.ps1"
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

# if ($null -ne $env:TERM_PROGRAM -and $env:TERM_PROGRAM -eq "VSCODE") {
# 		Write-host "VSCODE!" -f green;
# 		. (Join-Path $env:util "Powershell\vsprompt.ps1")
# 		return;
# }

$PSStyle.FileInfo.Directory = "`e[96;1m"

$(/opt/homebrew/bin/brew shellenv) | Invoke-Expression
Invoke-Expression (& { (gh completion -s powershell | Out-String) })

# . "$(brew --prefix asdf)/libexec/asdf.ps1"

# Set-NodeVersion -Version 18 -InformationAction SilentlyContinue

$env:PATH = "$HOME/.local/share/mise/shims:$($env:PATH)"

Invoke-Expression (starship init powershell)

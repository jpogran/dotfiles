Set-Alias -Name count -Value Measure-Object
Set-Alias -Name ll    -Value Get-ChildItem
Set-Alias -Name mc    -Value Measure-Command
Set-Alias -Name time  -Value Measure-Command

$PSDefaultParameterValues['ConvertTo-Csv:NoTypeInformation'] = $true
$PSDefaultParameterValues['Export-Csv:NoTypeInformation'] = $true
$PSDefaultParameterValues['Install-Module:AllowClobber'] = $true
$PSDefaultParameterValues['Install-Module:Force'] = $true
$PSDefaultParameterValues['Install-Module:SkipPublisherCheck'] = $true
$PSDefaultParameterValues['Install-Module:Scope'] = 'CurrentUser'
$PSDefaultParameterValues["Receive-Job:Keep"] = $True
$PSDefaultParameterValues["Update-Help:Module"] = "*"
$PSDefaultParameterValues["Update-Help:ErrorAction"] = "SilentlyContinue"
$PSDefaultParameterValues["Test-Connection:Quiet"] = $True
$PSDefaultParameterValues["Test-Connection:Count"] = "1"
$PSDefaultParameterValues['Out-Default:OutVariable'] = 'LastResult'
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$ExecutionContext.SessionState.InvokeCommand.LocationChangedAction += {
  [Environment]::CurrentDirectory = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
}

Update-TypeData `
  -TypeName 'Microsoft.Management.Infrastructure.CimInstance#ROOT/StandardCimv2/MSFT_NetTCPConnection' `
  -MemberType ScriptProperty `
  -MemberName Process `
  -Value { Get-Process -Id $this.OwningProcess } `
  -Force

if (($Host.Name -eq "ConsoleHost") -or ($Host.Name -eq "Visual Studio Code Host")) {
  $Host.PrivateData.ProgressForegroundColor = 'Black'
  $Host.PrivateData.ProgressBackgroundColor = 'Yellow'
}

function U {
  param([int] $Code)

  if ((0 -le $Code) -and ($Code -le 0xFFFF)) {
    return [char] $Code
  }

  if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF)) {
    return [char]::ConvertFromUtf32($Code)
  }

  throw "Invalid character code $Code"
}

function .. { Set-Location -Path .. }
function la { Get-ChildItem -Force }
function be { bundle exec $args }
function bi { bundle install $args }

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle Visual
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

if ($env:WT_SESSION) {
  Set-PSReadLineKeyHandler -Chord Ctrl+h -Function BackwardDeleteWord
}

Invoke-Expression (&starship init powershell)
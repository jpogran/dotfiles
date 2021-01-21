$env:StarShell = 'pwsh-' + $PSVersionTable.PSVersion.ToString()

Set-Alias -Name count -Value Measure-Object
Set-Alias -Name ll    -Value Get-ChildItem
Set-Alias -Name mc    -Value Measure-Command
Set-Alias -Name time  -Value Measure-Command

function .. { Set-Location -Path .. }
function la { Get-ChildItem -Force }
function be { bundle exec $args }
function bi { bundle install $args }

$PSDefaultParameterValues['ConvertTo-Csv:NoTypeInformation'] = $true
$PSDefaultParameterValues['Export-Csv:NoTypeInformation'] = $true
$PSDefaultParameterValues['Install-Module:AllowClobber'] = $true
$PSDefaultParameterValues['Install-Module:Force'] = $true
$PSDefaultParameterValues['Install-Module:SkipPublisherCheck'] = $true
$PSDefaultParameterValues['Install-Module:Scope'] = 'CurrentUser'
$PSDefaultParameterValues['Out-Default:OutVariable'] = 'LastResult'
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$ExecutionContext.SessionState.InvokeCommand.LocationChangedAction += {
  [Environment]::CurrentDirectory = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
}

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle Visual
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
if ($env:WT_SESSION) {
  Set-PSReadLineKeyHandler -Chord Ctrl+h -Function BackwardDeleteWord
}

Invoke-Expression (&starship init powershell)

if ($env:STARSHIP_SHELL -eq 'powershell') {
  Set-PSReadLineOption -prompttext "`e[1;32m❯ ", '❯ '
}
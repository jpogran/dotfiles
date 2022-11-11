if ($host.Name -eq 'ConsoleHost') {
  Import-Module PSReadLine
}
Import-Module posh-git

$env:EDITOR    = "code -w"
# $env:StarShell = 'pwsh-' + $PSVersionTable.PSVersion.ToString()

Set-Alias -Name count -Value Measure-Object
Set-Alias -Name ll    -Value Get-ChildItem
Set-Alias -Name mc    -Value Measure-Command
Set-Alias -Name time  -Value Measure-Command

function .. { Set-Location -Path .. }
function la { Get-ChildItem -Force }

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
  $Local:word = $wordToComplete.Replace('"', '""')
  $Local:ast = $commandAst.ToString().Replace('"', '""')
  winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

$PSDefaultParameterValues['ConvertTo-Csv:NoTypeInformation']   = $true
$PSDefaultParameterValues['Export-Csv:NoTypeInformation']      = $true
$PSDefaultParameterValues['Install-Module:AllowClobber']       = $true
$PSDefaultParameterValues['Install-Module:Force']              = $true
$PSDefaultParameterValues['Install-Module:SkipPublisherCheck'] = $true
$PSDefaultParameterValues['Install-Module:Scope']              = 'CurrentUser'
$PSDefaultParameterValues['Install-Package:Repository']        = 'PSGallery'
$PSDefaultParameterValues['Out-Default:OutVariable']           = 'LastResult'
$PSDefaultParameterValues['Out-File:Encoding']                 = 'utf8'

$ExecutionContext.SessionState.InvokeCommand.LocationChangedAction += {
  [Environment]::CurrentDirectory = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
}

Set-PSReadLineOption     -PredictionSource HistoryAndPlugin
Set-PSReadLineOption     -PredictionViewStyle ListView
# Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption     -BellStyle Visual
# Set-PSReadLineOption     -HistorySearchCursorMovesToEnd
if ($env:WT_SESSION) {
  Set-PSReadLineKeyHandler -Chord Ctrl+h -Function BackwardDeleteWord
}

# function Invoke-Starship-TransientFunction {
#   &starship module character
# }

# Invoke-Expression (&starship init powershell)
# if ($env:STARSHIP_SHELL -eq 'powershell') {
#   Set-PSReadLineOption -prompttext "`e[1;32m❯ ", '❯ '
# }

# Enable-TransientPrompt

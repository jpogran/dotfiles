if ($host.Name -eq 'ConsoleHost') {
  Import-Module PSReadLine
}
Import-Module Terminal-Icons
Import-Module posh-git

$env:EDITOR    = "code -w"
$env:Path      = "${home}\bin;" + $env:Path
$env:StarShell = 'pwsh-' + $PSVersionTable.PSVersion.ToString()

Set-Alias -Name count -Value Measure-Object
Set-Alias -Name ll    -Value Get-ChildItem
Set-Alias -Name mc    -Value Measure-Command
Set-Alias -Name time  -Value Measure-Command

function .. { Set-Location -Path .. }
function la { Get-ChildItem -Force }
function be { bundle exec $args }
function bi { bundle install $args }

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

Set-PSReadLineOption     -PredictionSource History
Set-PSReadLineOption     -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption     -BellStyle Visual
Set-PSReadLineOption     -HistorySearchCursorMovesToEnd
if ($env:WT_SESSION) {
  Set-PSReadLineKeyHandler -Chord Ctrl+h -Function BackwardDeleteWord
}

# Invoke-Expression (&starship init powershell)
# oh-my-posh --init --shell pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\jandedobbeleer.omp.json | Invoke-Expression
# oh-my-posh --init --shell pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\powerlevel10k_rainbow.omp.json | Invoke-Expression
# oh-my-posh --init --shell pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\agnosterplus.omp.json | Invoke-Expression
# oh-my-posh --init --shell pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\craver.omp.json | Invoke-Expression
oh-my-posh --init --shell pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\hunk.omp.json | Invoke-Expression

if ($env:STARSHIP_SHELL -eq 'powershell') {
  Set-PSReadLineOption -prompttext "`e[1;32m❯ ", '❯ '
}

# &"${home}/bin/gvm" --format=powershell 1.17.2 | Invoke-Expression

function gvm{
  param($version)
  # https://github.com/andrewkroh/gvm
  &"${home}/bin/gvm" --format=powershell $version | Invoke-Expression
}

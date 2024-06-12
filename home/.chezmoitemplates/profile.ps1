#Requires -Version 7.2

Set-StrictMode -Version Latest
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
$env:PATH = "/opt/homebrew/opt/curl/bin:" + $PATH

Import-Module posh-git

Set-Alias -Name count -Value Measure-Object
Set-Alias -Name ll    -Value Get-ChildItem
Set-Alias -Name mc    -Value Measure-Command
Set-Alias -Name time  -Value Measure-Command

function .. { Set-Location -Path .. }
function la { Get-ChildItem -Force }
function rmf {
  rm -Recurse -Force @Args -ErrorAction Ignore
}

$PSDefaultParameterValues['ConvertTo-Csv:NoTypeInformation'] = $true
$PSDefaultParameterValues['Export-Csv:NoTypeInformation'] = $true
$PSDefaultParameterValues['Install-Module:AllowClobber'] = $true
$PSDefaultParameterValues['Install-Module:Force'] = $true
$PSDefaultParameterValues['Install-Module:SkipPublisherCheck'] = $true
$PSDefaultParameterValues['Install-Module:Scope'] = 'CurrentUser'
$PSDefaultParameterValues['Install-Package:Repository'] = 'PSGallery'
$PSDefaultParameterValues['Out-Default:OutVariable'] = 'LastResult'
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$ExecutionContext.SessionState.InvokeCommand.LocationChangedAction += {
  [Environment]::CurrentDirectory = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
}

# See https://github.com/lzybkr/PSReadLine#usage
Set-PSReadlineKeyHandler -Key 'Escape,_' -Function YankLastArg

# Change how powershell does tab completion
# http://stackoverflow.com/questions/39221953/can-i-make-powershell-tab-complete-show-me-all-options-rather-than-picking-a-sp
Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete
# Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Set-PSReadLineKeyHandler -Key Enter -Function ValidateAndAcceptLine
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownARrow -Function HistorySearchBackward

Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -BellStyle Visual
Set-PSReadLineOption -Colors @{ InlinePrediction = '#555555' }

Set-PSReadLineKeyHandler -Chord "Ctrl+p" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion()
  [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}
if ($env:WT_SESSION) {
  Set-PSReadLineKeyHandler -Chord Ctrl+h -Function BackwardDeleteWord
}


# if at the beginning of a line, add Tab (4 spaces), otherwise open autocomplete dropdown
Set-PSReadLineKeyHandler -Key "Tab" -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  $lineStartI = $line.LastIndexOf("`n", [Math]::max(0, $cursor - 1)) + 1
  if ($line.Substring($lineStartI, $cursor - $lineStartI).Trim() -eq "") {
    [Microsoft.Powershell.PSConsoleReadLine]::Insert("    ")
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::MenuComplete($key, $arg)
  }
}

# if at the beginning of a line, remove all indentation
Set-PSReadLineKeyHandler -Key "Shift+Tab" -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  $lineStartI = $line.LastIndexOf("`n", [Math]::max(0, $cursor - 1)) + 1
  if ($line.Substring($lineStartI, $cursor - $lineStartI).Trim() -eq "") {
    [Microsoft.Powershell.PSConsoleReadLine]::Delete($lineStartI, $cursor - $lineStartI)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::TabCompletePrevious($key, $arg)
  }
}


Set-PSReadLineKeyHandler -Key "End" -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -lt $line.Length) {
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine($key, $arg)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion($key, $arg)
  }
}


Set-PSReadLineKeyHandler -Key RightArrow `
  -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
  -LongDescription "Move cursor one character to the right in the current editing line and accept the next word in suggestion when it's at the end of current editing line" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -lt $line.Length) {
    [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
  }
}


# Sometimes you want to get a property of invoke a member on what you've entered so far
# but you need parens to do that.  This binding will help by putting parens around the current selection,
# or if nothing is selected, the whole line.
Set-PSReadLineKeyHandler -Key 'Alt+(' `
  -BriefDescription ParenthesizeSelection `
  -LongDescription "Put parenthesis around the selection or entire line and move the cursor to after the closing parenthesis" `
  -ScriptBlock {
  param($key, $arg)

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  if ($selectionStart -ne -1) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, '(' + $line.SubString($selectionStart, $selectionLength) + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
  }
}

# Cycle through arguments on current line and select the text. This makes it easier to quickly change the argument if re-running a previously run command from the history
# or if using a psreadline predictor. You can also use a digit argument to specify which argument you want to select, i.e. Alt+1, Alt+a selects the first argument
# on the command line.
Set-PSReadLineKeyHandler -Key Alt+a `
  -BriefDescription SelectCommandArguments `
  -LongDescription "Set current selection to next command argument in the command line. Use of digit argument selects argument by position" `
  -ScriptBlock {
  param($key, $arg)

  $ast = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$null, [ref]$null, [ref]$cursor)

  $asts = $ast.FindAll({
      $args[0] -is [System.Management.Automation.Language.ExpressionAst] -and
      $args[0].Parent -is [System.Management.Automation.Language.CommandAst] -and
      $args[0].Extent.StartOffset -ne $args[0].Parent.Extent.StartOffset
    }, $true)

  if ($asts.Count -eq 0) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
    return
  }

  $nextAst = $null

  if ($null -ne $arg) {
    $nextAst = $asts[$arg - 1]
  }
  else {
    foreach ($ast in $asts) {
      if ($ast.Extent.StartOffset -ge $cursor) {
        $nextAst = $ast
        break
      }
    }

    if ($null -eq $nextAst) {
      $nextAst = $asts[0]
    }
  }

  $startOffsetAdjustment = 0
  $endOffsetAdjustment = 0

  if ($nextAst -is [System.Management.Automation.Language.StringConstantExpressionAst] -and
    $nextAst.StringConstantType -ne [System.Management.Automation.Language.StringConstantType]::BareWord) {
    $startOffsetAdjustment = 1
    $endOffsetAdjustment = 2
  }

  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($nextAst.Extent.StartOffset + $startOffsetAdjustment)
  [Microsoft.PowerShell.PSConsoleReadLine]::SetMark($null, $null)
  [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardChar($null, ($nextAst.Extent.EndOffset - $nextAst.Extent.StartOffset) - $endOffsetAdjustment)
}

$(/opt/homebrew/bin/brew shellenv) | Invoke-Expression
Invoke-Expression (& { (gh completion -s powershell | Out-String) })

"$(brew --prefix asdf)/libexec/asdf.ps1"

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/M365Princess.omp.json" | Invoke-Expression

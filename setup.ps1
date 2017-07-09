cls
$VerbosePreference = 'continue'
$cwd = $PSScriptRoot
$files = Get-ChildItem -Path $cwd -Force -Exclude '*.ps1','*.md','scripts'

$files | % {
  $name = $_.Name
  $fullname = $_.FullName
  switch($name){
    'vscode.settings.json'{
      Write-Verbose "$($HOME)/Library/Application Support/Code/User/settings.json"
      $linkDir = "$($HOME)/Library/Application Support/Code/User/settings.json"
      New-Item -Path $linkDir -ItemType SymbolicLink -Value $fullname -Force
    }
    default{
      # Copy-Item -Path $_.FullName -Value "$($HOME)$(/$_.Name)"
      Write-Verbose "$($HOME)/$($name)"
      New-Item -Path "$($HOME)/$($Name)" -ItemType SymbolicLink -Value $fullName -Force
    }
  }
}

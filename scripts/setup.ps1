$VerbosePreference = 'continue'
$cwd = $PSScriptRoot
$parent = Split-Path -Path $PSScriptRoot

$files = Get-ChildItem -Path $parent -Force -Exclude '.git','*.md','scripts'

$files | % {
  $name = $_.Name
  $fullname = $_.FullName
  switch($name){
    '.gitconfig-osx'     {
      if([System.Environment]::OSVersion.Platform -eq 'Unix'){
        $linkDir = "$($HOME)/.gitconfig-shell"
        Write-Verbose $linkDir
        New-Item -Path $linkDir -ItemType SymbolicLink -Value $fullname -Force
      }
    }
    '.gitconfig-windows'{
      if([System.Environment]::OSVersion.Platform -eq 'Windows'){
        $linkDir = "$($HOME)/.gitconfig-shell"
        Write-Verbose $linkDir
        New-Item -Path $linkDir -ItemType SymbolicLink -Value $fullname -Force
      }
    }
    'vscode.settings.json'{
      $linkDir = "$($HOME)/Library/Application Support/Code/User/settings.json"
      Write-Verbose $linkDir
      New-Item -Path $linkDir -ItemType SymbolicLink -Value $fullname -Force
    }
    'profile.ps1'{
      $linkDir = '~/.config/powershell/profile.ps1'
      Write-Verbose $linkDir
      New-Item -Path $linkDir -ItemType SymbolicLink -Value $fullname -Force
    }
    default{
      Write-Verbose "$($HOME)/$($name)"
      New-Item -Path "$($HOME)/$($Name)" -ItemType SymbolicLink -Value $fullName -Force
    }
  }
}

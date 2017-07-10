$oldVerbosePreference = $VerbosePreference
$VerbosePreference = 'continue'

$parent = Split-Path -Path $PSScriptRoot

$files = Get-ChildItem -Path $parent -Force -Exclude '.git','*.md','scripts'
$files | % {
  $name = $_.Name
  $fullname = $_.FullName
  switch($name){
    '.gitconfig-osx'{
      if([System.Environment]::OSVersion.Platform -eq 'Unix'){
        $linkDir = "$($HOME)/.gitconfig-shell"
      }else{
        $linkDir = $null
      }
    }
    '.gitconfig-windows'{
      if([System.Environment]::OSVersion.Platform -eq 'Windows'){
        $linkDir = "$($HOME)/.gitconfig-shell"
      }else{
        $linkDir = $null
      }
    }
    'vscode.settings.json'{
      $linkDir = "$($HOME)/Library/Application Support/Code/User/settings.json"
    }
    'profile.ps1'{
      $linkDir = '~/.config/powershell/profile.ps1'
    }
    default{
      $linkDir =  "$($HOME)/$($name)"
    }
  }
  if($linkDir){
    Write-Verbose "Linking $($fullname) to $($linkDir)"
    New-Item -Path $linkDir -ItemType SymbolicLink -Value $fullname -Force | Out-Null
  }
}

$VerbosePreference = $oldVerbosePreference

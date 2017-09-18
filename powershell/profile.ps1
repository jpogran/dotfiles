$env:SSH_KEY_PATH = "$HOME/.ssh/id_rsa"
$env:BEAKER_keyfile="$HOME/.ssh/id_rsa-acceptance"
$env:BEAKER_destroy="always"
$env:BEAKER_debug=true
$env:PUPPET_INSTALL_TYPE="agent"
$env:INSTALLATION_TYPE="git"
$env:BUNDLE_PATH=".bundle/gems"
$env:BUNDLE_BIN=".bundle/bin"

Set-Alias -Name time  -Value Measure-Command
Set-Alias -Name ss    -Value Select-String
Set-Alias -Name count -Value Measure-Object
Set-Alias -Name ll    -Value Get-ChildItem
Set-Alias -Name git   -Value hub

function .. { Set-Location -Path .. }
function la { Get-ChildItem -Force }

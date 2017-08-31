Set-Alias -Name time  -Value Measure-Command
Set-Alias -Name ss    -Value Select-String
Set-Alias -Name count -Value Measure-Object
Set-Alias -Name ll    -Value Get-ChildItem

function .. { Set-Location -Path .. }
function la { Get-ChildItem -Force }

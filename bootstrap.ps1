# https://github.com/twpayne/chezmoi/releases/download/v1.8.10/chezmoi_1.8.10_windows_amd64.zip

$baseUrl      = "https://github.com/twpayne/chezmoi/releases"
$arch         = "x86_64"
$platform     = "windows_amd64"
$ext          = "zip"
$app          = "chezmoi"
$version      = "1.8.10"
$url          = "${baseUrl}/latest/download/${app}_${version}_${platform}.${ext}"
$temppath     = Join-Path -Path ([IO.Path]::GetTempPath()) -ChildPath "${app}-${arch}-${platform}.${ext}"
$appPath      = Join-Path $home 'bin'

Invoke-WebRequest -Uri $url -OutFile $temppath
New-Item -Path $appPath -Force -ItemType Directory
Expand-Archive -Path $temppath -DestinationPath $appPath -Force

$envpath = "${appPath};" + $env:Path
[System.Environment]::SetEnvironmentVariable(
  'PATH',
  $envpath,
  [System.EnvironmentVariableTarget]::User
)
$env:Path = $envpath
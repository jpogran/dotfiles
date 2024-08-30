
function .. { Set-Location -Path .. }
function la {
  [CmdletBinding()]
  param (
    [Parameter()]
    [string]
    $Path
  )

  $PSBoundParameters.Add('Force', $true);

  Get-ChildItem @PSBoundParameters | Format-Table -AutoSize
}

function rmf {
  rm -Recurse -Force @Args -ErrorAction Ignore
}


$destination = "C:\hudl\config"
$source = "\\fs01.agilesports.local\DevShare\first-time-config"

Write-Output "Downloading configuration files from $source`n"

Copy-Item -Path "$source\*" -Destination $destination -Filter {*.txt} -Force -Recurse

Write-Output "Done...`n"

$files = Get-ChildItem $destination

$files | ForEach-Object {
    Write-Output "Updating $destination\$_ for host: $env:computername`n"
    (gc $destination\$_).replace('YOURMACHINENAME',"$env:computername")|sc "$destination\$_"
}


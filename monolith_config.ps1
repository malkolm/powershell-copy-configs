
$destination = "C:\hudl\config"
$source = "\\fs01.agilesports.local\DevShare\first-time-config"

Write-Output "Downloading configuration files from $source`n"

New-Item -ItemType Directory -Force -Path $destination | Out-Null
Copy-Item -Path "$source\*" -Destination $destination -Filter {*.txt} -Force -Recurse

if ((Get-ChildItem $destination -force | Select-Object -First 1 | Measure-Object).count -eq 0)
{
    Write-Output "Apparently we failed to download any config files...`n"
    Write-Output "Check that you are on the office network or VPN and have access to \\fs01.agilesports.local\`n"
}
else
{
    Write-Output "Done...`n"

    $files = Get-ChildItem $destination
    $files | ForEach-Object {
        Write-Output "Updating $destination\$_ for host: $env:computername`n"
        (gc $destination\$_).replace('YOURMACHINENAME',"$env:computername")|sc "$destination\$_"
    }
}

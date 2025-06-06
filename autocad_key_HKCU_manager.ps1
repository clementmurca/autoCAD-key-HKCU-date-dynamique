$regPath = 'HKCU:\Software\Autodesk\AutoCAD LT\R30\ACADLT-7101:409\FixedProfile\General'

$name = 'CBER_DATE'
$value = (Get-Date - Format "yyyy-DDD-")

if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

New-ItemProperty -Path $regPath -Name $name -Value $value -PropertyType String -Force

Write-Host "Key $name has been created with the value $value in $regPath"
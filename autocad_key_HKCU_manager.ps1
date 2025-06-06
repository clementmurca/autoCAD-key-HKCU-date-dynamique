# AutoCAD registry key management
$regPath = 'HKCU:\Software\Autodesk\AutoCAD LT\R30\ACADLT-7101:409\FixedProfile\General'

$name = 'CBER_DATE'
$currentDate = Get-Date
$year = $currentDate.Year
$dayOfYear = $currentDate.DayOfYear
$value = "$year-{0:d3}-" -f $dayOfYear

# Create registry path if it doesn't exist
if (Get-ItemProperty -Path $regPath -Name $name -ErrorAction SilentlyContinue) {
    Set-ItemProperty -Path $regPath -Name $name -Value $value
    Write-Host "Registry key UPDATED" -ForegroundColor Yellow
} else {
    New-ItemProperty -Path $regPath -Name $name -Value $value -PropertyType String | Out-Null
    Write-Host "Registry key CREATED" -ForegroundColor Green
}

# Create or update the key
New-ItemProperty -Path $regPath -Name $name -Value $value -PropertyType String -Force | Out-Null

Write-Host "Registry key updated successfully:" -ForegroundColor Green
Write-Host "Path: $regPath" -ForegroundColor Cyan
Write-Host "Key: $name" -ForegroundColor Cyan
Write-Host "Value: $value" -ForegroundColor Yellow

# Verification
try {
    $verification = Get-ItemProperty -Path $regPath -Name $name
    Write-Host "Verification: Key exists with value '$($verification.$name)'" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Could not verify registry key creation" -ForegroundColor Red
}
Write-Host "Remove Notepad from context menu (right click)."

$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked"
$name = "{CA6CC9F1-867A-481E-951E-A28C5E4F01EA}"

New-Item -Path $regPath -Force | Out-Null
New-ItemProperty -Path $regPath -Name $name -Value "" -PropertyType String -Force | Out-Null

Write-Host "Registry key added successfully."
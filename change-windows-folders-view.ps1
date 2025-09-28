Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

$FolderOptionsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
Set-ItemProperty -Path $FolderOptionsPath -Name ShowFrequent -Value '0'
Set-ItemProperty -Path $FolderOptionsPath -Name ShowRecent -Value '0'
Set-ItemProperty -Path $FolderOptionsPath -Name ShowRecommendations -Value '0'

$FolderOptionsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $FolderOptionsPath -Name AutoCheckSelect -Value '1'

$FolderOptionsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState"
Set-ItemProperty -Path $FolderOptionsPath -Name FullPath -Value '1'

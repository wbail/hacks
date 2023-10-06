# Windows Terminal Configs

1. Install Windows Terminal from Windows Store
2. Download Powershell
3. Download and install Visual Studio Code
4. Change powershell to default
5. Download nerdfonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip
6. Extract the zip, copy the fonts to ```c:\windows\fonts``` folder
7. Run the ```winget install JanDeDobbeleer.OhMyPosh -s winget``` into powershell
8. The full path will be: ```c:\users\[current user]\appdata\local\programs\oh-my-posh\bin```
9. Inside the folder ```themes``` find the file ```poshmon.omp.json```, make a backup and in the original file replace the content with code from the file [poshmon.omp.json](./poshmon.omp.json)
10. Change the Windows Terminal - Powershell font to Nerd Font
11. Create if not exits the file ```$profile``` into ```c:\users\[current user]```
12. Paste the code from file [profile.ps1](./profile.ps1) into the file ```$profile```
13. Change the above code ```[CURRENT USER]``` with your user
14. On Visual Studio Code change the fonts to ```'CaskaydiaCove Nerd Font'``` replacing the current value
15. On powershell terminal run: ```Install-Module -Name Terminal-Icons -Repository PSGallery```
16. On powershell terminal run: ```Import-Module -Name Terminal-Icons```

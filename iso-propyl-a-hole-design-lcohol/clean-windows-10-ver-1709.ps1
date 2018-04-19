

# Disclaimer
# Use at your own risk! No warranty on anything!


# Usage
# * review the script
# * run within powershell.exe -ExecutionPolicy Unrestricted
# * run with elevated admin shell, and also run as each non-admin user


# Aim
# To have a single dirty script I can simply copy&paste and run when I need.
# To turn off some of the crazy parts of Windows 10.

# Non-aim
# To have elegant code, use modules, separate code into multiple files, use only native PowerShell functionality, etc.

# based on 
# https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-default-apps.ps1
# https://gist.github.com/tkrotoff/830231489af5c5818b15
# https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/optimize-user-interface.ps1
# https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-onedrive.ps1
# change history
# 2018-03-14 - read some of the listed sources and based the first iteration on that
# 2018-03-15 - added registry settings to disable crap autoinstallation
# 2018-03-16 - added some things from https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/optimize-user-interface.ps1
# 2018-03-16 - added most of https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-onedrive.ps1


# Licenses
#
#
# https://github.com/W4RH4WK/Debloat-Windows-10
# "THE BEER-WARE LICENSE" (Revision 42):
#
# As long as you retain this notice you can do whatever you want with this
# stuff. If we meet some day, and you think this stuff is worth it, you can
# buy us a beer in return.
#
# This project is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.
#
#
# https://gist.github.com/tkrotoff/830231489af5c5818b15
# no license specified, the simplicity of the script probably makes it public domain or non-copyrightable
#
#
# custom parts that I added
# public domain or non-copyrightable (people, please, just do whatever you want with it)




Write-Output "Uninstalling default apps"
$apps = @(

    # based on https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-default-apps.ps1

    # default Windows 10 apps
    "Microsoft.3DBuilder"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    #"Microsoft.BingNews"
    "Microsoft.BingSports"
    #"Microsoft.BingWeather"
    #"Microsoft.FreshPaint"
    #"Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    #"Microsoft.MicrosoftSolitaireCollection"
    #"Microsoft.MicrosoftStickyNotes"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    #"Microsoft.Windows.Photos"
    #"Microsoft.WindowsAlarms"
    #"Microsoft.WindowsCalculator"
    #"Microsoft.WindowsCamera"
    #"Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    #"Microsoft.WindowsSoundRecorder"
    #"Microsoft.WindowsStore"
    "Microsoft.XboxApp"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "microsoft.windowscommunicationsapps"
    "Microsoft.MinecraftUWP"
    "Microsoft.MicrosoftPowerBIForWindows"
    #"Microsoft.NetworkSpeedTest"
    
    # Threshold 2 apps
    "Microsoft.CommsPhone"
    "Microsoft.ConnectivityStore"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    #"Microsoft.WindowsFeedbackHub"


    #Redstone apps
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingTravel"
    "Microsoft.BingHealthAndFitness"
    #"Microsoft.WindowsReadingList"

    # non-Microsoft
    "9E2F88E3.Twitter"
    "PandoraMediaInc.29680B314EFC2"
    "Flipboard.Flipboard"
    "ShazamEntertainmentLtd.Shazam"
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"
    "king.com.*"
    "ClearChannelRadioDigital.iHeartRadio"
    "4DF9E0F8.Netflix"
    "6Wunderkinder.Wunderlist"
    "Drawboard.DrawboardPDF"
    "2FE3CB00.PicsArt-PhotoStudio"
    "D52A8D61.FarmVille2CountryEscape"
    "TuneIn.TuneInRadio"
    "GAMELOFTSA.Asphalt8Airborne"
    "TheNewYorkTimes.NYTCrossword"
    "DB6EA5DB.CyberLinkMediaSuiteEssentials"
    "Facebook.Facebook"
    "flaregamesGmbH.RoyalRevolt2"
    "Playtika.CaesarsSlotsFreeCasino"
    "A278AB0D.MarchofEmpires"
    "KeeperSecurityInc.Keeper"
    "ThumbmunkeysLtd.PhototasticCollage"
    "XINGAG.XING"
    "89006A2E.AutodeskSketchBook"
    "D5EA27B7.Duolingo-LearnLanguagesforFree"
    "46928bounde.EclipseManager"
    "ActiproSoftwareLLC.562882FEEB491" # next one is for the Code Writer from Actipro Software LLC
    "DolbyLaboratories.DolbyAccess"
    "SpotifyAB.SpotifyMusic"
    "A278AB0D.DisneyMagicKingdoms"
    "WinZipComputing.WinZipUniversal"


    # apps which cannot be removed using Remove-AppxPackage
    #"Microsoft.BioEnrollment"
    #"Microsoft.MicrosoftEdge"
    #"Microsoft.Windows.Cortana"
    #"Microsoft.WindowsFeedback"
    #"Microsoft.XboxGameCallableUI"
    #"Microsoft.XboxIdentityProvider"
    #"Windows.ContactSupport"





    # based on https://gist.github.com/tkrotoff/830231489af5c5818b15

    # See Remove default Apps from Windows 10 https://thomas.vanhoutte.be/miniblog/delete-windows-10-apps/
    # See Debloat Windows 10 https://github.com/W4RH4WK/Debloat-Windows-10
    # Command line to list all packages: Get-AppxPackage -AllUsers | Select Name, PackageFullName

    # Get-AppxPackage Microsoft.Windows.ParentalControls | Remove-AppxPackage
    # ... and so on

    "Windows.ContactSupport"
    "Microsoft.Xbox*"
    "microsoft.windowscommunicationsapps" # Mail and Calendar
    #"Microsoft.Windows.Photos"
    #"Microsoft.WindowsCamera"
    "Microsoft.SkypeApp"
    "Microsoft.Zune*"
    "Microsoft.WindowsPhone" # Phone Companion
    #"Microsoft.WindowsMaps"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    #"Microsoft.Appconnector"
    #"Microsoft.WindowsFeedback*"
    "Microsoft.Windows.FeatureOnDemand.InsiderHub"
    #"Microsoft.Windows.Cortana"
    "Microsoft.People"
    "Microsoft.Bing*" # Money, Sports, News, Finance and Weather
    #"Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    #"Microsoft.MicrosoftSolitaireCollection"
    #"Microsoft.WindowsSoundRecorder"
    "Microsoft.3DBuilder"
    "Microsoft.Messaging"
    "Microsoft.CommsPhone"
    "Microsoft.Advertising.Xaml"
    # ?? # "Microsoft.Windows.SecondaryTileExperience"
    # ?? # "Microsoft.Windows.ParentalControls"
    # ?? # "Microsoft.Windows.ContentDeliveryManager"
    # ?? # "Microsoft.Windows.CloudExperienceHost"
    # ?? # "Microsoft.Windows.ShellExperienceHost"
    #"Microsoft.BioEnrollment"
    "Microsoft.OneConnect"
    "*Twitter*"
    "king.com.CandyCrushSodaSaga"
    "flaregamesGmbH.RoyalRevolt2"
    "*Netflix"
    "Facebook.Facebook"
    "Microsoft.MinecraftUWP"
    "*MarchofEmpires"


    # my own
    "Microsoft.Office.*"
    "Microsoft.Microsoft3DViewer"

)

foreach ($app in $apps) {
    Write-Output "Trying to remove $app"

    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers

    # some apps are not uninstallable by admin for all accounts and are local to a single account
    Get-AppxPackage -Name $app | Remove-AppxPackage

    Get-AppXProvisionedPackage -Online |
        Where-Object DisplayName -EQ $app |
        Remove-AppxProvisionedPackage -Online
}


# Prevents "Suggested Applications" returning
# better doing it using reg than using powershell
# based on https://blogs.technet.microsoft.com/mniehaus/2015/11/23/seeing-extra-apps-turn-them-off/
reg add HKLM\Software\Policies\Microsoft\Windows\CloudContent /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f

# hopefully disable other parts of autoinstallation crap (run for each user)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SilentInstalledAppsEnabled /t REG_DWORD /d 00000000 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEnabled /t REG_DWORD /d 00000000 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEverEnabled /t REG_DWORD /d 00000000 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v ContentDeliveryAllowed /t REG_DWORD /d 00000000 /f

# hopefully disable other parts of autoinstallation crap
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEnabled /t REG_DWORD /d 00000000 /f
# idk whether these are also applicable to HKLM, not just HKCU
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SilentInstalledAppsEnabled /t REG_DWORD /d 00000000 /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEverEnabled /t REG_DWORD /d 00000000 /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v ContentDeliveryAllowed /t REG_DWORD /d 00000000 /f

# Setting default explorer view to This PC
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" 1

# Remove 3D Objects from This PC
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\3D Objects"




# from https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-onedrive.ps1

#   Description:
# This script will remove and disable OneDrive integration.

# Import-Module -DisableNameChecking $PSScriptRoot\..\lib\force-mkdir.psm1
# Thanks to raydric, this function should be used instead of `mkdir -force`.
#
# While `mkdir -force` works fine when dealing with regular folders, it behaves
# strange when using it at registry level. If the target registry key is
# already present, all values within that key are purged.
function force-mkdir($path) {
    if (!(Test-Path $path)) {
        #Write-Host "-- Creating full path to: " $path -ForegroundColor White -BackgroundColor DarkGreen
        New-Item -ItemType Directory -Force -Path $path
    }
}

taskkill.exe /F /IM "OneDrive.exe"
taskkill.exe /F /IM "explorer.exe"

Write-Output "Remove OneDrive"
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}

Write-Output "Removing OneDrive leftovers"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:systemdrive\OneDriveTemp"
# check if directory is empty before removing:
If ((Get-ChildItem "$env:userprofile\OneDrive" -Recurse | Measure-Object).Count -eq 0) {
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"
}

Write-Output "Disable OneDrive via Group Policies"
force-mkdir "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive"
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1

Write-Output "Remove Onedrive from explorer sidebar"
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR"
mkdir -Force "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-ItemProperty "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
mkdir -Force "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-ItemProperty "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
Remove-PSDrive "HKCR"

# Thank you Matthew Israelsson
Write-Output "Removing run hook for new users"
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"

Write-Output "Removing startmenu entry"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

Write-Output "Removing scheduled task"
Get-ScheduledTask -TaskPath '\' -TaskName 'OneDrive*' -ea SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

Write-Output "Restarting explorer"
Start-Process "explorer.exe"


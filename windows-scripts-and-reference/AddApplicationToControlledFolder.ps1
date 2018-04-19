
# Disclaimer
# Use at your own risk! No warranty on anything!

# Licenses
#
# no license specified, the way it was published probably makes it public domain or non-copyrightable
#

# Sources
# https://gist.github.com/gschizas/94f432c68944dfc53414bb4cc7f7a2bb
# https://www.reddit.com/r/Windows10/comments/78nkey/are_you_using_the_fcu_windows_defenders/
# https://www.reddit.com/r/Windows10/comments/78hktf/windows_10s_controlled_folder_access/

# Usage
# run in powershell.exe -ExecutionPolicy Unrestricted

# Aim
# To select apps that were limited by Windows Controlled Folder Access and put them in exceptions. (As of March 2018, the native Windows UI doesn't offer a nice way to do it.)

# Edits
# 2018-03-23 added one line with echo


$appEvents = Get-WinEvent -LogName "Microsoft-Windows-Windows Defender/Operational" | 
    Where-Object {$_.Id -eq "1123"}
$allBlockedProcesses = (    
    $appEvents |
        ForEach-Object {
            (([xml]$_.ToXml()).Event.EventData.Data |
                Where-Object {
                    $_.Name -eq "Process Name"
                }).'#text'
        } |
    Sort-Object -Unique
)

$currentWhiteList = (Get-MpPreference).ControlledFolderAccessAllowedApplications

if ($allBlockedProcesses -eq $null) {
    Write-Host -ForegroundColor Red "No Processes have been filtered"
    exit 3
}

if ($currentWhiteList -eq $null) {
    $newProcesses = $allBlockedProcesses
}
else {
    $newProcesses = Compare-Object `
        -ReferenceObject $allBlockedProcesses `
        -DifferenceObject $currentWhiteList | 
        Where-Object {
            $_.SideIndicator -eq '<='
        } |
        Select-Object -ExpandProperty InputObject
}

if ($newProcesses -eq $null) {
    Write-Host -ForegroundColor Green "All processes have already been added"
    exit 0
}

$newProcesses |
    Out-GridView -PassThru |
    ForEach-Object {
		echo $_
        Add-MpPreference -ControlledFolderAccessAllowedApplications $_
    }
	

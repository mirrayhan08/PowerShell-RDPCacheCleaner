<#
.SYNOPSIS
    Backs up and removes existing RDP connections by deleting the subkeys from the registry except for the "Default" entry.

.DESCRIPTION
    This script backs up the registry key containing cached RDP connections, lists the subkeys, 
    and then deletes the subkeys under the specified registry path, excluding the "Default" entry.

.NOTES
    File Name  : Remove_RDP_Cache.ps1
    Author     : Mir Rayhan
    Created On : 12-06-2024
    Version    : 1.0
    Contact    : rayhan@rayssl.com

.EXAMPLE
    .\Remove-RDPCache.ps1
#>

# Path to the registry key containing the cached RDP connections
$rdpCachePath = "HKCU:\SOFTWARE\Microsoft\Terminal Server Client"

# Function to back up the registry key
function Backup-RegistryKey {
    param (
        [string]$keyPath,
        [string]$backupPath
    )
    
    try {
        $date = Get-Date -Format "yyyyMMddHHmmss"
        $deviceName = (Get-WmiObject -Class Win32_ComputerSystem).Name
        $backupFileName = "$backupPath\RDP_Backup_${deviceName}_$date.reg"
        
        # Export the registry key to a .reg file
        $regExportCmd = "reg export `"$keyPath`" `"$backupFileName`" /y"
        Write-Output "Executing command: $regExportCmd"
        $process = Start-Process -FilePath "reg.exe" -ArgumentList "export `"$keyPath`" `"$backupFileName`" /y" -NoNewWindow -Wait -PassThru
        if ($process.ExitCode -eq 0) {
            Write-Output "Backup created at: $backupFileName"
        } else {
            Write-Output "Failed to create backup: Process exited with code $($process.ExitCode)"
        }
    }
    catch {
        Write-Output "Failed to create backup: $_"
    }
}

# Create a backup of the registry key
Backup-RegistryKey -keyPath "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Terminal Server Client" -backupPath "C:\Temp"

# Check if the registry key exists
if (Test-Path $rdpCachePath) {
    # Get all the subkeys in the Servers registry key
    $serversPath = "$rdpCachePath\Servers"
    if (Test-Path $serversPath) {
        $rdpEntries = Get-ChildItem -Path $serversPath

        if ($rdpEntries.Count -gt 0) {
            Write-Output "List of RDP connections:"
            foreach ($entry in $rdpEntries) {
                Write-Output $entry.PSChildName
            }

            # Automatically delete the RDP connections without asking for confirmation
            foreach ($entry in $rdpEntries) {
                if ($entry.PSChildName -ne "Default") {
                    # Remove the entry
                    try {
                        Remove-Item -Path "$serversPath\$($entry.PSChildName)" -Recurse
                        Write-Output "Deleted RDP connection: $($entry.PSChildName)"
                    }
                    catch {
                        Write-Output "Failed to delete RDP connection: $($entry.PSChildName) - Error: $_"
                    }
                }
            }
        }
        else {
            Write-Output "No RDP connections found."
        }
    } else {
        Write-Output "The registry path $serversPath does not exist."
    }
}
else {
    Write-Output "The registry key path $rdpCachePath does not exist."
}

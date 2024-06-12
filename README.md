# PowerShell RDP Cache Cleaner

## Introduction

Managing cached Remote Desktop Protocol (RDP) connections on Windows systems can be cumbersome, especially in environments with multiple connections. To simplify this process, the PowerShell RDP Cache Cleaner repository hosts a PowerShell script designed to automate the removal of outdated or unnecessary cached RDP connections from the Windows Registry.

## Features

- **Automated Cleanup:** The PowerShell script automates the process of identifying and removing cached RDP connections, saving time and effort for system administrators.
- **Confirmation Prompt:** Before deleting each RDP connection, the script prompts for confirmation, allowing users to review and verify the deletions.
- **Backup Functionality:** The script includes a backup feature that creates a backup of the registry key containing cached RDP connections before making any changes, providing a safety net in case of accidental deletions.
- **Error Handling:** Error handling mechanisms are in place to handle any potential issues encountered during the cleanup process, ensuring a smooth execution.
- **Customization Options:** Users can customize the script according to their specific requirements, such as specifying the registry path or backup location.

## Usage

1. Clone or download the repository.
2. Ensure that PowerShell execution policy allows running scripts by executing `Set-ExecutionPolicy RemoteSigned`.
3. Run the script `Remove-RDPCache.ps1` with administrator privileges.
4. Review the list of cached RDP connections and confirm deletion as prompted.
5. Verify changes in the Windows Registry to ensure successful cleanup.

## Manual Removal Process

If preferred, users can manually remove cached RDP connections from the Windows Registry. Detailed manual removal instructions are provided below:

1. **Open Registry Editor:** Press `Win + R`, type `regedit`, and press Enter.
2. **Navigate to RDP Cache Key:** Go to `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Terminal Server Client\Servers`.
3. **Identify Entries:** Each subkey under "Servers" represents a cached RDP connection. Identify the connections you want to remove.
4. **Delete Entries:** Right-click on the subkey representing the RDP connection and select "Delete". Confirm the deletion if prompted.
5. **Verify Changes:** Open Registry Editor again to confirm that the desired RDP connections have been removed.

## Contributions and Feedback

Contributions, feedback, and suggestions for improvement are welcomed and encouraged. Feel free to submit pull requests, report issues, or provide feedback through the repository's GitHub page. Together, we can enhance and evolve this tool to better meet the needs of the community.

**GitHub Repository:** [PowerShell-RDPCacheCleaner](https://github.com/mirrayhan08/PowerShell-RDPCacheCleaner)

## More details
Check the details: https://rayssl.com/powershell-rdp-cache-cleaner-streamlining-remote-desktop-connection-management/

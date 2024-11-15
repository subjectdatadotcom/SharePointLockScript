### ReadMe for SharePoint Site Lock Script

#### Overview
This script sets SharePoint Online sites to **read-only mode** and verifies their lock state. It processes a list of site URLs from a CSV file and connects to the SharePoint Online tenant for the operation. 

#### Prerequisites
1. **SharePoint Online Admin Permissions**: The account used to run the script must have SharePoint Online Admin rights.
2. **PowerShell Module**: The `Microsoft.Online.Sharepoint.PowerShell` module must be installed.
3. **CSV File**: A CSV file containing the list of SharePoint site URLs.

#### CSV File Format
The script expects a CSV file named `SharePointSites.csv` in the same directory as the script. The file should have the following format:

```csv
Url
https://M365x84490777.sharepoint.com/sites/Site1
https://M365x84490777.sharepoint.com/sites/Site2
https://M365x84490777.sharepoint.com/sites/Site3
```

#### How to Use
1. **Save the Script**:
   Save the script as `SharePointLockScript.ps1`.

2. **Prepare the CSV File**:
   Create a CSV file named `SharePointSites.csv` in the same directory as the script. Populate it with the site URLs.

3. **Run the Script**:
   Open PowerShell and navigate to the directory where the script is saved. Run the script:

   ```powershell
   .\SharePointLockScript.ps1
   ```

4. **Monitor Output**:
   - The script will set each site to read-only and display its lock state.
   - Green output indicates the site is unlocked.
   - Yellow output indicates the site is locked (read-only).
   - Errors will be displayed in red if a site cannot be processed.

#### Script Behavior
- **Lock State**: Sets the site to `ReadOnly`.
- **Error Handling**: If any site URL cannot be processed, the script continues to the next site, logging the error.

#### Dependencies
- **PowerShell Module**: The script will check and install the `Microsoft.Online.Sharepoint.PowerShell` module if not already installed.

#### Troubleshooting
- **CSV Not Found**: Ensure `SharePointSites.csv` is in the same directory as the script.
- **Permissions**: Ensure the user has sufficient permissions to modify the lock state of SharePoint Online sites.
- **Admin URL**: Verify the `Connect-SPOService` URL is correct for your tenant.

#### Author
**SubjectData**  
This script is designed for managing SharePoint Online sites in a secure and efficient manner.

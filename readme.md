# Azure Storage Container Size Calculator

This script calculates the size of each folder within an Azure Storage container and provides a summary of the folder sizes. The calculated sizes are then exported to a CSV file and displayed in the console for easy reference.

## Prerequisites

Before running the script, ensure that you have the following:

- Azure PowerShell module installed.
- Appropriate permissions to access and manage the Azure Storage container.

## Usage

1. Open a PowerShell console or an integrated terminal in PowerShell.
2. Set the values for the following variables in the script according to your environment:

   - `$resourceGroup`: The name of the resource group containing the Storage account.
   - `$storageAccountName`: The name of the Azure Storage account.
   - `$containerName`: The name of the Storage container.

3. Run the script using the PowerShell `.\scriptname.ps1` command.

## Script Explanation

The script performs the following steps:

1. It retrieves the Azure Storage account and establishes a context using the `Get-AzStorageAccount` cmdlet.
2. The script retrieves a list of all blobs in the specified container using the `Get-AzStorageBlob` cmdlet.
3. A dictionary (`$folderSizes`) is created to store the size of each folder within the container. It is initialized with zero values.
4. For each blob, the script extracts the folder name from the blob's path and updates the corresponding folder's size in the `$folderSizes` dictionary.
5. A list of custom objects (`$folderObjects`) is created, containing the folder names and their respective sizes in megabytes (MB).
6. The total size of all folders is calculated and added as a separate object (`$totalObject`).
7. The `$folderObjects` and `$totalObject` are combined into a single results list (`$results`).
8. The results are exported to a CSV file named `folder_sizes.csv` using the `Export-Csv` cmdlet.
9. The results are also displayed in a tabular format in the console using the `Format-Table` cmdlet.

## Output

Upon successful execution of the script, it will display a table in the console showing the folder names and their sizes in megabytes (MB).

The folder sizes and the total size will be exported to a CSV file named `folder_sizes.csv`. This file can be opened with spreadsheet software like Microsoft Excel for further analysis or reporting.

Note: Ensure that you have the necessary permissions and appropriate module versions to execute the script successfully.

For any further assistance or inquiries, please feel free to reach out.

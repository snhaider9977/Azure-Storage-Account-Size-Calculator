$resourceGroup = "xyz-rg"
$storageAccountName = "xyz-sa"
$containerName = "xyz-cont"


$storageAccount = Get-AzStorageAccount `
  -ResourceGroupName $resourceGroup `
  -Name $storageAccountName
$ctx = $storageAccount.Context 

# get a list of all of the blobs in the container 
$listOfBlobs = Get-AzStorageBlob -Container $containerName -Context $ctx 

# create a dictionary to store the size of each folder and initialize it with 0 values
$folderSizes = @{}
foreach ($blob in $listOfBlobs) {
    $folder = ($blob.Name -split '/')[0]
    if (-not $folderSizes.ContainsKey($folder)) {
        $folderSizes[$folder] = 0
    }
    $folderSizes[$folder] += $blob.Length
}

# create a new object for each folder with its name and size in MB
$folderObjects = foreach ($key in $folderSizes.Keys) {
    [PSCustomObject]@{
        'Folder Name' = $key
        'Size (MB)' = [math]::Round(($folderSizes[$key] / 1MB), 2)
    }
}

# calculate the total size of all folders
$totalSize = [math]::Round(($folderSizes.Values | Measure-Object -Sum).Sum / 1MB, 2)

# create a new object for the total size
$totalObject = [PSCustomObject]@{
    'Folder Name' = 'Total'
    'Size (MB)' = $totalSize
}

# combine the folder objects and the total object
$results = $folderObjects + $totalObject

# output the results to a CSV file
$results | Export-Csv -Path 'folder_sizes.csv' -NoTypeInformation -Encoding UTF8

# display the results in the console
$results | Format-Table

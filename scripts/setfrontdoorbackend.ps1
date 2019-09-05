[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $storageAccountName,
    [Parameter(Mandatory)]
    [string]
    $resourceGroupName,
    [Parameter(Mandatory)]
    [string]
    $backendPoolName,
    [Parameter(Mandatory)]
    [string]
    $frontDoorName,
    [Parameter(Mandatory)]
    [ValidateSet('Enabled','Disabled')]
    [string]
    $state
)

$ErrorActionPreference = 'Stop'

$backendpool = (Get-AzFrontDoor -ResourceGroupName $resourceGroupName -Name $frontDoorName).BackendPools | Where-Object {$_.Name -eq $backendPoolName}

($backendpool.backends | Where-Object { $_.Address -like "$storageAccountName*" }).EnabledState = $state

$backendpool.backends

Set-AzFrontDoor -ResourceGroupName $resourceGroupName -Name $frontDoorName -BackendPool $backendpool
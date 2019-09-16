param(
    [Parameter(Mandatory=$true,
    ValueFromPipeline=$true)][string]$Domain
)

Set-PAServer $Env:LE_ENV -ErrorAction Stop

# Get a new certificate or submit a renewal. Renewals not yet supported due to token expiry.
# To implement renewals, wil lneed to modify token inside plugindata.xml
# PR approved for Posh-ACME, awaiting new version to implement renewal

switch ($Env:letsencryptoperation) {
    "renew" {
        Submit-Renewal -PluginArgs @{
            AZSubscriptionId=$Env:AZURE_SUBSCRIPTION_ID;
            AZAccessToken=$Env:AZURE_TOKEN
        } `
        -NewKey `
        -Verbose
    }
    "newcert" {
        New-PACertificate $Domain `
            -AcceptTOS `
            -Contact 'matt.white@microsoft.com' `
            -DnsPlugin Azure `
            -PluginArgs @{
                AZSubscriptionId=$Env:AZURE_SUBSCRIPTION_ID;
                AZAccessToken=$Env:AZURE_TOKEN
            } `
            -Verbose
                    
        Get-PACertificate -MainDomain $Domain
    }
}

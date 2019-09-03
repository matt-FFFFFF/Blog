$domain = 'mattwhite.blog'

Set-PAServer LE_PROD

# Get a new certificate or submit a renewal. Renewals not yet supported due to token expiry.
# TO implement renewals, wil lneed to modify token inside plugindata.xml
switch ([Boolean](Get-PACertificate -MainDomain $domain)) {
    $true {
        New-PACertificate $domain `
                  -AcceptTOS `
                  -Contact 'matt.white@microsoft.com' `
                  -DnsPlugin Azure `
                  -PluginArgs @{
                    AZSubscriptionId=$((Get-AzContext).Subscription);
                    AZAccessToken=$($Env:AZURE_TOKEN)
                    }
    }
    $false {
        Submit-Renewal -MainDomain $domain
    }
}

$cert = Get-PACertificate -MainDomain $domain
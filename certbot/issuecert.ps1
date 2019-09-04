$domain = 'mattwhite.blog'

Set-PAServer $Env:LE_ENV

# Get a new certificate or submit a renewal. Renewals not yet supported due to token expiry.
# TO implement renewals, wil lneed to modify token inside plugindata.xml
New-PACertificate $domain `
            -AcceptTOS `
            -Contact 'matt.white@microsoft.com' `
            -DnsPlugin Azure `
            -PluginArgs @{
                AZSubscriptionId=$Env:AZURE_SUBSCRIPTION_ID;
                AZAccessToken=$Env:AZURE_TOKEN
            } `
            -Verbose
                    
$cert = Get-PACertificate -MainDomain $domain
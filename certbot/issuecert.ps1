$domain = 'mattwhite.blog'

Set-PAServer $Env:LE_ENV

$token = Get-Content $Env:AGENT_TEMP/token

# Get a new certificate or submit a renewal. Renewals not yet supported due to token expiry.
# TO implement renewals, wil lneed to modify token inside plugindata.xml
New-PACertificate $domain `
            -AcceptTOS `
            -Contact 'matt.white@microsoft.com' `
            -DnsPlugin Azure `
            -PluginArgs @{
                AZSubscriptionId=$Env:AZURE_SUBSCRIPTION_ID;
                AZAccessToken=$token
            }
                    
$cert = Get-PACertificate -MainDomain $domain
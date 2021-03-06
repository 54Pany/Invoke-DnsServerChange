function Invoke-DnsServerChange {
<#
.SYNOPSIS

     -Name           Network Interface Name.
     -Dns            DNS Server IP Addr.
                
.DESCRIPTION

    Author: p4ny (@LESSNET)
    License: BSD 3-Clause
    Required Dependencies: None
    Optional Dependencies: None

.EXAMPLE
    Change DNS Server

    C:\PS> Invoke-DnsServerChange -Name 'Ethernet0' -Dns "119.29.29.29,114.114.114.114"
#>

    param (
        [Parameter(Mandatory = $True)]
        [string]$Name,
        [Parameter(Mandatory = $True)]
        [string[]]$Dns
    )
    $Dns = $Dns.Split(',')
    $InterfaceGuid = Get-WmiObject win32_networkadapter -filter "netconnectionid = '$Name'" | Select -ExpandProperty 'GUID'
    $Guid = Get-WmiObject win32_networkadapterconfiguration -filter "SettingID = '$InterfaceGuid'"
    $Guid.SetDNSServerSearchOrder($Dns) | Out-Null

    echo "DNS: $Dns changed successfully!! "
}

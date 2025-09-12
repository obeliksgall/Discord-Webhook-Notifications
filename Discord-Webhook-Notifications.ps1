# source https://github.com/obeliksgall/Discord-Webhook-Notifications/tree/main
# version 1.1

#how to run example | jak uruchomic
#powershell.exe -ExecutionPolicy Bypass -File ".\Discord-Webhook-Notifications.ps1" -Mode turnon
#powershell.exe -ExecutionPolicy Bypass -File ".\Discord-Webhook-Notifications.ps1" -Mode turnoff

param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("turnon", "turnoff")]
    [string]$Mode
)

$webhookUri = 'https://discord.com/api/webhooks/...' # Enter Discord Webhook Address | Wstaw adres webhooka Discord

$data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$hostname = $env:COMPUTERNAME
$timezone = [System.TimeZoneInfo]::Local.Id
$ipAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" -and $_.PrefixOrigin -eq "Dhcp" }).IPAddress

# Settings from mode | Ustawienia zalezne od trybu
if ($Mode -eq "turnon") {
    $footerTime = (Get-Date).AddMinutes(-1).ToString("HH:mm")
    $username = "$hostname ON - $data"
    $title = "Your service $hostname is up!"
    $color = 65280 # Green | Zielony
} elseif ($Mode -eq "turnoff") {
    $footerTime = (Get-Date).ToString("HH:mm")
    $username = "$hostname OFF - $data"
    $title = "Your service $hostname is down!"
    $color = 16711680 # Red | Czerwony
}


$Body = @{
    "username" = $username
    "content" = ""
    "tts" = $false
    "embeds" = @(
        @{
            "color" = $color
            "title" = $title
            "fields" = @(
                @{
                    "name" = "Computer Name"
                    "value" = "$hostname"
                    "inline" = $false
                },
                @{
                    "name" = "Time ($timezone)"
                    "value" = "$data"
                    "inline" = $false
                },
                @{
                    "name" = "IP Address"
                    "value" = "$ipAddress"
                    "inline" = $false
                }
            )
            "footer" = @{
                "text" = "Today $footerTime`nSystem Notification`nSent from $hostname"
            }
        }
    )
}

$BodyJson = $Body | ConvertTo-Json -Depth 10
$BodyBytes = [System.Text.Encoding]::UTF8.GetBytes($BodyJson)

Invoke-RestMethod -Uri $webhookUri -Method 'Post' -Body $BodyBytes -ContentType 'application/json'

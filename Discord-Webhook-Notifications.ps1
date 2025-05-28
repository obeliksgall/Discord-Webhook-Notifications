$webhookUri = '' # Enter Discord Webhook Address between apostrophe

$data = Get-Date -Format "yyyy-MM-dd HH:mm:ss" # Get current date and time
$hostname = $env:COMPUTERNAME # Get the computer name
$timezone = [System.TimeZoneInfo]::Local.Id # Download your computer's timezone
$ipAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" -and $_.PrefixOrigin -eq "Dhcp" }).IPAddress # Getting the current IPv4 address
$footerTime = (Get-Date).AddMinutes(-1).ToString("HH:mm") # Get current time minus 1 minute

$Body = @{
    "username" = "$hostname ON - $data"
    "content" = ""
    "tts" = $false
    "embeds" = @(
        @{
            "color" = 65280
			#16711680 # Color red
			#65280 # Green color
            "title" = "Your service $hostname is up!"
            #"description" = "$hostname"
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

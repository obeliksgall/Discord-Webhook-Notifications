
---

# 💬 Discord Webhook Notifications for Power Events

A PowerShell script that sends a Discord notification when your computer turns on or off. Perfect for monitoring servers, workstations, or remote machines.

## 🚀 How to Run

Use PowerShell with the required `-Mode` parameter:

```powershell
powershell.exe -ExecutionPolicy Bypass -File ".\Discord-Webhook-Notifications.ps1" -Mode turnon
powershell.exe -ExecutionPolicy Bypass -File ".\Discord-Webhook-Notifications.ps1" -Mode turnoff
```

## 🛠 Parameters

| Parameter | Allowed Values       | Description                         |
|----------|----------------------|-------------------------------------|
| `-Mode`  | `turnon`, `turnoff`  | Specifies whether the system is starting or shutting down |

## 📤 What Gets Sent

The Discord message includes:

- 🖥 **Computer Name**
- 🕒 **Timestamp** (with local timezone)
- 🌐 **IP Address**
- 🎨 **Color-coded status**: green for `turnon`, red for `turnoff`
- 📎 **Footer** with time and hostname

## 🔧 Configuration

Replace the placeholder webhook URL in the script with your actual Discord webhook:

```powershell
$webhookUri = 'https://discord.com/api/webhooks/...' # <- Insert your webhook URL here
```

## 🧪 Example Use Case

To send a notification automatically when the system boots:

1. Open Task Scheduler.
2. Create a new task with trigger: **At startup**.
3. Set the action to run PowerShell with arguments:

```text
-ExecutionPolicy Bypass -File "C:\Path\To\Discord-Webhook-Notifications.ps1" -Mode turnon
```

Repeat with `turnoff` for shutdown events.

## 📋 Requirements

- PowerShell 5.1 or later
- Internet access
- Active Discord webhook

## 📘 License

MIT – free to use, modify, and distribute with attribution.

---

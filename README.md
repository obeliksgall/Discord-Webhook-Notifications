# Discord-Webhook-Notifications
Discord Webhook Notifications


PowerShell script that sends a notification to the specified Discord Webhook in the form below.

![Zrzut ekranu 2025-05-28 182311](https://github.com/user-attachments/assets/92f4ed3e-3846-43b9-abf9-7d3dd4e4a710)


Your service XYZ is up!
Computer Name
XYZ
Time (Central European Standard Time)
2025-05-28 17:34:27
IP Address
10.10.10.10.
Dzis 17:33
System Notification
Sent from XYZ


How to run?
Using Windows Scheduler (Below is an example for logging into Windows):
Steps:
1. Open Task Scheduler Press Win + R, type taskschd.msc, and hit Enter.
2. Create a New Task In the Task Scheduler, select "Create Task" from the right-hand panel.
3. General Tab Settings
  - Name the task (e.g., RunPowerShellOnLogin).
  - Select "Run only when user is logged on" (or "Run whether user is logged on or not", if needed).
  - Check "Run with highest privileges" if the script requires admin rights.
4. Trigger Configuration
  - Go to the "Triggers" tab and click "New...".
  - Set "Begin the task" to "At log on".
  - Select "Any user" or a specific user.
  - Click "OK".
5. Action to Run the Script
  - Go to the "Actions" tab and click "New...".
  - Set "Action" to "Start a program".
  - In "Program/script", enter:
      powershell.exe
  - In "Add arguments", enter:
      -ExecutionPolicy Bypass -File "C:\Path\To\YourScript.ps1"
  - Click "OK".
6. Finalize and Enable Task
  - Click "OK" to save the task.
  - Test it by logging out and logging in again.

Using gpedit.msc (Below is an example of how to shut down a computer)
Steps:
1. Open Group Policy Editor
  - Press Win + R, type gpedit.msc, and hit Enter.
2. Navigate to Shutdown Script Settings
  - Go to Computer Configuration > Windows Settings > Scripts (Startup/Shutdown).
  - Double-click Shutdown in the right pane.
3. Add Your PowerShell Script
  - In the Shutdown Properties window, click "Add…".
  - Click "Browse" and locate your PowerShell script (e.g., C:\Path\To\YourScript.ps1).
  - Click "OK".
4. Ensure PowerShell Execution Policy Allows Scripts
  - If your system restricts execution, modify the policy by running:
      Set-ExecutionPolicy Bypass -Scope LocalMachine
  - You can also add powershell.exe -ExecutionPolicy Bypass -File "C:\Path\To\YourScript.ps1" as a command instead.
5. Apply and Test
  - Click "OK" to save the settings.
  - Restart your computer and check if the script runs when shutting down.

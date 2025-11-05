# 🚀 Kiosk Auto-Start Configuration Guide

This guide explains how to make the kiosk application launch automatically after system login.

## 📋 Prerequisites

- Kiosk application installed in: `d:\screen_mirror_deployment\student-kiosk\desktop-app`
- Node.js installed and configured
- Windows operating system

---

## 🔧 Method 1: Task Scheduler (Recommended)

### Step 1: Open Task Scheduler
1. Press `Win + R`
2. Type `taskschd.msc` and press Enter

### Step 2: Create New Task
1. Click **"Create Task"** (not "Create Basic Task")
2. **General Tab:**
   - Name: `Lab Kiosk Auto-Start`
   - Description: `Automatically starts lab kiosk application on user login`
   - Select: **"Run only when user is logged on"**
   - Check: **"Run with highest privileges"**

### Step 3: Configure Trigger
1. Go to **"Triggers"** tab
2. Click **"New..."**
3. Begin the task: **"At log on"**
4. Specific user: Select the student user account
5. Delay task for: **10 seconds** (to ensure system is ready)
6. Click **"OK"**

### Step 4: Configure Action
1. Go to **"Actions"** tab
2. Click **"New..."**
3. Action: **"Start a program"**
4. Program/script: `d:\screen_mirror_deployment\START-KIOSK.bat`
5. Start in: `d:\screen_mirror_deployment\student-kiosk\desktop-app`
6. Click **"OK"**

### Step 5: Configure Conditions
1. Go to **"Conditions"** tab
2. **Uncheck** "Start the task only if the computer is on AC power"
3. Leave other settings as default

### Step 6: Configure Settings
1. Go to **"Settings"** tab
2. Check: **"Allow task to be run on demand"**
3. Check: **"Run task as soon as possible after a scheduled start is missed"**
4. If task fails, restart every: **1 minute**
5. Attempt to restart up to: **3 times**
6. Click **"OK"**

### Step 7: Test
1. Right-click on the task
2. Select **"Run"**
3. Kiosk should launch in full kiosk mode
4. Restart computer to verify auto-start

---

## 🔧 Method 2: Startup Folder (Simple)

### Step 1: Open Startup Folder
1. Press `Win + R`
2. Type `shell:startup` and press Enter

### Step 2: Create Shortcut
1. Right-click in the folder
2. Select **New → Shortcut**
3. Location: `d:\screen_mirror_deployment\START-KIOSK.bat`
4. Name: `Lab Kiosk`
5. Click **Finish**

### Step 3: Configure Shortcut (Optional)
1. Right-click on the shortcut
2. Select **Properties**
3. Change **Run:** to **Minimized** (if preferred)
4. Click **OK**

### Step 4: Test
1. Restart computer
2. Kiosk should launch automatically after login

---

## 🔧 Method 3: Registry Auto-Run (Advanced)

### Step 1: Open Registry Editor
1. Press `Win + R`
2. Type `regedit` and press Enter
3. Navigate to: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`

### Step 2: Create New Entry
1. Right-click in right pane
2. Select **New → String Value**
3. Name: `LabKiosk`
4. Double-click to edit
5. Value: `d:\screen_mirror_deployment\START-KIOSK.bat`
6. Click **OK**

### Step 3: Test
1. Restart computer
2. Kiosk should launch automatically

---

## ⚙️ Kiosk Configuration Features

Once deployed, the kiosk will have these features:

### 🔒 Security Features
- ✅ **Full kiosk mode** - No window decorations
- ✅ **Always on top** - Cannot switch to other windows
- ✅ **Keyboard shortcuts blocked:**
  - F12, Ctrl+Shift+I (DevTools)
  - Alt+F4 (Close window)
  - Alt+Tab (Switch windows)
  - Escape (Exit fullscreen)
  - F11 (Toggle fullscreen)
- ✅ **Cannot close** - Must logout to exit
- ✅ **Cannot minimize** - Stays fullscreen
- ✅ **Cannot resize** - Fixed fullscreen size

### ⏱️ Session Timer
- ✅ **Auto-shows on login** - Displays for 3 seconds
- ✅ **Auto-minimizes** - Minimizes automatically
- ✅ **Cannot close** - Must logout to close
- ✅ **Shows session duration** - Real-time timer
- ✅ **Shows student info** - Name and ID

### 📝 Type Bar
- ✅ **Always functional** - Aggressive focus management
- ✅ **Text selection enabled** - Can select and edit
- ✅ **Auto-focus on click** - Clicks activate input
- ✅ **Multiple focus attempts** - Ensures it works

---

## 🧪 Testing Checklist

After setup, verify:

```
☐ Kiosk launches on system startup
☐ Kiosk runs in fullscreen mode
☐ Cannot switch to other windows (Alt+Tab blocked)
☐ Cannot close window (Alt+F4 blocked)
☐ Cannot open DevTools (F12 blocked)
☐ Can type in login fields
☐ Can select text in input fields
☐ Timer window appears after login
☐ Timer window auto-minimizes
☐ Timer window cannot be closed (only minimized)
☐ Can logout successfully
☐ Timer window closes on logout
☐ Returns to login screen after logout
```

---

## 🛠️ Troubleshooting

### Issue: Kiosk doesn't start automatically
**Solutions:**
1. Check Task Scheduler task is enabled
2. Verify path in startup script is correct
3. Check Windows Event Viewer for errors
4. Try running START-KIOSK.bat manually
5. Ensure Node.js is in system PATH

### Issue: Keyboard shortcuts still work
**Solutions:**
1. Ensure KIOSK_MODE is set to `true` in main-simple.js
2. Check console for "Keyboard shortcuts blocked" message
3. Restart kiosk application
4. Verify Electron version is compatible

### Issue: Timer window doesn't appear
**Solutions:**
1. Check console for timer window creation messages
2. Look for minimized window in taskbar
3. Ensure session login is successful
4. Check for JavaScript errors in console

### Issue: Can still close the window
**Solutions:**
1. Verify closable is set to `false` in BrowserWindow options
2. Check if kiosk mode is actually enabled
3. Ensure close event handler is registered
4. Check Electron window creation code

---

## 📝 Manual Server IP Update

**Important:** The `.env` file is gitignored. Update it manually:

1. Navigate to: `d:\screen_mirror_deployment\central-admin\server\.env`
2. Edit the file:
   ```env
   SERVER_URL=http://192.168.29.212:7401
   ```
3. Save and restart server

---

## 🔐 User Account Configuration

For best security:

1. **Create dedicated student account:**
   - Limited permissions
   - No admin rights
   - Auto-login enabled (optional)

2. **Disable unnecessary features:**
   - Disable Task Manager access
   - Disable system settings access
   - Disable file explorer access

3. **Enable auto-login (optional):**
   - Press `Win + R`
   - Type `netplwiz`
   - Uncheck "Users must enter a username and password"
   - Select student account
   - Click OK and enter password

---

## ✅ Deployment Complete

Once configured:
1. Kiosk launches automatically on login
2. Runs in exclusive fullscreen mode
3. All shortcuts are blocked
4. Timer shows session duration
5. Must use logout button to exit

**Next Steps:**
- Deploy to all student PCs
- Train students on login procedure
- Train faculty on admin dashboard
- Monitor first lab session
- Document any issues

---

**Created:** October 2025  
**Version:** 1.0  
**IP Address:** 192.168.29.212:7401

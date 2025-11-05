# 🧪 Kiosk Testing Mode - Toggle Instructions

## ✅ CURRENT STATUS: TESTING MODE ENABLED

Kiosk app is now running in **TESTING MODE** with:
- ✅ DevTools enabled (Ctrl+Shift+I)
- ✅ Window can be closed
- ✅ Window can be minimized/maximized
- ✅ Normal window frame visible
- ✅ Not fullscreen
- ✅ Shows in taskbar

---

## 🔍 How to Test Hardware Monitoring Now

### **Step 1: Restart the Kiosk App**

Close the current kiosk window and restart:

```powershell
cd d:\screen_mirror_deployment_my_laptop\student-kiosk\desktop-app
npm start
```

### **Step 2: Login as Student**

- Login with your test student credentials
- Window will open as **normal app** (not fullscreen)

### **Step 3: Open DevTools**

Press **`Ctrl + Shift + I`** to open Developer Tools

### **Step 4: Watch the Console**

In the Console tab, you should see:
```
🔍 Hardware Monitor initialized for: [Your Name]
🔍 Hardware monitoring started...
🌐 Network monitoring started. Current status: Online
⌨️🖱️ Input device monitoring started
```

### **Step 5: Test WiFi Disconnect**

1. Turn OFF WiFi (or Airplane Mode)
2. **Watch the console** - you should see:
```
🔴 ========================================
🔴 NETWORK OFFLINE EVENT DETECTED!
🔴 ========================================
📊 Student Info: {studentId: "...", studentName: "...", ...}
📊 Socket Connected: false
🚨 Preparing to send alert: {...}
📦 Alert stored for retry. Pending alerts: 1
```

3. Turn WiFi back ON
4. **Watch the console again**:
```
🟢 ========================================
🟢 NETWORK ONLINE EVENT DETECTED!
🟢 ========================================
✅ Socket.io connected: [socket-id]
🔄 Updating hardware monitor socket after reconnect
🔄 Retrying 1 pending alerts
✅ Alert sent successfully
```

---

## 🔧 What Was Fixed

### **Issue**: Alerts not appearing when WiFi disconnects

**Root Cause**: When WiFi disconnects, the socket also disconnects, so alerts couldn't be sent immediately.

**Solution**: 
1. ✅ Alerts are now **stored locally** when socket is disconnected
2. ✅ When network reconnects, socket reconnects and **automatically retries** all pending alerts
3. ✅ Added detailed logging to see exactly what's happening

---

## 🎯 Expected Behavior Now

### **WiFi Disconnect:**
1. Network offline event fires
2. Alert created with critical severity
3. Socket is disconnected, so alert stored locally
4. Console shows: "📦 Alert stored for retry"

### **WiFi Reconnect:**
1. Network online event fires
2. Socket reconnects automatically
3. Hardware monitor socket reference updated
4. All pending alerts automatically retried
5. Reconnect alert also sent
6. **Admin dashboard receives BOTH alerts**

---

## 🔄 How to Restore FULL KIOSK MODE

When you're done testing and ready for lab deployment, restore kiosk mode:

### **File**: `student-kiosk/desktop-app/main-simple.js`

**Find lines 21-22** and change:
```javascript
// CURRENT (Testing Mode):
const KIOSK_MODE = false; // 🧪 TESTING MODE - Set to true for deployment
let isKioskLocked = false; // System starts unlocked for testing
```

**Change to (Kiosk Mode)**:
```javascript
// DEPLOYMENT (Kiosk Mode):
const KIOSK_MODE = true; // Enabled for deployment
let isKioskLocked = true; // System starts locked
```

**Find lines 28-45** and change:
```javascript
// CURRENT (Testing Mode):
mainWindow = new BrowserWindow({
    width: 1200,                             // 🧪 TESTING: Fixed width
    height: 800,                             // 🧪 TESTING: Fixed height
    frame: true,                             // 🧪 TESTING: Show frame
    fullscreen: false,                       // 🧪 TESTING: Not fullscreen
    alwaysOnTop: false,                      // 🧪 TESTING: Normal window
    skipTaskbar: false,                      // 🧪 TESTING: Show in taskbar
    kiosk: false,                            // 🧪 TESTING: Disable kiosk mode
    resizable: true,                         // 🧪 TESTING: Allow resize
    minimizable: true,                       // 🧪 TESTING: Allow minimize
    closable: true,                          // 🧪 TESTING: Allow close
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true,
      nodeIntegration: false,
      enableBlinkFeatures: 'GetDisplayMedia',
      webSecurity: false,
      devTools: true                         // 🧪 TESTING: Enable DevTools
    }
  });
```

**Change to (Kiosk Mode)**:
```javascript
// DEPLOYMENT (Kiosk Mode):
mainWindow = new BrowserWindow({
    width,                                   // Full screen width
    height,                                  // Full screen height
    frame: false,                            // No frame for kiosk
    fullscreen: true,                        // Force fullscreen
    alwaysOnTop: true,                       // Always on top
    skipTaskbar: true,                       // Hide from taskbar
    kiosk: true,                             // Enable kiosk mode
    resizable: false,                        // No resizing
    minimizable: false,                      // No minimize
    closable: false,                         // No close button
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true,
      nodeIntegration: false,
      enableBlinkFeatures: 'GetDisplayMedia',
      webSecurity: false,
      devTools: false                        // Disable DevTools
    }
  });
```

**Find lines 65-73** and change:
```javascript
// CURRENT (Testing Mode):
console.log('🧪 TESTING MODE: DevTools enabled, normal window controls available');

mainWindow.once('ready-to-show', () => {
  mainWindow.show();
  mainWindow.focus();
  // 🧪 TESTING: No fullscreen, no always on top
  
  console.log(`🧪 TESTING MODE - System: ${SYSTEM_NUMBER}, Lab: ${LAB_ID} - Server: ${SERVER_URL}`);
  console.log('🔍 Press Ctrl+Shift+I to open DevTools');
});

// 🧪 TESTING: Allow window closure
mainWindow.on('close', (e) => {
  console.log('✅ Window closing (testing mode)');
  // Don't prevent closing in testing mode
});
```

**Change to (Kiosk Mode)**:
```javascript
// DEPLOYMENT (Kiosk Mode):
console.log('🔒 KIOSK MODE: Full restrictions enabled for deployment');

mainWindow.once('ready-to-show', () => {
  mainWindow.show();
  mainWindow.focus();
  mainWindow.setFullScreen(true);
  mainWindow.setAlwaysOnTop(true, 'screen-saver');
  
  console.log(`🔒 KIOSK MODE - System: ${SYSTEM_NUMBER}, Lab: ${LAB_ID} - Server: ${SERVER_URL}`);
});

// Prevent window closure in kiosk mode
mainWindow.on('close', (e) => {
  e.preventDefault();
  console.log('❌ Window close prevented - kiosk mode active');
});
```

---

## 📋 Quick Toggle Summary

| Feature | Testing Mode | Kiosk Mode |
|---------|-------------|------------|
| Window Frame | ✅ Visible | ❌ Hidden |
| DevTools | ✅ Enabled (Ctrl+Shift+I) | ❌ Disabled |
| Fullscreen | ❌ No | ✅ Yes |
| Close Button | ✅ Can close | ❌ Cannot close |
| Minimize/Maximize | ✅ Yes | ❌ No |
| Always on Top | ❌ No | ✅ Yes |
| Taskbar | ✅ Shows | ❌ Hidden |
| Escape Key | ✅ Works | ❌ Blocked |

---

## 🎯 When to Use Each Mode

### **Testing Mode** (Current)
- ✅ Testing hardware monitoring
- ✅ Debugging issues
- ✅ Checking console logs
- ✅ Development work
- ✅ On your personal laptop

### **Kiosk Mode** (Deployment)
- ✅ Lab deployment
- ✅ Student PCs
- ✅ Production environment
- ✅ Exam sessions
- ✅ Prevent unauthorized access

---

## ⚡ Quick Command

To switch back to kiosk mode, you can use this PowerShell command:

```powershell
# Replace testing mode with kiosk mode (backup first!)
cd d:\screen_mirror_deployment_my_laptop\student-kiosk\desktop-app
Copy-Item main-simple.js main-simple.js.testing-backup

# Then manually edit main-simple.js to restore kiosk settings
```

---

**Current Status**: ✅ TESTING MODE (DevTools enabled, normal window)  
**To Deploy**: Change settings in `main-simple.js` as shown above  
**Backup Created**: No (do this manually before changing back)

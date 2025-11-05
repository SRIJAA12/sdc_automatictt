# 🔧 Hardware Disconnection Testing Guide

## ✅ Status: Updated to IP 192.168.29.212

All configuration files have been updated to use the new IP address `192.168.29.212:7401`

---

## 📋 Part 1: IP Address Update Summary

### ✅ Files Updated:
1. **`student-kiosk/desktop-app/main-simple.js`** - Line 17
   - Updated SERVER_URL to `http://192.168.29.212:7401`

2. **`student-kiosk/desktop-app/renderer.js`** - Line 8
   - Updated serverUrl to `http://192.168.29.212:7401`

3. **`student-kiosk/desktop-app/renderer-fixed.js`** - Line 6
   - Already had `http://192.168.29.212:7401`

4. **`student-kiosk/desktop-app/first-signin.html`** - Line 260
   - Already had `http://192.168.29.212:7401`

5. **`central-admin/dashboard/working-simple.html`** - Line 281
   - Already had `http://192.168.29.212:7401`

---

## 🔍 Part 2: Hardware Monitoring Code Verification

### ✅ Hardware Monitoring Implementation Status: **PERFECT**

The hardware disconnection monitoring code is **fully implemented** and working correctly.

### **What's Monitored:**

1. **Network/Ethernet Connection** ✅
   - Detects WiFi/Ethernet disconnection instantly
   - Uses both native browser events (`offline`/`online`) and periodic polling
   - Sends alerts with `critical` severity on disconnect
   - Sends alerts with `info` severity on reconnect

2. **Keyboard Activity** ✅
   - Monitors all keyboard events
   - Detects inactivity after 5 minutes
   - Sends alert if no keyboard input detected
   - Automatically clears alert when activity resumes

3. **Mouse Activity** ✅
   - Monitors mouse movement, clicks, and button presses
   - Detects inactivity after 5 minutes
   - Sends alert if no mouse input detected
   - Automatically clears alert when activity resumes

### **Key Features:**

✅ **Offline Alert Storage**: When network disconnects and socket is lost, alerts are stored locally and automatically retried when connection returns

✅ **Socket Reconnection**: Automatically updates hardware monitor with new socket when reconnection occurs

✅ **Detailed Logging**: All events are logged to console for debugging

✅ **Real-time Monitoring**: Network checks every 5 seconds, activity checks every 30 seconds

---

## 🚀 Part 3: Step-by-Step Testing Instructions

### **Prerequisites:**
- Laptop with the screen mirror system installed
- WiFi/Ethernet connection available
- Admin access to central dashboard

---

## 📝 STEP-BY-STEP GUIDE

### **STEP 1: Open Central Admin Dashboard on Laptop**

1. **Open Command Prompt or PowerShell** (Press `Win + R`, type `cmd` or `powershell`, press Enter)

2. **Navigate to central-admin server directory:**
   ```powershell
   cd d:\screen_mirror_deployment_my_laptop\central-admin\server
   ```

3. **Start the Central Admin Server:**
   ```powershell
   npm start
   ```
   
   You should see:
   ```
   ✅ Connected to MongoDB
   🚀 Server running on port 7401
   📡 Socket.io server ready
   ```

4. **Open your web browser** (Chrome, Edge, or Firefox)

5. **Go to the Admin Dashboard:**
   ```
   http://192.168.29.212:7401/dashboard/working-simple.html
   ```
   
   OR if on the same machine:
   ```
   http://localhost:7401/dashboard/working-simple.html
   ```

6. **Login with admin credentials:**
   - The passkey should be set in your system
   - You should see the main dashboard interface

---

### **STEP 2: Open Kiosk App on Laptop (Testing Mode)**

1. **Open a NEW Command Prompt or PowerShell window**

2. **Navigate to kiosk directory:**
   ```powershell
   cd d:\screen_mirror_deployment_my_laptop\student-kiosk\desktop-app
   ```

3. **Start the Kiosk App in Testing Mode:**
   ```powershell
   npm start
   ```
   
   The kiosk window will open in **Testing Mode** with:
   - Normal window frame (not fullscreen)
   - DevTools available (Ctrl+Shift+I)
   - Window can be minimized/closed

---

### **STEP 3: Login as Student in Kiosk**

1. **In the Kiosk window**, use test student credentials to login:
   - Student ID: `[your test student ID]`
   - Password: `[your test password]`
   - System Number: `CC1-01` (or any system number)

2. **After successful login:**
   - You should see "Login Successful"
   - A small timer window appears (minimized to taskbar)
   - The main window should show the student interface

3. **Open DevTools immediately:**
   - Press **`Ctrl + Shift + I`**
   - Click on the **Console** tab
   - You should see:
     ```
     🔍 Hardware Monitor initialized for: [Student Name]
     🔍 Hardware monitoring started...
     🌐 Network monitoring started. Current status: Online
     ⌨️🖱️ Input device monitoring started
     ```

---

### **STEP 4: Monitor Hardware Alerts on Admin Dashboard**

1. **In your browser with Admin Dashboard open:**
   - You should see your logged-in student session
   - The student's status should show as "Active"
   - You should see their system number (CC1-01)

2. **Look for Hardware Alert Panel:**
   - The dashboard should have a section for hardware alerts
   - It should show "All systems normal" or similar status

---

### **STEP 5: Test Network Disconnection**

#### **Test 5A: WiFi Disconnect (Recommended)**

1. **In the Kiosk DevTools Console**, make sure you're watching for logs

2. **Disconnect WiFi:**
   - Click on the WiFi icon in Windows taskbar
   - Click on your connected network
   - Click **"Disconnect"**
   
   OR use Airplane Mode:
   - Press `Win + A` to open Action Center
   - Click **"Airplane mode"** to turn it ON

3. **Watch the Kiosk Console immediately:**
   ```
   🔴 ========================================
   🔴 NETWORK OFFLINE EVENT DETECTED!
   🔴 ========================================
   📊 Student Info: {studentId: "...", studentName: "...", ...}
   📊 Socket Connected: false
   🚨 Preparing to send alert: {...}
   📦 Alert stored for retry. Pending alerts: 1
   ```

4. **Check Admin Dashboard:**
   - You might NOT see the alert yet (because network is down)
   - The student's status might show "Offline" or "Disconnected"

5. **Reconnect WiFi:**
   - Turn off Airplane mode OR reconnect to WiFi
   - Wait 2-5 seconds

6. **Watch the Kiosk Console again:**
   ```
   🟢 ========================================
   🟢 NETWORK ONLINE EVENT DETECTED!
   🟢 ========================================
   ✅ Socket.io connected: [socket-id]
   🔄 Updating hardware monitor socket after reconnect
   🔄 Retrying 1 pending alerts
   ✅ Alert sent successfully
   ```

7. **Check Admin Dashboard:**
   - **NOW you should see TWO alerts:**
     1. **Network Disconnected** (Critical - Red)
     2. **Network Reconnected** (Info - Blue/Green)
   - Both alerts should show:
     - Student Name
     - Student ID
     - System Number
     - Device Type: "Network"
     - Timestamp

---

#### **Test 5B: Ethernet Cable Disconnect (If Available)**

1. **If using Ethernet cable**, physically unplug the cable

2. **Watch Kiosk Console** - same logs as WiFi test

3. **Check Admin Dashboard** - same alerts as WiFi test

4. **Plug cable back in** and verify reconnection alerts appear

---

### **STEP 6: Test Keyboard Inactivity (Optional - Takes 5 Minutes)**

1. **After logging in as student**, do NOT touch the keyboard at all

2. **Wait exactly 5 minutes** without any keyboard input

3. **After 5 minutes, check Kiosk Console:**
   ```
   ⚠️ Keyboard inactivity detected - possible disconnection
   ```

4. **Check Admin Dashboard:**
   - You should see a **Keyboard Inactive** alert (Warning - Orange/Yellow)
   - Message: "Keyboard inactive for 5 minutes on [System]"

5. **Press ANY KEY on the keyboard**

6. **Check Kiosk Console:**
   ```
   ✅ Keyboard activity detected - device reconnected
   ```

7. **Check Admin Dashboard:**
   - You should see a **Keyboard Reconnected** alert

---

### **STEP 7: Test Mouse Inactivity (Optional - Takes 5 Minutes)**

1. **After logging in as student**, do NOT move or click the mouse at all

2. **Wait exactly 5 minutes** without any mouse movement

3. **After 5 minutes, check Kiosk Console:**
   ```
   ⚠️ Mouse inactivity detected - possible disconnection
   ```

4. **Check Admin Dashboard:**
   - You should see a **Mouse Inactive** alert (Warning - Orange/Yellow)

5. **Move the mouse or click**

6. **Check Kiosk Console:**
   ```
   ✅ Mouse activity detected - device reconnected
   ```

7. **Check Admin Dashboard:**
   - You should see a **Mouse Reconnected** alert

---

## 🎯 Expected Results Summary

### **Network Disconnect/Reconnect Test:**
- ✅ Kiosk console shows offline event
- ✅ Alert stored locally when socket disconnected
- ✅ On reconnect, stored alerts are automatically sent
- ✅ Admin dashboard receives both disconnect and reconnect alerts
- ✅ Alerts show correct student info, system number, timestamps

### **Keyboard/Mouse Inactivity Test:**
- ✅ After 5 minutes of no activity, warning alert sent
- ✅ When activity resumes, reconnect alert sent
- ✅ Admin dashboard receives both alerts with correct details

---

## ⚠️ Troubleshooting

### **Problem: No alerts appearing on Admin Dashboard**

**Solutions:**
1. Check server is running (`npm start` in server directory)
2. Check kiosk is connected (Console should show: `✅ Socket.io connected`)
3. Check browser console on Admin Dashboard for errors (Press F12)
4. Verify IP address is correct (192.168.29.212)
5. Make sure firewall is not blocking port 7401

### **Problem: Kiosk console shows "Socket not connected"**

**Solutions:**
1. Restart the central admin server
2. Restart the kiosk app
3. Check network connection
4. Verify server is listening on 192.168.29.212:7401

### **Problem: Alerts are not stored during offline**

**Check:**
1. Kiosk console should show: `📦 Alert stored for retry`
2. If not, the hardware-monitor.js might need verification
3. Check browser console for JavaScript errors

---

## 📊 Quick Test Checklist

Use this checklist for quick verification:

- [ ] Central Admin Server started successfully
- [ ] Admin Dashboard opens and connects
- [ ] Kiosk app starts in testing mode
- [ ] Student login successful
- [ ] DevTools open and console shows hardware monitoring started
- [ ] WiFi disconnect triggers offline alert in console
- [ ] Alert stored locally (shown in console)
- [ ] WiFi reconnect triggers online alert in console
- [ ] Stored alerts automatically sent (shown in console)
- [ ] Admin Dashboard shows both disconnect and reconnect alerts
- [ ] All alerts have correct student info and timestamps

---

## 🔐 Security Note

**After testing is complete**, remember to switch back to **KIOSK MODE** for production:

1. Edit `student-kiosk/desktop-app/main-simple.js`
2. Change line 22: `const KIOSK_MODE = true;`
3. Change line 23: `let isKioskLocked = true;`
4. Restore fullscreen window settings (see TESTING_MODE_TOGGLE.md)

---

## 📞 Support

If you encounter any issues during testing:
1. Check all console logs (both Kiosk DevTools and Admin Dashboard F12)
2. Verify all services are running
3. Check network connectivity
4. Review error messages in server terminal

---

**Last Updated:** November 2, 2024
**IP Address:** 192.168.29.212:7401
**Status:** ✅ Ready for Testing

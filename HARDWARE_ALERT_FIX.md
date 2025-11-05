# Hardware Alert Fix - Network Disconnect Detection

## Problem Fixed
Previously, when the network was disconnected (WiFi turned off), hardware alerts were not being sent to the admin dashboard because:
1. Socket disconnected at the same time as the network
2. Alerts couldn't be sent without an active socket connection
3. Alerts were stored in memory but lost on refresh

## Solution Implemented

### 1. **Socket Connection Monitoring** (Primary Detection)
- Monitors socket connection status every 2 seconds
- Detects disconnection as a proxy for network issues
- More reliable than `navigator.onLine` events

### 2. **Persistent Storage**
- Stores alerts in `localStorage` instead of just memory
- Alerts survive even if the app is closed/refreshed
- Automatically sends stored alerts when connection is restored

### 3. **Automatic Alert Sending on Reconnect**
- When socket reconnects, immediately checks for pending alerts
- Sends both disconnect and reconnect alerts
- Includes small delays to prevent overwhelming the server

## Testing Instructions

### Test 1: WiFi Disconnect
1. **Start the kiosk app** and log in with student credentials
2. **Open admin dashboard** on your phone/browser
3. **Turn off WiFi** on the laptop running the kiosk
4. **Wait 2-5 seconds** - Alert will be stored in localStorage
5. **Turn WiFi back on**
6. **Within a few seconds**, you should see:
   - Network disconnect alert (with timestamp when it occurred)
   - Network reconnect alert

### Test 2: Network Adapter Disable
1. **Start the kiosk app** and log in
2. **Open admin dashboard**
3. **Disable the network adapter** in Windows Network Settings
4. **Wait 2-5 seconds**
5. **Re-enable the network adapter**
6. **Check admin dashboard** for both alerts

### Test 3: Ethernet Cable Unplugging
1. **Use Ethernet connection** (not WiFi)
2. **Start kiosk and admin**
3. **Unplug ethernet cable**
4. **Wait 2-5 seconds**
5. **Plug cable back in**
6. **Check admin dashboard** for alerts

## What to Check in Console

### Kiosk Console (F12 in Electron app):
When network disconnects:
```
🔴 ========================================
🔴 SOCKET DISCONNECTED - NETWORK ISSUE!
🔴 ========================================
🚨 Network disconnect detected via socket
💾 Alert stored in localStorage. Total pending: 1
```

When network reconnects:
```
🟢 ========================================
🟢 SOCKET RECONNECTED - NETWORK RESTORED!
🟢 ========================================
✅ Socket.io connected: [socket-id]
🔄 Updating hardware monitor socket after reconnect
📤 Sending 1 pending alerts from storage
📤 Sending stored alert 1/1: Network hardware_disconnect
✅ Alert sent successfully via socket
✅ Network reconnect alert
```

### Server Console:
```
🚨 Hardware alert received: { deviceType: 'Network', type: 'hardware_disconnect', ... }
✅ Hardware alert saved to database
📡 Alert broadcast to admins: Network hardware_disconnect
```

### Admin Dashboard:
- Should show hardware alert notification
- Alert should appear in the hardware alerts section
- Should show "Network disconnected" and "Network reconnected"

## Key Improvements

1. **Reliable Detection**: Socket monitoring is more reliable than browser events
2. **Persistent Alerts**: localStorage prevents alert loss
3. **Automatic Recovery**: Sends alerts as soon as connection is restored
4. **Better Logging**: Detailed console output for debugging

## Files Modified

1. `hardware-monitor.js`:
   - Added `monitorSocketConnection()` method
   - Added localStorage persistence methods
   - Improved alert sending logic

2. `renderer.js`:
   - Updated socket reconnection handler
   - Properly calls `updateSocket()` and `retryPendingAlerts()`

## Troubleshooting

### If alerts still don't appear:

1. **Check localStorage**: Open browser console and run:
   ```javascript
   localStorage.getItem('pendingHardwareAlerts')
   ```

2. **Check socket connection**: In kiosk console:
   ```javascript
   socket.connected  // Should be true
   ```

3. **Manually trigger alert**: In kiosk console:
   ```javascript
   hardwareMonitor.sendAlert({
     type: 'hardware_disconnect',
     deviceType: 'Network',
     studentId: 'TEST',
     studentName: 'Test Student',
     systemNumber: 'System-1',
     timestamp: new Date().toISOString(),
     message: 'Test alert',
     severity: 'critical'
   })
   ```

4. **Check admin socket room**: In server console, check if admin is in 'admins' room

## Next Steps

If you need additional features:
- Add email notifications for critical alerts
- Add SMS alerts via Twilio
- Add alert history in admin dashboard
- Add alert acknowledgment system

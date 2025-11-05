# 🚀 Auto IP Detection - Quick Start

## ✨ IP addresses are now detected automatically!

No more manual configuration. Just start the server and everything works.

---

## 📦 What Changed?

**BEFORE (Manual):**
```javascript
// Had to edit this in 5+ files every time network changed
const SERVER_URL = 'http://192.168.29.212:7401';
```

**AFTER (Automatic):**
```javascript
// Reads from auto-generated config file
const SERVER_URL = loadServerUrl(); // Auto-detects!
```

---

## 🎯 How to Use

### **Step 1: Start Server**
```powershell
cd d:\screen_mirror_deployment_my_laptop\central-admin\server
npm start
```

**Server will show:**
```
✅ Detected IP from Wi-Fi: 192.168.29.212
✅ Server config saved to: server-config.json
🌐 Network Access: http://192.168.29.212:7401
```

### **Step 2: Start Kiosk**
```powershell
cd d:\screen_mirror_deployment_my_laptop\student-kiosk\desktop-app
npm start
```

**Kiosk will show:**
```
✅ Loaded server URL from config: http://192.168.29.212:7401
```

### **Step 3: Open Dashboard**
```
http://192.168.29.212:7401/dashboard/working-simple.html
```

**Dashboard will show:**
```
✅ Server URL loaded from config
🔌 Socket connected
```

---

## 🔄 When Network Changes

1. **Disconnect from old network**
2. **Connect to new network**
3. **Restart server** - it will detect new IP
4. **Restart kiosk** - it will read new config
5. **Refresh dashboard** - it will fetch new config

**That's it!** No code editing needed.

---

## 📁 New Files

- **`server-config.json`** - Auto-generated config file
  - Contains current server IP
  - Updated every time server starts
  - Read by all components

- **`central-admin/server/ip-detector.js`** - IP detection utility
  - Detects WiFi/Ethernet IP
  - Handles multiple network adapters
  - Saves to config file

---

## ✅ Success Indicators

Everything is working when you see:
- ✅ Server shows "Detected IP from..."
- ✅ Kiosk shows "Loaded server URL from config"
- ✅ Dashboard shows "Server URL loaded from config"
- ✅ All show the SAME IP address

---

## ⚠️ Troubleshooting

**Problem:** Kiosk can't find config file
**Solution:** Start server FIRST to create the config

**Problem:** Wrong IP detected
**Solution:** Restart server, it will re-detect

**Problem:** Config file missing
**Solution:** Server creates it automatically on startup

---

## 📚 More Info

See **`AUTO_IP_DETECTION_GUIDE.md`** for complete documentation.

---

**Status:** ✅ Working
**Benefit:** No more manual IP updates!

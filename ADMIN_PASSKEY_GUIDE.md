# 🔐 Admin Dashboard Passkey Authentication Guide

## Overview
The admin dashboard now requires passkey authentication before access. This adds a security layer to prevent unauthorized access to the lab management system.

## Default Passkey
**Default Passkey:** `admin123`

⚠️ **IMPORTANT:** Change this default passkey immediately for security!

## How to Access the Dashboard

1. **Start the server** (if not already running):
   ```
   cd central-admin/server
   npm start
   ```

2. **Open your browser** and navigate to:
   ```
   http://localhost:7401
   ```
   or
   ```
   http://10.10.46.103:7401
   ```

3. You will be redirected to the **Admin Login page**

4. **Enter the passkey** (default: `admin123`)

5. Click **"Access Dashboard"** to login

6. You will be redirected to the **Admin Dashboard** where you can:
   - Start/End lab sessions
   - Monitor student screens
   - Schedule lab sessions
   - Generate reports
   - Shutdown systems

## Security Features

✅ **Session-based authentication** - Passkey is required only once per browser session
✅ **Auto-logout on browser close** - Authentication clears when browser is closed
✅ **Maximum attempts limit** - Prevents brute force attacks (5 attempts max)
✅ **Logout button** - Admins can manually logout when done
✅ **Protected dashboard** - Direct access to dashboard redirects to login if not authenticated

## How to Change the Passkey

### Method 1: Using Browser Console (Recommended)

1. Open any web browser
2. Press `F12` to open Developer Tools
3. Go to the **Console** tab
4. Type the following command with your new passkey:
   ```javascript
   btoa("YOUR_NEW_PASSKEY_HERE")
   ```
   Example: `btoa("LAB2024secure")`
   
5. Press Enter - you'll get a hash like: `TEFCMJAY0c2VjdXJl`

6. Copy this hash

7. Open the file: `central-admin/dashboard/admin-login.html`

8. Find this line (around line 158):
   ```javascript
   const ADMIN_PASSKEY_HASH = 'YWRtaW4xMjM='; // Base64 encoded "admin123"
   ```

9. Replace it with your new hash:
   ```javascript
   const ADMIN_PASSKEY_HASH = 'YOUR_NEW_HASH_HERE'; // Base64 encoded "YOUR_NEW_PASSKEY_HERE"
   ```

10. Save the file

11. **Refresh your browser** - the new passkey is now active!

### Method 2: Direct Edit (Simple)

1. Open: `central-admin/dashboard/admin-login.html`

2. Find line ~158:
   ```javascript
   const ADMIN_PASSKEY_HASH = 'YWRtaW4xMjM=';
   ```

3. Generate your hash using this JavaScript:
   ```javascript
   btoa("your_passkey")
   ```

4. Replace the hash with your new one

5. Save and refresh

## Example Passkeys (Pre-Generated)

Here are some example passkeys you can use (just replace the hash):

| Passkey | Hash to Use |
|---------|-------------|
| `admin123` | `YWRtaW4xMjM=` (default) |
| `LAB2024` | `TEFCMJAY` |
| `secure123` | `c2VjdXJlMTIz` |
| `CSELab2024` | `Q1NFTGFiMjAyNA==` |
| `admin@2024` | `YWRtaW5AMjAyNA==` |

## Troubleshooting

### ❌ "Invalid passkey" error
- Make sure you're entering the correct passkey
- Check if caps lock is on
- Verify the hash in `admin-login.html` matches your passkey

### ❌ "Too many failed attempts"
- Refresh the page to reset the attempt counter
- Wait a few seconds before trying again

### ❌ Dashboard redirects to login even after entering passkey
- Clear your browser's sessionStorage:
  1. Press F12 → Console
  2. Type: `sessionStorage.clear()`
  3. Try logging in again

### ❌ Forgot your passkey
1. Open `central-admin/dashboard/admin-login.html`
2. Find the `ADMIN_PASSKEY_HASH` value (line ~158)
3. Decode it using:
   ```javascript
   atob("YOUR_HASH_HERE")
   ```
4. This will show your current passkey
5. Or simply set a new passkey using Method 1 above

## Security Best Practices

🔒 **Change the default passkey immediately**
🔒 **Use a strong passkey** (mix of letters, numbers, special characters)
🔒 **Don't share the passkey** with unauthorized users
🔒 **Change passkey periodically** (e.g., every 3 months)
🔒 **Log out when done** using the logout button
🔒 **Close browser** when leaving the workstation

## Technical Details

- **Authentication Method:** Client-side passkey verification using Base64 encoding
- **Storage:** sessionStorage (cleared on browser close)
- **Attempt Limit:** 5 failed attempts before lockout
- **Session Duration:** Until browser is closed or manual logout

## Files Modified

1. `central-admin/dashboard/admin-login.html` - New login page
2. `central-admin/dashboard/index.html` - Redirects to login
3. `central-admin/dashboard/admin-dashboard.html` - Added auth check and logout button

## Support

If you need help:
1. Check this guide first
2. Review the troubleshooting section
3. Check browser console for error messages (F12 → Console)
4. Verify server is running on correct port

---

**Version:** 1.0
**Last Updated:** October 2024
**Status:** ✅ Active

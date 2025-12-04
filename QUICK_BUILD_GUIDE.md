# 🚀 Quick Build Guide - Student Kiosk to EXE

## ⚡ Fast Track (5 Minutes)

### 1. Prerequisites Check
```bash
# Check if Node.js is installed
node --version
# Should show v16+ or v18+

# Check if Git is installed  
git --version
```

### 2. Prepare for GitHub
```bash
# Navigate to your project
cd /d "d:\screen_mirror_deployment_my_laptop"

# Initialize git (if not done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Student Kiosk with blocking features"
```

### 3. Create GitHub Repository
1. Go to https://github.com/new
2. Repository name: `student-kiosk-system`
3. Make it **Public** (for free GitHub Actions)
4. Click "Create repository"

### 4. Push to GitHub
```bash
# Add your GitHub repository (replace USERNAME)
git remote add origin https://github.com/USERNAME/student-kiosk-system.git

# Push code
git push -u origin main
```

### 5. Automatic Build
- GitHub Actions will automatically start building
- Go to your repo → "Actions" tab
- Wait 5-10 minutes for build to complete
- Download the .exe from "Artifacts" section

## 🎯 Manual Local Build (Alternative)

If you want to build locally instead:

```bash
# Navigate to kiosk app
cd student-kiosk/desktop-app

# Install dependencies
npm install

# Build Windows executable
npm run build-win

# Find your .exe in the dist/ folder
```

## 📦 What You Get

After successful build:

1. **Installer Version**: `College-Lab-Kiosk-Setup-1.0.0.exe`
   - Full installation with shortcuts
   - Requires admin rights
   - Uninstaller included

2. **Portable Version**: `College-Lab-Kiosk-Portable-1.0.0.exe`
   - Run directly, no installation
   - Can run from USB drive
   - No admin rights needed

## 🔒 Kiosk Features Enabled

Your built application now includes:

✅ **Full Kiosk Mode**
- Blocks Alt+Tab completely
- Prevents opening other applications
- Fullscreen locked mode
- Cannot minimize or close during session

✅ **Auto System Detection**
- No manual lab/system selection needed
- Automatically detects system number
- Uses hostname-based detection

✅ **Session Management**
- Clears old student data before new sessions
- Automatic logout on session end
- Proper cleanup of resources

## 🚨 Troubleshooting

### Build Fails on GitHub
1. Check Actions tab for error logs
2. Ensure package.json syntax is correct
3. Verify all files are committed

### Local Build Fails
```bash
# Clear cache and reinstall
cd student-kiosk/desktop-app
rm -rf node_modules package-lock.json
npm install
npm run build-win
```

### Application Won't Start
1. Run as Administrator
2. Check Windows Defender/Antivirus
3. Ensure all dependencies are included

## 📋 File Checklist

Before building, ensure you have:

- [ ] ✅ `student-kiosk/desktop-app/package.json` (updated)
- [ ] ✅ `student-kiosk/desktop-app/main-simple.js` (kiosk mode enabled)
- [ ] ✅ `student-kiosk/desktop-app/student-interface.html` (lab selection removed)
- [ ] ✅ `.github/workflows/build-exe.yml` (GitHub Actions)
- [ ] ✅ `central-admin/server/app.js` (session clearing enabled)

## 🎉 Success!

Once built, your Student Kiosk application:

1. **Runs in full kiosk mode** - No Alt+Tab, no other apps
2. **Auto-detects system info** - No manual selection needed  
3. **Clears old sessions** - Fresh start for each lab session
4. **Professional installer** - Easy deployment to lab computers

## 📞 Need Help?

1. **GitHub Build Issues**: Check the Actions tab logs
2. **Local Build Issues**: Run `npm run build-win` and check console
3. **Runtime Issues**: Check if running as Administrator

---

**Total Time**: ~5-10 minutes  
**Result**: Professional .exe installer ready for deployment! 🎯

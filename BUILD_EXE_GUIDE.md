# 🚀 Complete Guide: Converting Student Kiosk to .exe via GitHub

This guide provides step-by-step instructions to convert your Student Management Kiosk application into a distributable .exe file using GitHub Actions for automated builds.

## 📋 Prerequisites

1. **GitHub Account** - Free account at https://github.com
2. **Git Installed** - Download from https://git-scm.com/
3. **Node.js Installed** - Version 16+ from https://nodejs.org/
4. **Your Application Code** - The student-kiosk desktop app

## 🔧 Step 1: Prepare Your Application

### 1.1 Check package.json Configuration

Navigate to your kiosk directory and ensure your `package.json` has the correct build configuration:

```bash
cd student-kiosk/desktop-app
```

Open `package.json` and verify/add these sections:

```json
{
  "name": "student-kiosk",
  "version": "1.0.0",
  "description": "College Lab Student Kiosk System",
  "main": "main-simple.js",
  "scripts": {
    "start": "electron .",
    "build": "electron-builder",
    "build-win": "electron-builder --win",
    "build-mac": "electron-builder --mac",
    "build-linux": "electron-builder --linux",
    "dist": "npm run build"
  },
  "build": {
    "appId": "com.college.student-kiosk",
    "productName": "Student Kiosk",
    "directories": {
      "output": "dist"
    },
    "files": [
      "**/*",
      "!node_modules/**/*",
      "node_modules/electron/**/*"
    ],
    "win": {
      "target": "nsis",
      "icon": "assets/icon.ico"
    },
    "mac": {
      "target": "dmg",
      "icon": "assets/icon.icns"
    },
    "linux": {
      "target": "AppImage",
      "icon": "assets/icon.png"
    },
    "nsis": {
      "oneClick": false,
      "allowToChangeInstallationDirectory": true,
      "createDesktopShortcut": true,
      "createStartMenuShortcut": true
    }
  },
  "devDependencies": {
    "electron": "^latest",
    "electron-builder": "^latest"
  }
}
```

### 1.2 Install Required Dependencies

```bash
npm install --save-dev electron-builder
```

## 🐙 Step 2: Setup GitHub Repository

### 2.1 Create GitHub Repository

1. Go to https://github.com
2. Click "New Repository" (green button)
3. Repository name: `student-kiosk-app`
4. Description: `College Lab Student Kiosk Management System`
5. Set to **Public** (for free GitHub Actions)
6. ✅ Add README file
7. Click "Create Repository"

### 2.2 Initialize Local Git Repository

In your project directory:

```bash
# Initialize git (if not already done)
git init

# Add GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/student-kiosk-app.git

# Add all files
git add .

# Commit changes
git commit -m "Initial commit: Student Kiosk Application"

# Push to GitHub
git push -u origin main
```

## ⚙️ Step 3: Create GitHub Actions Workflow

### 3.1 Create Workflow Directory

```bash
mkdir -p .github/workflows
```

### 3.2 Create Build Workflow File

Create `.github/workflows/build-exe.yml`:

```yaml
name: Build and Release Executable

on:
  push:
    branches: [ main ]
    tags: [ 'v*' ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ${{ matrix.os }}
    
    strategy:
      matrix:
        os: [windows-latest, ubuntu-latest, macos-latest]
        
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        cache-dependency-path: student-kiosk/desktop-app/package-lock.json
        
    - name: Install dependencies
      run: |
        cd student-kiosk/desktop-app
        npm ci
        
    - name: Build application
      run: |
        cd student-kiosk/desktop-app
        npm run build
        
    - name: Upload Windows artifacts
      if: matrix.os == 'windows-latest'
      uses: actions/upload-artifact@v3
      with:
        name: student-kiosk-windows
        path: student-kiosk/desktop-app/dist/*.exe
        
    - name: Upload macOS artifacts
      if: matrix.os == 'macos-latest'
      uses: actions/upload-artifact@v3
      with:
        name: student-kiosk-macos
        path: student-kiosk/desktop-app/dist/*.dmg
        
    - name: Upload Linux artifacts
      if: matrix.os == 'ubuntu-latest'
      uses: actions/upload-artifact@v3
      with:
        name: student-kiosk-linux
        path: student-kiosk/desktop-app/dist/*.AppImage

  release:
    needs: build
    runs-on: ubuntu-latest
    if: startsWith(github.ref, 'refs/tags/v')
    
    steps:
    - name: Download all artifacts
      uses: actions/download-artifact@v3
      
    - name: Create Release
      uses: softprops/action-gh-release@v1
      with:
        files: |
          student-kiosk-windows/*
          student-kiosk-macos/*
          student-kiosk-linux/*
        draft: false
        prerelease: false
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## 🏗️ Step 4: Build Process

### 4.1 Commit and Push Workflow

```bash
git add .github/workflows/build-exe.yml
git commit -m "Add GitHub Actions build workflow"
git push origin main
```

### 4.2 Trigger Build

The build will automatically start when you push to main. You can also:

1. Go to your GitHub repository
2. Click "Actions" tab
3. Click "Build and Release Executable"
4. Click "Run workflow" button
5. Click "Run workflow" (green button)

### 4.3 Monitor Build Progress

1. In GitHub Actions tab, click on the running workflow
2. Watch the build progress for Windows, macOS, and Linux
3. Build typically takes 5-15 minutes

## 📦 Step 5: Download Built Executables

### 5.1 Download from Actions (Development Builds)

1. Go to "Actions" tab in your repository
2. Click on completed workflow run
3. Scroll down to "Artifacts" section
4. Download:
   - `student-kiosk-windows` (contains .exe file)
   - `student-kiosk-macos` (contains .dmg file)
   - `student-kiosk-linux` (contains .AppImage file)

### 5.2 Create Release (Production Builds)

For official releases with version numbers:

```bash
# Create and push a version tag
git tag v1.0.0
git push origin v1.0.0
```

This will:
1. Trigger the build workflow
2. Create a GitHub Release
3. Attach all executables to the release
4. Make them publicly downloadable

## 🚀 Step 6: Distribution Options

### 6.1 Direct Download Links

After creating a release, you get permanent download links:
- Windows: `https://github.com/YOUR_USERNAME/student-kiosk-app/releases/download/v1.0.0/Student-Kiosk-Setup-1.0.0.exe`
- macOS: `https://github.com/YOUR_USERNAME/student-kiosk-app/releases/download/v1.0.0/Student-Kiosk-1.0.0.dmg`
- Linux: `https://github.com/YOUR_USERNAME/student-kiosk-app/releases/download/v1.0.0/Student-Kiosk-1.0.0.AppImage`

### 6.2 Installation Instructions for End Users

**Windows:**
1. Download the `.exe` file
2. Run as Administrator
3. Follow installation wizard
4. Desktop shortcut will be created

**macOS:**
1. Download the `.dmg` file
2. Double-click to mount
3. Drag app to Applications folder

**Linux:**
1. Download the `.AppImage` file
2. Make executable: `chmod +x Student-Kiosk-*.AppImage`
3. Run: `./Student-Kiosk-*.AppImage`

## 🔧 Step 7: Advanced Configuration

### 7.1 Add Application Icons

Create `assets` folder in your app directory:
```bash
mkdir student-kiosk/desktop-app/assets
```

Add icons:
- `icon.ico` (Windows, 256x256 pixels)
- `icon.icns` (macOS, 512x512 pixels)  
- `icon.png` (Linux, 512x512 pixels)

### 7.2 Code Signing (Optional)

For trusted executables, add code signing certificates to GitHub Secrets:

1. Go to repository Settings > Secrets and variables > Actions
2. Add secrets:
   - `WIN_CSC_LINK` (Windows certificate)
   - `WIN_CSC_KEY_PASSWORD` (Certificate password)
   - `MAC_CSC_LINK` (macOS certificate)
   - `MAC_CSC_KEY_PASSWORD` (Certificate password)

### 7.3 Auto-Update Configuration

Add to `package.json` build section:
```json
"publish": {
  "provider": "github",
  "owner": "YOUR_USERNAME",
  "repo": "student-kiosk-app"
}
```

## 🐛 Troubleshooting

### Build Fails
1. Check GitHub Actions logs
2. Verify `package.json` syntax
3. Ensure all dependencies are listed
4. Check file paths in workflow

### Large File Size
1. Add `.gitignore` for `node_modules`
2. Use `files` array in build config
3. Exclude unnecessary files

### Permission Issues
1. Ensure repository is public for free Actions
2. Check GitHub token permissions
3. Verify workflow file syntax

## 📋 Quick Checklist

- [ ] ✅ `package.json` configured with electron-builder
- [ ] ✅ GitHub repository created
- [ ] ✅ Workflow file added (`.github/workflows/build-exe.yml`)
- [ ] ✅ Code pushed to GitHub
- [ ] ✅ Build workflow runs successfully
- [ ] ✅ Executables downloaded from Actions/Releases
- [ ] ✅ Application tested on target systems

## 🎯 Final Notes

1. **First build** may take longer as GitHub caches dependencies
2. **Free GitHub accounts** get 2000 minutes/month of Actions
3. **Private repositories** require paid GitHub plan for Actions
4. **File size limit** is 2GB per artifact
5. **Retention period** for artifacts is 90 days (configurable)

Your Student Kiosk application is now ready for distribution as a professional executable! 🎉

## 📞 Support

If you encounter issues:
1. Check GitHub Actions logs
2. Review electron-builder documentation
3. Verify Node.js and npm versions
4. Test local build first: `npm run build`

---
**Created:** $(date)  
**Version:** 1.0  
**For:** Student Management Kiosk System

# Session CSV Storage System

## Overview
Automatic CSV file generation and storage system for all student login/logout sessions. Session data is saved in real-time and can be downloaded from the admin dashboard.

---

## ✅ Features Implemented

### 1. **Automatic Session CSV Storage**
- Every student login/logout is automatically saved to CSV files
- Files are organized by Lab ID and date (e.g., `CC1_2025-11-05.csv`)
- Session data updates when students logout (duration, status)

### 2. **Three Storage Locations**

#### **📁 Session CSVs** (`/server/session-csvs/`)
- Stores individual session records as they happen
- **Format**: `LABID_YYYY-MM-DD.csv`
- **Created**: Automatically on student login
- **Updated**: When student logs out
- **Retention**: Permanent (manual deletion only)

#### **📋 Manual Reports** (`/server/reports/manual/`)
- Generated when admin clicks "Generate Report Now"
- Contains all sessions for current day
- **Retention**: Automatically deleted after 1 day
- **Purpose**: Quick daily reports without cluttering storage

#### **⏰ Automatic Reports** (`/server/reports/automatic/`)
- Generated at scheduled times (configurable in dashboard)
- **Retention**: Permanent
- **Purpose**: Official records saved at specific times

### 3. **Admin Dashboard Integration**
- New section: "📁 Session CSV Files"
- Shows all session CSV files with metadata (size, date)
- One-click download for any file
- Auto-refresh on page load

---

## 📊 CSV File Structure

Each CSV file contains these columns:

```csv
Session ID,Student Name,Student ID,Computer Name,Lab ID,System Number,Login Time,Logout Time,Duration (seconds),Status
```

### Example Row:
```csv
"672a45b789c123456","John Doe","STU123","PC-01","CC1","System-1","05/11/2025, 12:00:00 pm","05/11/2025, 1:30:00 pm","5400","completed"
```

---

## 🔄 How It Works

### On Student Login:
1. Student logs in via kiosk
2. Server creates new session in database
3. **Session automatically saved to CSV** → `session-csvs/LABID_DATE.csv`
4. If file doesn't exist, creates new file with headers
5. If file exists, appends new row

### On Student Logout:
1. Student logs out
2. Server updates session with logout time and duration
3. **CSV file updated** with complete session data
4. Row is replaced with updated information

### Manual Report Generation:
1. Admin clicks "Generate Report Now"
2. Server generates CSV with today's sessions
3. **Saved to manual reports folder** → `reports/manual/LABID-sessions-DATE.csv`
4. Downloaded to admin's browser
5. **Automatic cleanup**: Files older than 24 hours are deleted

### Automatic Report Generation:
1. Cron job runs at scheduled times (e.g., 1:00 PM, 6:00 PM)
2. Server generates CSV with today's sessions
3. **Saved to automatic reports folder** → `reports/automatic/LABID-sessions-DATE.csv`
4. Broadcast to admin dashboard for download
5. **Files kept permanently**

---

## 🛠️ API Endpoints

### List Session CSV Files
```
GET /api/session-csvs
```
**Response:**
```json
{
  "success": true,
  "files": [
    {
      "filename": "CC1_2025-11-05.csv",
      "size": 2048,
      "created": "2025-11-05T06:30:00.000Z",
      "modified": "2025-11-05T12:45:00.000Z"
    }
  ]
}
```

### Download Session CSV
```
GET /api/session-csvs/:filename
```
**Example:** `GET /api/session-csvs/CC1_2025-11-05.csv`

### List Manual Reports
```
GET /api/manual-reports
```

### Download Manual Report
```
GET /api/manual-reports/:filename
```

---

## 📂 Directory Structure

```
central-admin/server/
├── session-csvs/           # Real-time session storage
│   ├── CC1_2025-11-05.csv
│   ├── CC1_2025-11-04.csv
│   └── LAB2_2025-11-05.csv
├── reports/
│   ├── manual/             # Temporary (1-day retention)
│   │   └── CC1-sessions-2025-11-05.csv
│   └── automatic/          # Permanent storage
│       ├── CC1-sessions-2025-11-05.csv
│       └── CC1-sessions-2025-11-04.csv
```

---

## 🎯 Usage Guide

### For Admins:

#### Viewing Session Files:
1. Open admin dashboard
2. Scroll to "📁 Session CSV Files" section
3. Click "🔄 Refresh File List"
4. See all available session CSV files

#### Downloading Files:
1. Find the file you want (organized by lab and date)
2. Click "📥 Download" button
3. File downloads to your browser's download folder

#### Manual Reports:
1. Scroll to "📅 Automatic Report Schedule" section
2. Click "📊 Generate Report Now (Test)"
3. Report generated and downloaded immediately
4. Also saved to `reports/manual/` folder
5. **Note**: Will be auto-deleted after 24 hours

#### Automatic Reports:
1. Configure schedules in "📅 Automatic Report Schedule"
2. Set times (e.g., 13:00 and 18:00)
3. Enable schedules
4. Click "💾 Save Schedule"
5. Reports generate automatically at scheduled times
6. Saved permanently in `reports/automatic/`

---

## 🔧 Technical Details

### Server-Side Functions:

#### `saveSessionToCSV(session)`
- Called on student login
- Creates/appends to session CSV file
- Handles file creation with headers

#### `updateSessionInCSV(session)`
- Called on student logout
- Finds existing session row in CSV
- Updates with logout time and duration

#### `cleanupOldManualReports()`
- Runs every hour
- Deletes manual reports older than 24 hours
- Keeps automatic reports and session CSVs intact

### File Naming Convention:

**Session CSVs**: `{LABID}_{YYYY-MM-DD}.csv`
- Example: `CC1_2025-11-05.csv`

**Reports**: `{LABID}-sessions-{YYYY-MM-DD}.csv`
- Example: `CC1-sessions-2025-11-05.csv`

---

## 🚨 Important Notes

1. **Session CSVs are NOT deleted automatically**
   - Must be deleted manually if needed
   - Contains real-time data for all sessions

2. **Manual reports are temporary**
   - Auto-deleted after 1 day
   - Use for quick checks only
   - For permanent records, use automatic scheduling

3. **Automatic reports are permanent**
   - Stored indefinitely
   - Use for official record keeping

4. **CSV files are updated in real-time**
   - Login creates row immediately
   - Logout updates existing row
   - No database queries needed to view data

5. **Files are organized by date and lab**
   - Easy to find specific day's data
   - Separate files per lab
   - One file per day per lab

---

## 📋 Testing Checklist

- [x] Student login creates CSV file
- [x] Session appears in CSV with "Active" status
- [x] Student logout updates CSV with duration
- [x] Multiple students in same lab/day go to same file
- [x] Admin dashboard shows CSV files
- [x] Download button works
- [x] Manual reports save to correct folder
- [x] Manual reports auto-delete after 1 day
- [x] Automatic reports save to correct folder
- [x] Automatic reports work at scheduled times
- [x] Server restarts don't lose CSV data

---

## 🔮 Future Enhancements

Potential additions:
- Email CSV files to admin automatically
- Compress old CSV files (ZIP)
- Search/filter CSV files by date range
- Export to Excel format
- Dashboard analytics from CSV data
- Bulk download multiple files

---

## 📞 Support

If you encounter issues:
1. Check server console for error messages
2. Verify directories exist: `session-csvs/`, `reports/manual/`, `reports/automatic/`
3. Check file permissions
4. Review CSV file format
5. Test with single student login/logout first

---

## ✅ Summary

**Automatic**: Every session is saved to CSV automatically
**Manual Reports**: Generate on-demand, deleted after 1 day
**Automatic Reports**: Generated at scheduled times, kept forever
**Download**: Easy one-click download from admin dashboard
**Organized**: Files organized by lab ID and date
**Real-time**: CSV updates immediately on login/logout

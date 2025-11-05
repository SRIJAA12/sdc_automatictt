# Quick Testing Guide - Session CSV System

## ✅ What Was Implemented

1. **Automatic CSV Storage**: Every student login/logout automatically saved to CSV files
2. **Three Storage Folders**:
   - `session-csvs/` - Real-time session storage (permanent)
   - `reports/manual/` - Manual reports (1-day retention)
   - `reports/automatic/` - Scheduled reports (permanent)
3. **Admin Dashboard Section**: New "Session CSV Files" section with download buttons
4. **Auto-cleanup**: Old manual reports deleted after 24 hours

---

## 🧪 How to Test

### Test 1: Automatic Session CSV Creation

1. **Start the server**:
   ```bash
   cd central-admin/server
   node app.js
   ```

2. **Login a student** via kiosk

3. **Check server console** - should see:
   ```
   💾 Session saved to CSV: CC1_2025-11-05.csv
   ```

4. **Check folder**: `central-admin/server/session-csvs/`
   - You should see: `CC1_2025-11-05.csv` (or today's date)

5. **Open the CSV** - should contain one row with:
   - Student name
   - Login time
   - Status: "Active"
   - Logout time: "Active"

6. **Logout the student**

7. **Check server console** - should see:
   ```
   💾 Session updated in CSV: CC1_2025-11-05.csv
   ```

8. **Open CSV again** - same row now shows:
   - Logout time
   - Duration in seconds
   - Status: "completed"

✅ **PASS**: Session automatically saved and updated in CSV

---

### Test 2: Admin Dashboard Download

1. **Open admin dashboard**: `http://localhost:7401/admin-dashboard.html`

2. **Scroll down** to "📁 Session CSV Files" section

3. **Click** "🔄 Refresh File List"

4. **Should see**: List of CSV files with:
   - Filename
   - Size
   - Modified date
   - Download button

5. **Click** "📥 Download" on any file

6. **Check downloads folder** - CSV file should download

✅ **PASS**: Can view and download session CSVs from dashboard

---

### Test 3: Manual Report (1-Day Retention)

1. **In admin dashboard**, scroll to "📅 Automatic Report Schedule"

2. **Click** "📊 Generate Report Now (Test)"

3. **File downloads** to browser

4. **Check server folder**: `central-admin/server/reports/manual/`
   - Should contain: `CC1-sessions-2025-11-05.csv`

5. **Wait 24 hours** OR manually change file modification time to 25 hours ago

6. **Server auto-cleanup** runs every hour

7. **Check folder** - old manual report should be deleted

✅ **PASS**: Manual reports saved and auto-deleted after 1 day

---

### Test 4: Automatic Reports (Permanent)

1. **In admin dashboard**, set Schedule 1 time to 2 minutes from now

2. **Enable** Schedule 1

3. **Click** "💾 Save Schedule"

4. **Wait for scheduled time**

5. **Check server console** - should see:
   ```
   💾 Automatic report 1 saved: .../reports/automatic/CC1-sessions-2025-11-05.csv
   📢 Broadcasting scheduled report 1 for CC1
   ```

6. **Check folder**: `central-admin/server/reports/automatic/`
   - Report should be saved

7. **Dashboard** should show download notification

✅ **PASS**: Automatic reports work and saved permanently

---

### Test 5: Multiple Students Same Day

1. **Login student 1** from kiosk

2. **Login student 2** from different kiosk

3. **Check CSV file** - should contain 2 rows

4. **Logout student 1**

5. **Check CSV** - student 1 row updated, student 2 still "Active"

6. **Logout student 2**

7. **Check CSV** - both rows complete

✅ **PASS**: Multiple sessions in same CSV file work correctly

---

## 📁 Expected Directory Structure After Tests

```
central-admin/server/
├── session-csvs/
│   └── CC1_2025-11-05.csv        ✅ Permanent
├── reports/
│   ├── manual/
│   │   └── (files auto-deleted after 1 day)
│   └── automatic/
│       └── CC1-sessions-2025-11-05.csv  ✅ Permanent
```

---

## 🐛 Troubleshooting

### "No session CSV files found"
- Ensure at least one student has logged in
- Check `session-csvs/` folder exists
- Check server console for errors

### "Error loading session CSV files"
- Verify server is running
- Check network connection
- Check server URL in dashboard

### CSV file not updating on logout
- Check server console for errors
- Verify session ID matches
- Check file permissions

### Manual reports not being deleted
- Wait for hourly cleanup to run
- Check file modification time
- Verify folder path is correct

---

## 📊 CSV Column Reference

| Column | Description | Example |
|--------|-------------|---------|
| Session ID | Unique MongoDB ID | `672a45b789c123456` |
| Student Name | Full name | `John Doe` |
| Student ID | Student identifier | `STU123` |
| Computer Name | PC hostname | `PC-01` |
| Lab ID | Lab identifier | `CC1` |
| System Number | System number | `System-1` |
| Login Time | IST format | `05/11/2025, 12:00:00 pm` |
| Logout Time | IST format or "Active" | `05/11/2025, 1:30:00 pm` |
| Duration (seconds) | Total seconds | `5400` |
| Status | active/completed | `completed` |

---

## ✅ Success Criteria

- ✅ CSV created automatically on login
- ✅ CSV updated automatically on logout
- ✅ Multiple sessions in same file work
- ✅ Admin can view files in dashboard
- ✅ Admin can download any file
- ✅ Manual reports auto-delete after 1 day
- ✅ Automatic reports saved permanently
- ✅ Server restart doesn't break anything

---

## 🚀 Next Steps

The system is ready to use! 

**For production:**
1. Test with actual students
2. Monitor CSV file sizes
3. Set up backup for CSV folders
4. Configure automatic report schedules
5. Train admins on download process

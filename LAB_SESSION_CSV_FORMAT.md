# Lab Session CSV Report Format

## Overview
When you **end a lab session**, a complete CSV report is automatically generated with:
- Session metadata (subject, faculty, time periods, etc.)
- All student records who participated
- Detailed timing and duration information

---

## CSV File Structure

### Filename Format
```
LabSession_{SubjectName}_{Date}_{Time}.csv
```

**Example:**
```
LabSession_Data-Structures_2025-11-05_10-30-AM.csv
```

---

### File Contents

#### Section 1: Session Metadata

```csv
"LAB SESSION REPORT"
"="
"Subject:","Data Structures"
"Faculty:","Dr. John Smith"
"Year:","2"
"Department:","Computer Science"
"Section:","A"
"Time Periods:","2 periods"
"Expected Duration:","90 minutes"
"Actual Duration:","95 minutes"
"Start Time:","05/11/2025, 10:30:00 am"
"End Time:","05/11/2025, 12:05:00 pm"
"Status:","completed"
"Total Students:","25"
"="

```

#### Section 2: Student Records

```csv
"STUDENT RECORDS"
"Student Name","Student ID","System Number","Login Time","Logout Time","Duration (seconds)","Duration (minutes)","Status"
"John Doe","STU001","System-1","05/11/2025, 10:30:15 am","05/11/2025, 12:05:20 pm","5705","95","completed"
"Jane Smith","STU002","System-2","05/11/2025, 10:31:00 am","05/11/2025, 12:05:20 pm","5660","94","completed"
"Bob Johnson","STU003","System-3","05/11/2025, 10:32:30 am","05/11/2025, 12:05:20 pm","5570","92","completed"
```

---

## When is it Generated?

The lab session CSV is **automatically created** when:
1. You click **"End Lab Session"** button in admin dashboard
2. All active student sessions are completed
3. Report is saved to: `reports/manual/`

---

## Example Full CSV

```csv
"LAB SESSION REPORT"
"="
"Subject:","Object Oriented Programming"
"Faculty:","Prof. Sarah Williams"
"Year:","2"
"Department:","Computer Science"
"Section:","B"
"Time Periods:","3 periods"
"Expected Duration:","135 minutes"
"Actual Duration:","140 minutes"
"Start Time:","05/11/2025, 2:00:00 pm"
"End Time:","05/11/2025, 4:20:00 pm"
"Status:","completed"
"Total Students:","30"
"="

"STUDENT RECORDS"
"Student Name","Student ID","System Number","Login Time","Logout Time","Duration (seconds)","Duration (minutes)","Status"
"Alice Brown","CS2023001","System-1","05/11/2025, 2:00:30 pm","05/11/2025, 4:20:00 pm","8370","139","completed"
"Bob Wilson","CS2023002","System-2","05/11/2025, 2:01:00 pm","05/11/2025, 4:20:00 pm","8340","139","completed"
"Carol Davis","CS2023003","System-3","05/11/2025, 2:02:15 pm","05/11/2025, 4:20:00 pm","8265","137","completed"
"David Miller","CS2023004","System-4","05/11/2025, 2:00:45 pm","05/11/2025, 4:20:00 pm","8355","139","completed"
"Emma Taylor","CS2023005","System-5","05/11/2025, 2:03:00 pm","05/11/2025, 4:20:00 pm","8220","137","completed"
```

---

## Data Fields Explained

### Session Metadata Fields

| Field | Description | Example |
|-------|-------------|---------|
| Subject | Course name | "Data Structures" |
| Faculty | Teacher's name | "Dr. John Smith" |
| Year | Academic year | "2" |
| Department | Department name | "Computer Science" |
| Section | Class section | "A" |
| Time Periods | Number of periods | "2 periods" |
| Expected Duration | Planned duration | "90 minutes" |
| Actual Duration | Real duration | "95 minutes" |
| Start Time | Session start | "05/11/2025, 10:30:00 am" |
| End Time | Session end | "05/11/2025, 12:05:00 pm" |
| Status | Session status | "completed" |
| Total Students | Number of students | "25" |

### Student Record Fields

| Field | Description | Example |
|-------|-------------|---------|
| Student Name | Full name | "John Doe" |
| Student ID | Unique ID | "STU001" |
| System Number | Computer ID | "System-1" |
| Login Time | Login timestamp | "05/11/2025, 10:30:15 am" |
| Logout Time | Logout timestamp | "05/11/2025, 12:05:20 pm" |
| Duration (seconds) | Total seconds | "5705" |
| Duration (minutes) | Total minutes | "95" |
| Status | Record status | "completed" |

---

## How to Use

### Step 1: Start a Lab Session
1. Open admin dashboard
2. Click "Start Lab Session"
3. Enter subject, faculty, periods, etc.
4. Session begins

### Step 2: Students Login
- Students login via kiosk
- They appear in admin dashboard
- Session records are tracked

### Step 3: End the Session
1. Click "End Lab Session"
2. **CSV report is automatically generated**
3. Saved to `reports/manual/` folder

### Step 4: Download Report
1. Scroll to "📊 Lab Session Reports" section
2. See your report listed
3. Click "📥 Download Report"

---

## File Location

### Server Storage
```
central-admin/server/reports/manual/
└── LabSession_SubjectName_Date_Time.csv
```

### Retention Policy
- **Manual reports**: Deleted after 1 day
- **To keep permanently**: Download immediately after generation

---

## Import to Excel

The CSV can be opened in:
- Microsoft Excel
- Google Sheets
- LibreOffice Calc
- Any spreadsheet software

**Note:** The metadata section will appear as rows at the top, followed by the student records table.

---

## Advantages

1. **Complete Information**: Everything about the session in one file
2. **Organized**: Metadata + student records in structured format
3. **Easy to Read**: Opens in any spreadsheet software
4. **Timestamped**: Filename includes date and time
5. **Automatic**: Generated without manual effort
6. **Archived**: Can be kept as official records

---

## Example Use Cases

1. **Attendance Records**: Official proof of student attendance
2. **Duration Tracking**: Verify actual vs expected class time
3. **Faculty Reports**: Submit to department/administration
4. **Student Records**: Individual session participation history
5. **Audit Trail**: Complete session documentation

---

## Troubleshooting

### Report not generating?
- Ensure lab session was properly ended
- Check server console for errors
- Verify `reports/manual/` folder exists

### Empty student records?
- Students must login during the session
- Check if students are added to lab session

### Cannot download?
- Refresh the reports list
- Check browser download settings
- Verify server is running

---

## Summary

✅ **One CSV per lab session**
✅ **Includes all metadata**
✅ **All student records included**
✅ **Auto-generated on session end**
✅ **Easy to download from dashboard**
✅ **1-day retention (download immediately)**

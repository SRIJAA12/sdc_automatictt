# Timetable Auto-Session Quick Guide

## What It Does
- **Automatically starts lab sessions** at scheduled time from timetable
- **Automatically ends sessions** at scheduled end time
- **Generates CSV reports** with all metadata and student records
- **Works with existing features** - manual reports, automatic reports all continue working

## CSV Format
```csv
Session Date,Start Time,End Time,Faculty,Subject,Lab ID,Year,Department,Section,Periods,Duration,Max Students,Remarks
2025-11-10,09:00,10:40,Dr. Smith,Data Structures,CC1,2,Computer Science,A,2,100,60,Regular class
```

## How to Use
1. **Create timetable CSV** with your schedule
2. **Upload via dashboard** (endpoint: `/api/upload-timetable`)
3. **Sessions auto-start/end** based on schedule
4. **Download reports** from "Lab Session Reports" section

## API Endpoints
- `POST /api/upload-timetable` - Upload timetable CSV
- `GET /api/timetable` - View uploaded entries
- `GET /api/timetable-template` - Download template

## How It Works
**Every minute** server checks for scheduled sessions:
- **At start time**: Creates lab session, notifies admins
- **Students login**: Added to session as usual
- **At end time**: Ends session, generates CSV report

## Generated Reports
Filename: `LabSession_SubjectName_2025-11-10_09-00-AM.csv`

Contains:
- Session metadata (subject, faculty, time, duration)
- All student records (name, login/logout times, duration)

**Retention**: 1 day - Download immediately!

## Testing
1. Use `sample_timetable.csv`
2. Set start time to 2 minutes from now
3. Upload timetable
4. Wait - session starts automatically
5. Check "Lab Session Reports" for CSV

## Screen Mirroring Fix
Timetable ensures lab session starts BEFORE students login - fixes WebRTC connection issues!

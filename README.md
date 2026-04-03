# 📦 BackupYearOrganizer

Automatically organize your backup files into yearly folders — fast, safe, and with detailed reporting.

---
<br>
## 🚀 Overview

**BackupYearOrganizer** is a PowerShell script that scans a directory, detects backup files based on year patterns in their filenames (e.g. `_2023`), and automatically moves them into corresponding yearly folders.

It is designed especially for database backup directories but works with **any file type**.

---
<br>
## ✨ Features

- 📁 Creates missing folders from **2020 up to last year (dynamic)**
- 🔍 Scans all files regardless of extension
- 🗂 Moves files based on `_YYYY` pattern in filename
- 📊 Shows real-time **progress bar**
- 🧠 Smart error handling (retry system for network paths)
- ⚠️ Skips missing or locked files safely
- 🧹 Optional deletion of empty folders
- 📝 Generates **summary or detailed reports**
- 🎨 Stylish CLI interface with animations

---
<br>
## 📌 Example

Before:<br><br>

/backups<br>
├── db_FULL_2022_0101.bak<br>
├── db_FULL_2023_0201.bak<br>
├── db_FULL_2024_0301.bak<br>
<br><br>
After:<br><br>

/backups<br>
├── 2022/<br>
│ └── db_FULL_2022_0101.bak<br>
├── 2023/<br>
│ └── db_FULL_2023_0201.bak<br>
├── 2024/<br>
│ └── db_FULL_2024_0301.bak<br>
<br>

---
<br><br>
## 🛠 Requirements

- Windows Server / Windows OS
- PowerShell 5.1 or higher

---
<br><br>
## ▶️ Usage
<br><br>
### Method 1 — Drag & Drop

Drag a folder onto the script:

organise.ps1

---
<br><br>
### Method 2 — Run manually

```powershell
powershell -ExecutionPolicy Bypass -File .\organise.ps1
```

You will be prompted to enter the target directory.  

---
<br><br>
### Method 3 — Context Menu (Optional)

You can integrate the script into:

Right-click menu
"Send To" menu

(See setup instructions in repo or ask for registry config)
<br><br><br>
## ⚙️ How It Works<br><br>

Determines year range dynamically:<br>
└── 2020 → (Current Year - 1)<br>
Creates missing folders<br>
Scans files:<br>
└── *_2023*<br>
└── *_2024*<br>
Moves files to matching year folders<br>
Displays progress<br>
Generates report<br>

<br><br>
## 📊 Reporting<br><br>

At the end of execution, you can choose:<br><br>

Summary Report<br>
└── Total moved files<br>
└── Skipped files<br>
└── Failed files<br>
└── Empty folders status<br>
└── Execution time<br><br>

Detailed Report<br>
Includes everything plus:<br>
└── Each file movement<br>
└── Errors and retry results<br>
└── Folder operations<br><br>

Example file name:<br>
backup_20260403_1423.txt<br><br>

## ⚠️ Notes<br><br>

Works with network drives (W:, etc.)<br>
Includes retry logic for:<br>
└── Temporary network issues<br>
└── Locked files<br>
Files may be skipped if:<br>
└── They no longer exist<br>
└── They are still being written (e.g. active backups)<br><br>

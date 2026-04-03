# 📦 BackupYearOrganizer

Automatically organize your backup files into yearly folders — fast, safe, and with detailed reporting.

---

## 🚀 Overview

**BackupYearOrganizer** is a PowerShell script that scans a directory, detects backup files based on year patterns in their filenames (e.g. `_2023`), and automatically moves them into corresponding yearly folders.

It is designed especially for database backup directories but works with **any file type**.

---

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

## 📌 Example

Before:

/backups
├── db_FULL_2022_0101.bak
├── db_FULL_2023_0201.bak
├── db_FULL_2024_0301.bak

After:

/backups
├── 2022/
│ └── db_FULL_2022_0101.bak
├── 2023/
│ └── db_FULL_2023_0201.bak
├── 2024/
│ └── db_FULL_2024_0301.bak


---

## 🛠 Requirements

- Windows Server / Windows OS
- PowerShell 5.1 or higher

---

## ▶️ Usage

### Method 1 — Drag & Drop

Drag a folder onto the script:

duzenle.ps1


---

### Method 2 — Run manually

```powershell
powershell -ExecutionPolicy Bypass -File .\duzenle.ps1
```

You will be prompted to enter the target directory.

### Method 3 — Context Menu (Optional)

You can integrate the script into:

Right-click menu
"Send To" menu

(See setup instructions in repo or ask for registry config)

⚙️ How It Works

Determines year range dynamically:
└── 2020 → (Current Year - 1)
Creates missing folders
Scans files:
└── *_2023*
└── *_2024*
Moves files to matching year folders
Displays progress
Generates report

📊 Reporting

At the end of execution, you can choose:

Summary Report
└── Total moved files
└── Skipped files
└── Failed files
└── Empty folders status
└── Execution time

Detailed Report
Includes everything plus:
└── Each file movement
└── Errors and retry results
└── Folder operations

Example file name:

backup_20260403_1423.txt

⚠️ Notes

Works with network drives (W:, etc.)
Includes retry logic for:
└── Temporary network issues
└── Locked files
Files may be skipped if:
└── They no longer exist
└── They are still being written (e.g. active backups)

💡 Best Practice

If you are working with live backup folders:

👉 Avoid moving files that are still being created
👉 (Future version may include "skip recent files" option)

🧑‍💻 Author

Murat UZUN
📧 muratuzun79@gmail.com

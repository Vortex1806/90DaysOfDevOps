# Day 20 – Log Analyzer and Report Generator

## Overview

On Day 20 of the DevOps challenge, I built a **Bash-based log analyzer** that processes server log files and generates a structured summary report.

System logs often contain large amounts of data. Manually searching through them for important events like **errors or critical failures** can be inefficient. This script automates that process by scanning the log file, extracting key events, summarizing them, and generating a daily report.

The script also archives the generated report after analysis.

---

# Script: `log_analyzer.sh`

```bash
#!/bin/bash

set -euo pipefail

if [ $# -lt 1 ]; then
        echo "Usage ./log_analyzer.sh /path/log_file.txt"
        exit 1
fi

log_file=$1

if [ ! -f $log_file ]; then
        echo "Log file does not exist"
        exit 1
fi

date_var=$(date +%Y-%m-%d)
log_report=log_report_$date_var.txt

echo "DATE OF ANALYSIS: $date_var">$log_report
echo "LOG FILE NAME: $log_file">>$log_report
echo "TOTAL LINES PROCESSSED: " $(grep -c "" $log_file)>>$log_report

echo "Total no of errors occurred: " $(grep -E "ERROR|Failed" "$log_file" | wc -l) >>$log_report
echo ""

echo "----------------CRITICAL ISSUES-----------------">>$log_report

grep CRITICAL "$log_file" -n>>$log_report
echo ""

echo "--------------Top 5 Error Messages-----------------">>$log_report

grep ERROR "$log_file" | awk '{print $4, $5, $6}' | sort | uniq -c | sort -nr | head -5>>$log_report
echo ""

if [ ! -d archive ]; then
        mkdir archive
fi

mv $log_report ./archive/$log_report

echo "Log report $log_report moved to ./archive/$log_report"
```

---

# Example Output

Example generated report:

```
DATE OF ANALYSIS: 2026-03-08
LOG FILE NAME: nginx_logs.log
TOTAL LINES PROCESSED: 5321

Total no of errors occurred: 129

----------------CRITICAL ISSUES-----------------
84: 2026-03-08 10:15:23 CRITICAL Disk space below threshold
217: 2026-03-08 14:32:01 CRITICAL Database connection lost

--------------Top 5 Error Messages-----------------
45 Connection timed out
32 File not found
28 Permission denied
15 Disk I/O error
9  Out of memory
```

---

# Commands and Tools Used

The script makes use of several common Linux utilities:

| Tool   | Purpose                                                |
| ------ | ------------------------------------------------------ |
| `grep` | Search for patterns such as ERROR, Failed, or CRITICAL |
| `awk`  | Extract specific columns from log entries              |
| `sort` | Organize output for counting and ranking               |
| `uniq` | Count duplicate error messages                         |
| `wc`   | Count occurrences                                      |
| `head` | Display top 5 results                                  |
| `date` | Generate timestamp for report name                     |
| `mv`   | Move generated reports to archive directory            |

---

# Problems I Faced

While building this script, I ran into several practical issues:

### 1. Understanding `set -euo pipefail`

Initially I did not fully understand how this makes scripts safer by stopping execution when:

- a command fails
- an undefined variable is used
- a pipeline fails

### 2. `grep` command hanging

At one point the script froze because I used:

```
grep -c $log_file
```

`grep` expected a pattern and started waiting for input from STDIN.

### 3. Counting total lines

I tried different ways to count lines before learning how `grep -c ""` works for counting lines.

### 4. Working with pipelines

Understanding how to chain commands like:

```
grep | sort | uniq | sort | head
```

took some experimentation.

### 5. Extracting only the error message

I needed to isolate the error message part of each log entry before counting duplicates.

### 6. Sorting results correctly

Learning how `sort -nr` works for numeric reverse sorting was important to display the most frequent errors first.

### 7. Directory path mistakes

While moving files to the archive folder I initially used an incorrect path (`/archive`) instead of a relative path (`./archive`).

### 8. Copying directories vs files

Earlier I encountered confusion with `cp -r` copying entire folders instead of only their contents.

---

# Key Learnings

### 1. Bash pipelines are extremely powerful

Combining small Linux utilities like `grep`, `awk`, `sort`, and `uniq` can solve complex log analysis tasks.

### 2. Defensive Bash scripting is important

Using `set -euo pipefail` helps prevent silent failures in scripts.

### 3. Log analysis is a core DevOps skill

Real-world systems generate huge logs, and being able to filter, analyze, and summarize them quickly is critical for troubleshooting.

---

# Conclusion

This project demonstrated how simple Bash scripts can automate log analysis tasks that would otherwise require manual inspection.

By combining multiple Linux command-line tools, the script can quickly:

- scan logs
- detect errors and critical issues
- summarize frequent failures
- generate a daily report
- archive results

This exercise helped strengthen my understanding of **Bash scripting, pipelines, and log processing**, which are essential skills for DevOps engineers.

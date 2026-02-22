# **Day 07: Linux File System Hierarchy & Scenario-Based Practice**

## **Part 1: Linux File System Hierarchy**

### **1\. Symbolic Links (Links to /usr)**

| Directory | Description                                      | "I would use this when..."                                   |
| :-------- | :----------------------------------------------- | :----------------------------------------------------------- |
| /sbin     | System binaries for administrative commands.     | ...I need to run admin-only tools like fdisk or iptables.    |
| /bin      | Essential user binaries (commands like ls, cat). | ...I need to use standard terminal commands.                 |
| /lib      | Shared libraries and kernel modules.             | ...the system needs to load drivers or library dependencies. |

### **2\. Important System Directories**

| Directory | Description                                         | "I would use this when..."                                       |
| :-------- | :-------------------------------------------------- | :--------------------------------------------------------------- |
| /boot     | Files needed for booting the system.                | ...I am troubleshooting kernel boot issues.                      |
| /usr      | Most user-installed applications and libraries.     | ...I want to see where software like python or git is installed. |
| /var      | Stores logs, caches, and frequently changing files. | ...**I need to check /var/log for application errors.**          |
| /etc      | Stores system-wide configuration files.             | ...I need to change the server's hostname or network settings.   |

### **3\. User & Application-Specific Directories**

| Directory | Description                                        | "I would use this when..."                                          |
| :-------- | :------------------------------------------------- | :------------------------------------------------------------------ |
| /home     | Default location for user home directories.        | ...I need to store my personal project files.                       |
| /opt      | Used for installing optional third-party software. | ...I install standalone apps like Google Chrome or custom agents.   |
| /srv      | Holds data for services like web servers.          | ...I am hosting a specific site's data (less common in containers). |
| /root     | Home directory for the **root** user.              | ...I am logged in as the superuser and need my private config.      |

### **4\. Temporary & Volatile Directories**

| Directory | Description                                  | "I would use this when..."                                              |
| :-------- | :------------------------------------------- | :---------------------------------------------------------------------- |
| /tmp      | Temporary files (cleared on reboot).         | ...I need a scratchpad for a script's output that I don't need to keep. |
| /run      | Holds runtime data for active processes.     | ...I need to check a process ID (PID) file for a running service.       |
| /proc     | Virtual filesystem for process/system info.  | ...I want to see hardware info like cat /proc/cpuinfo.                  |
| /sys      | Virtual filesystem for hardware/kernel info. | ...I am debugging kernel-level hardware interactions.                   |
| /dev      | Contains device files (e.g., /dev/null).     | ...I want to discard output by redirecting it to /dev/null.             |

### **5\. Mount Points**

| Directory | Description                                     | "I would use this when..."                                          |
| :-------- | :---------------------------------------------- | :------------------------------------------------------------------ |
| /mnt      | Temporary mount point for external filesystems. | ...I manually mount a temporary network drive.                      |
| /media    | Mount point for removable media (USB/CDs).      | ...I plug in a USB drive and want to access the files.              |
| /data     | Mounted volume from the host system.            | ...I need to access files shared between my Windows host and Linux. |

## **Part 2: Hands-on Command Practice**

### **Finding Large Logs**

\# Find the largest log files in /var/log  
du \-sh /var/log/\* 2\>/dev/null | sort \-h | tail \-5

### **Checking Configs & Home**

\# Check the system hostname configuration  
cat /etc/hostname

\# Check current home directory contents including hidden files  
ls \-la \~

## **Part 3: Scenario-Based Practice**

### **Scenario 1: Service Not Starting (myapp)**

**Step 1:** systemctl status myapp

- **Why:** To see if the service is failed, active, or stopped, and read the immediate error message.

**Step 2:** journalctl \-u myapp \-n 50

- **Why:** To dive deeper into the historical logs to find the exact root cause of the crash.

**Step 3:** systemctl is-enabled myapp

- **Why:** To verify if the service was configured to start automatically on boot.

**Step 4:** systemctl restart myapp

- **Why:** To try starting it again after fixing potential issues found in the logs.

### **Scenario 2: High CPU Usage**

**Step 1:** top

- **Why:** To see a live, real-time view of all processes and identify which one is consuming the most CPU.

**Step 2:** htop

- **Why:** To get a more user-friendly, color-coded interactive view (if installed) to easily trace the resource hog.

**Step 3:** ps aux \--sort=-%cpu | head \-10

- **Why:** To get a static snapshot of the top 10 CPU-consuming processes, which is useful for logging the incident.

**Step 4:** kill \-9 \<PID\>

- **Why:** To forcefully stop the runaway or "zombie" process identified in the previous steps (use with caution).

### **Scenario 3: Finding Service Logs (docker)**

**Step 1:** systemctl status docker

- **Why:** To check if the service is currently running and view the most recent brief log output natively.

**Step 2:** journalctl \-u docker \-n 50

- **Why:** To see the most recent 50 lines of logs for the Docker engine specifically.

**Step 3:** journalctl \-u docker \-f

- **Why:** To watch the Docker logs live while actively troubleshooting a container start issue in another terminal.

**Step 4:** journalctl \-u docker \--since "1 hour ago"

- **Why:** To filter logs for a specific timeframe to match exactly when the developer reported the issue.

### **Scenario 4: File Permissions Issue (backup.sh)**

**Step 1:** ls \-l /home/user/backup.sh

- **Why:** To check current permissions and confirm that the 'x' (execute) permission is missing (e.g., \-rw-r--r--).

**Step 2:** chmod \+x /home/user/backup.sh

- **Why:** To grant execution rights so the script can actually be run by the user.

**Step 3:** ls \-l /home/user/backup.sh

- **Why:** To verify that the execute permission was successfully added before trying to run it (should now be \-rwxr-xr-x).

**Step 4:** /home/user/backup.sh or ./backup.sh

- **Why:** To execute the script and confirm the "Permission denied" error is completely resolved.

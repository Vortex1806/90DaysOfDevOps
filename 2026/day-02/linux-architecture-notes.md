# **Linux Architecture Notes**

## **1️ What is Linux?**

- Linux is an open-source operating system created by **Linus Torvalds** in 1991\.

- It powers most servers, cloud systems, containers, and DevOps environments.

- Examples of Linux distributions: Ubuntu, CentOS, Debian.

---

# **2️ Core Architecture of Linux**

Linux architecture can be understood in layers:

### **1\. Hardware (Innermost Layer)**

- CPU, RAM, Disk, Network cards, etc.

- The physical components of the machine.

### **2\. Kernel**

- Core of the Linux OS.

- Talks directly to hardware.

- Responsibilities:
  - Process management

  - Memory management

  - Device drivers

  - File systems

  - Networking

👉 The kernel runs in **kernel space** (privileged mode).

### **3\. User Space**

- Where applications and users operate.

- Includes:
  - Shell

  - System libraries

  - Applications (nginx, docker, etc.)

👉 User space programs cannot directly access hardware — they request services from the kernel.

### **4\. Shell**

- Interface between user and kernel.

- Examples: bash, zsh.

- Converts commands into system calls.

Example:

`ls`  
`cd`  
`pwd`

The terminal is just an application that runs a shell.

---

# **3️Important Linux Directories**

- `/bin` → Essential user commands (ls, cp, mv)

- `/sbin` → System/admin commands (mount, reboot)

- `/etc` → Configuration files

- `/var` → Logs and variable data

- `/home` → User directories

---

# **4️ How Linux Boots**

When you power on a Linux machine:

### **1\. BIOS / UEFI**

- BIOS (Basic Input Output System)

- Initializes hardware.

- Looks for bootable device.

### **2\. Bootloader (GRUB)**

- GRUB \= Grand Unified Bootloader

- Loads the Linux kernel into memory.

### **3\. Kernel Loads**

- Kernel initializes:
  - Memory

  - CPU

  - Drivers

  - Mounts root filesystem

### **4\. init / systemd Starts**

- First process started by kernel.

- PID \= 1

- On modern systems → **systemd**

After this, services and login prompt appear.

---

# **5️ What is systemd?**

- systemd is the init system.

- It manages services and system startup.

- It is the first userspace process (PID 1).

Why it matters in DevOps:

- Controls services (nginx, docker, ssh)

- Manages boot targets

- Handles logs (journalctl)

- Restarts crashed services

### **Common systemctl Commands**

`systemctl start nginx`  
`systemctl stop nginx`  
`systemctl restart nginx`  
`systemctl status nginx`  
`systemctl enable nginx`

---

# **6️How Processes Are Created**

Every running program is a process.

### **Process Creation Flow:**

1. Parent process calls `fork()`

2. Child process is created

3. Child may call `exec()` to load a new program

Example:

- You open terminal

- Shell runs

- You type `ls`

- Shell creates a new process for `ls`

---

# **7️ Process States (Very Important)**

| State               | Meaning                                          |
| ------------------- | ------------------------------------------------ |
| Running (R)         | Actively using CPU                               |
| Sleeping (S)        | Waiting for event (most common state)            |
| Stopped (T)         | Paused by signal                                 |
| Zombie (Z)          | Finished but parent hasn’t collected exit status |
| Uninterruptible (D) | Waiting for I/O (disk/network)                   |

🔹 Zombie process \= dead process not cleaned up by parent.

---

# **8️Process Monitoring Commands**

### **1\. ps**

Snapshot of processes.

`ps`  
`ps aux`  
`ps ax`

- `a` → All users

- `u` → Detailed format (CPU, memory, owner)

- `x` → Includes processes without terminal

### **2\. top**

- Real-time process monitor.

- Shows CPU and memory usage live.

### **3\. htop**

- Improved interactive version of top.

- Better UI, easier to kill processes.

Difference:

- `ps` → Static snapshot

- `top` → Live monitoring

- `htop` → Interactive live monitoring

---

# **9️What is a Daemon?**

- Background service process.

- Usually ends with `d`.
  - sshd

  - httpd

  - systemd

Runs continuously and waits for requests.

---

# **5 Commands Used Daily (DevOps)**

`ls        # list files`  
`cd        # change directory`  
`pwd       # show current directory`  
`ps aux    # check processes`  
`systemctl status <service>`

Other important:

`mkdir`  
`touch`  
`cp`  
`mv`  
`rm`  
`cat`  
`ping`  
`ip a   (instead of ipconfig)`  
`man`

---

# **Final Mental Model**

Hardware  
 ↓  
 Kernel  
 ↓  
 systemd (PID 1\)  
 ↓  
 Services \+ Shell  
 ↓  
 Applications

Everything you troubleshoot as a DevOps engineer connects back to:

- Processes

- Services

- Logs

- Kernel behavior

Master this layer → debugging becomes logical instead of guesswork.

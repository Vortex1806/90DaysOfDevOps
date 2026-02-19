**Day 04 – Linux Practice: Processes and Services**

Today’s focus was hands-on Linux fundamentals: processes, services, monitoring, and logs.

---

# 1️⃣ Process Checks

## Viewing / Identifying Processes

### 1. List running processes
```bash
ps
```
Shows processes running in the current shell.

---

### 2. List all processes (detailed view)
```bash
ps aux
```
- `a` → all users  
- `u` → user-oriented format  
- `x` → processes not attached to terminal  

This shows:
- USER  
- PID  
- %CPU  
- %MEM  
- START time  
- COMMAND  

---

### 3. Add line numbers
```bash
ps aux | nl
```

---

### 4. Count total processes
```bash
ps aux | wc -l
```

---

### 5. Alternative process list
```bash
ps -ef
```
Gives similar output to `ps aux`  
But does **NOT show CPU and memory percentage usage**.

---

## Killing Processes

### Normal kill
```bash
kill <pid>
```

### Force kill
```bash
kill -9 <pid>
```

### Thread dump (used in debugging, especially Java apps)
```bash
kill -3 <pid>
```

### Temporarily stop process
```bash
kill -STOP <pid>
```

### Continue stopped process
```bash
kill -CONT <pid>
```

---

## Process Priority

```bash
renice -n <priority> -p <pid>
```

Priority range:
- **-19 → Highest priority**
- 20 → Lowest priority

👉 **Negative number = higher priority**

---

## What I Understood Today

- A **process** is a program in execution (Python app, Java app, etc.)
- A **service** is a special process that automatically starts when the system boots.
- Many web servers and background systems run as services so they restart automatically after reboot.

---

# 2️⃣ Service Checks

## List all services
```bash
systemctl list-units --type=service
```

---

## Start a service
```bash
systemctl start docker
```

---

## Stop a service
```bash
systemctl stop docker
```

Example:
```bash
systemctl stop cron.service
systemctl start cron.service
```

---

## Inspect a Service

```bash
systemctl status cron.service
```

From this I observed:
- **systemd starts the service first during boot**
- It shows whether service is active or inactive
- It shows PID of main process
- It shows logs summary at bottom

---

# 3️⃣ Log Checks

## View logs of specific service
```bash
journalctl -u cron.service
```

I saw many logs here. It shows:
- Service start events
- Errors if any
- Restart attempts
- Systemd initialization entries

---

## View last 50 lines of a log file
```bash
tail -n 50 <logfile>
```

`tail` command shows the last lines of a file.
It is useful for:
- Watching logs
- Debugging errors
- Seeing recent activity

If logs are stuck, tail helps see latest updates.

---

# 4️⃣ Process Monitoring

## Real-time Monitoring

```bash
top
```
Gives real-time process view.

```bash
htop
```
Better and more readable version of top.

⚠️ **Important: We cannot use `top` inside scripts because it runs interactively in real time.**

---

## Memory Monitoring

```bash
free -m
free -h
```
Shows available and used memory.

```bash
vmstat
```
Reports system performance (memory, swap, CPU).

---

## CPU Monitoring

```bash
nproc
```
Shows number of CPU cores.

CPU tools:
- top
- htop
- nproc

---

## Disk Monitoring

```bash
df -h
```
Lists all file systems and disk usage.

```bash
du -sh *
```
Shows folder size and helps detect large log files.

Useful for finding heavy directories.

---

# 5️⃣ Mini Troubleshooting Flow

1. Check if service is running:
   ```bash
   systemctl status cron.service
   ```

2. If inactive, start it:
   ```bash
   systemctl start cron.service
   ```

3. If error, check logs:
   ```bash
   journalctl -u cron.service
   ```

4. If system slow, check:
   - `top` for CPU
   - `free -m` for memory
   - `df -h` for disk

---

# Summary of Learning Today

- **Process = program in execution**
- **Service = special background process that starts automatically on boot**
- Learned how to kill, pause, resume and change priority of processes
- Learned how to inspect services using systemctl
- Learned how to read logs using journalctl and tail
- Learned monitoring basics for CPU, memory and disk

---

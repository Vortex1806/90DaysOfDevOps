# Linux Troubleshooting Runbook – Day 05

## Target Service / Process

**nginx**

---

## Environment Basics

### Command

```
uname -a
```

### Output (Snippet)

Linux ip-172-31-47-13 6.14.0-1018-aws x86_64 GNU/Linux

### Observation

System is running Ubuntu 24.04 LTS on AWS kernel (x86_64 architecture).

---

### Command

```
lsb_release -a
```

### Output (Snippet)

Ubuntu 24.04.3 LTS (Noble Numbat)

### Observation

Confirmed OS version and codename. Environment validated before troubleshooting.

---

## Filesystem Sanity Check

### Commands

```
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo
```

### Output (Snippet)

hosts-copy created successfully

### Observation

Filesystem is writable. No permission or disk write issues detected.

---

## Service Status

### Command

```
systemctl status nginx
```

### Key Observations

- Service is **active (running)**
- Main PID: 6294
- Worker PIDs: 6296, 6297
- Memory usage: ~2.4MB
- No startup errors

Conclusion: Service started successfully and is stable.

---

## CPU & Memory Snapshot

### Command

```
ps -o pid,pcpu,pmem,comm -p 6294
```

### Output (Snippet)

%CPU: 0.0
%MEM: <1%

### Observation

nginx consuming negligible CPU and memory. No spike detected.

---

### Command

```
free -h
```

### Output (Snippet)

Total Memory: 914Mi
Used: 416Mi
Available: 497Mi
Swap: 0B

### Observation

System has sufficient available memory. No swap configured. No memory pressure.

---

## Disk & IO Snapshot

### Command

```
df -h
```

### Output (Snippet)

Root disk usage: 40%

### Observation

Disk usage within safe limits (<80%). No immediate storage risk.

---

### Command

```
sudo du -sh /var/log
```

### Output (Snippet)

45M /var/log

### Observation

Log directory size is small. No excessive log growth.

---

## Network Snapshot

### Command

```
ss -tulpn | grep nginx
```

### Observation

No direct output returned (likely due to permissions or filtering). Service confirmed active via curl.

---

### Command

```
curl -I http://localhost
```

### Output (Snippet)

HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)

### Observation

nginx responding correctly on localhost. HTTP status 200 confirms healthy web service.

---

## Logs Reviewed

### Command

```
journalctl -u nginx -n 50
```

### Observation

Only startup logs present. No error entries.

---

### Command

```
tail -n 50 /var/log/nginx/error.log
```

### Output (Snippet)

using inherited sockets

### Observation

No critical errors detected. Normal notice-level log entry.

---

## Quick Findings

- nginx service is running normally
- CPU and memory usage minimal
- Disk usage healthy (40%)
- Logs clean
- HTTP endpoint returning 200 OK
- No resource bottlenecks detected

System state: Healthy

---

## If This Worsens (Next Steps)

1. Restart service:

   ```
   sudo systemctl restart nginx
   ```

2. Increase log verbosity in nginx config for deeper debugging.

3. Check firewall rules:

   ```
   sudo ufw status
   ```

4. Monitor real-time logs:

   ```
   sudo journalctl -u nginx -f
   ```

5. Attach system call trace if high CPU occurs:
   ```
   sudo strace -p <nginx-pid>
   ```

---

## Conclusion

This drill confirms nginx is stable with no performance, disk, memory, or network issues. A structured evidence-first approach was followed before any restart or modi

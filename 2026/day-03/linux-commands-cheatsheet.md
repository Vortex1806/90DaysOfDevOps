# Linux Commands Cheat Sheet

Practical command toolkit for daily DevOps troubleshooting.

---

# 📁 File System Commands

## Navigation & Inspection

pwd                 # Show current directory  
ls -l               # List files with details  
ls -la              # List all files (including hidden)  
cd /path            # Change directory  
tree                # Show directory structure (if installed)  

## File & Directory Management

mkdir dir_name      # Create directory  
touch file.txt      # Create empty file  
cp src dest         # Copy file  
mv src dest         # Move or rename file  
rm file.txt         # Remove file  
rm -r dir/          # Remove directory recursively  

## File Viewing & Searching

cat file.txt        # Display file content  
less file.txt       # View file with scroll  
head -n 10 file     # First 10 lines  
tail -n 10 file     # Last 10 lines  
tail -f app.log     # Follow live log file  
grep "error" file   # Search text in file  
find / -name file   # Find file by name  

---

# ⚙️ Process Management Commands

## Viewing Processes

ps                  # Snapshot of current shell processes  
ps aux              # Detailed list of all processes  
top                 # Real-time process monitoring  
htop                # Interactive process monitor  

## Managing Processes

kill PID            # Kill process by PID  
kill -9 PID         # Force kill process  
pkill nginx         # Kill process by name  
nice -n 10 cmd      # Start process with lower priority  
renice 5 PID        # Change priority of running process  

## System & Service Management

systemctl status nginx    # Check service status  
systemctl start nginx     # Start service  
systemctl stop nginx      # Stop service  
systemctl restart nginx   # Restart service  
systemctl enable nginx    # Enable at boot  

---

# 🌐 Networking & Troubleshooting Commands

## Basic Network Checks

ip addr             # Show IP addresses  
ip route            # Show routing table  
ping google.com     # Test connectivity  

## DNS & HTTP Testing

dig google.com      # DNS lookup  
nslookup google.com # DNS query  
curl http://site    # Test HTTP response  
curl -I http://site # Show HTTP headers only  

## Port & Connection Debugging

ss -tuln            # Show listening ports  
netstat -tuln       # Show open ports (older systems)  
lsof -i :80         # Check which process uses port 80  

---

# 📊 System Monitoring & Logs

 df -h               # Disk usage  
 du -sh folder/      # Folder size  
 free -h             # Memory usage  
 uptime              # System load & uptime  
 whoami              # Current user  

## Logs

journalctl          # View systemd logs  
journalctl -u nginx # Logs for specific service  
dmesg               # Kernel logs  

---

# 🔐 Permissions & Ownership

chmod 755 file      # Change file permissions  
chown user file     # Change file owner  
id                  # Show user/group IDs  

---

# 🚀 Quick Production Debug Flow

1. systemctl status <service>  
2. journalctl -u <service>  
3. ps aux | grep <service>  
4. ss -tuln  
5. curl localhost:<port>  
6. tail -f <logfile>  
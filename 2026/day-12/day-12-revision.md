# Day 12 – Revision Complete (Days 01–11)

## ✅ Revision Status
All topics from Day 01 to Day 11 reviewed and re-practiced.

This session focused on reinforcement, clarity, and speed.

---

# 🔁 What I Revisited

## 1️⃣ Mindset & Direction
- Rechecked original goal: strong Linux fundamentals for DevOps.
- Confirmed direction is correct.
- Noticed improved terminal confidence and faster command recall.

---

## 2️⃣ Processes & Services
Re-ran:

```bash
ps aux
systemctl status ssh
journalctl -u ssh -n 20
```

Observations:
- Understood PID, USER, CPU/MEM columns clearly.
- Service status shows active state, logs, and main PID.
- Logs are critical for debugging service failures.

---

## 3️⃣ File Operations Practice
Practiced:

```bash
echo "test" > file.txt
echo "append" >> file.txt
chmod 640 file.txt
ls -l file.txt
cp file.txt copy.txt
mkdir testdir
```

Reinforced understanding of:
- Overwrite vs append
- Numeric permissions
- Directory execute requirement

---

## 4️⃣ Permissions & Ownership
Practiced:

```bash
chmod 755 script.sh
sudo chown tokyo file.txt
sudo chgrp developers file.txt
ls -l
```

Reinforced:
- Permission structure (rwx = 4,2,1)
- Owner vs Group difference
- Importance of verifying with `ls -l`

---

## 5️⃣ User & Group Sanity Check

```bash
sudo useradd -m tempuser
sudo groupadd tempgroup
sudo usermod -aG tempgroup tempuser
id tempuser
```

Confirmed understanding of:
- Supplementary groups
- User verification using `id`

---

# 🧠 Mini Self-Check

## 1. Three Commands That Save Me Time
- `ls -l` → Immediate visibility of permissions and ownership.
- `systemctl status` → Quick service health check.
- `chmod (numeric)` → Fast and precise permission control.

---

## 2. How I Check Service Health

```bash
systemctl status <service>
ps aux | grep <service>
journalctl -u <service> -n 20
```

---

## 3. Safe Ownership & Permission Change Example

```bash
sudo chown -R appuser:appgroup /opt/app
```

Steps followed:
- Ensure user exists
- Ensure group exists
- Verify after change using `ls -l`

---

## 4. Focus for Next 3 Days
- Faster troubleshooting mindset
- Stronger comfort with journalctl flags
- Automatic recall of chmod numeric values

---

# 🚀 Key Takeaways

- Linux fundamentals are permission-driven.
- Ownership defines control and collaboration.
- Services are diagnosed using systemctl + journalctl.
- Confidence comes from repetition.

---
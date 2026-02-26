# Day 11 Challenge

## Files & Directories Created

### Files
- devops-file.txt
- team-notes.txt
- project-config.yaml
- heist-project/vault/gold.txt
- heist-project/plans/strategy.conf
- bank-heist/access-codes.txt
- bank-heist/blueprints.pdf
- bank-heist/escape-plan.txt

### Directories
- app-logs/
- heist-project/
- heist-project/vault/
- heist-project/plans/
- bank-heist/

---

## Task 1: Understanding Ownership

### Command Used
```bash
ls -l
```

Format:
```
-rw-r--r-- 1 owner group size date filename
```

- First column → Permissions
- Second column → Number of hard links
- Third column → Owner (user)
- Fourth column → Group

### Difference Between Owner and Group
- **Owner** → The specific user who controls the file.
- **Group** → A collection of users who share defined access permissions to the file.

<img width="648" height="124" alt="Screenshot 2026-02-26 at 10 00 06 PM" src="https://github.com/user-attachments/assets/ef04fef2-f1d2-4783-984b-ed76156fd0f3" />

---

## Task 2: Basic chown Operations

### Create File
```bash
touch devops-file.txt
ls -l devops-file.txt
```

### Change Owner to tokyo
```bash
sudo chown tokyo devops-file.txt
ls -l devops-file.txt
```

### Change Owner to berlin
```bash
sudo chown berlin devops-file.txt
ls -l devops-file.txt
```

<img width="648" height="160" alt="Screenshot 2026-02-26 at 10 00 22 PM" src="https://github.com/user-attachments/assets/4cd167ca-cba8-4efd-b4a7-0d1cf16a585c" />

---

## Task 3: Basic chgrp Operations

### Create File
```bash
touch team-notes.txt
ls -l team-notes.txt
```

### Create Group
```bash
sudo groupadd heist-team
```

### Change Group
```bash
sudo chgrp heist-team team-notes.txt
ls -l team-notes.txt
```

<img width="648" height="239" alt="Screenshot 2026-02-26 at 10 02 05 PM" src="https://github.com/user-attachments/assets/1b570056-6599-479e-aab9-a9a36cf5b571" />

---

## Task 4: Combined Owner & Group Change

### Create File
```bash
touch project-config.yaml
```

### Change Owner and Group Together
```bash
sudo chown professor:heist-team project-config.yaml
ls -l project-config.yaml
```
<img width="648" height="222" alt="Screenshot 2026-02-26 at 10 03 35 PM" src="https://github.com/user-attachments/assets/f65b1fe3-65a8-42d6-90b6-76d2b28cc51d" />

### Create Directory
```bash
mkdir app-logs
```

### Change Directory Owner and Group
```bash
sudo chown berlin:heist-team app-logs
ls -ld app-logs
```
<img width="648" height="415" alt="Screenshot 2026-02-26 at 10 05 40 PM" src="https://github.com/user-attachments/assets/32352706-4988-4d32-a896-da11eaccb254" />

---

## Task 5: Recursive Ownership Change

### Create Directory Structure
```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans

touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf
```

### Create Group
```bash
sudo groupadd planners
```
<img width="648" height="112" alt="Screenshot 2026-02-26 at 10 08 15 PM" src="https://github.com/user-attachments/assets/b6b7b4d2-9fde-4915-b9d0-25d0cedcfebc" />

### Recursive Ownership Change
```bash
sudo chown -R professor:planners heist-project/
```

### Verify
```bash
ls -lR heist-project/
```

<img width="648" height="261" alt="Screenshot 2026-02-26 at 10 08 29 PM" src="https://github.com/user-attachments/assets/34173ff8-f0b5-4ed0-bdf5-697dd66e2586" />

---

## Task 6: Practice Challenge

### Create Users (if not already created)
```bash
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m nairobi
```

### Create Groups
```bash
sudo groupadd vault-team
sudo groupadd tech-team
```

### Create Directory and Files
```bash
mkdir bank-heist

touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt
```

### Set Ownership
```bash
sudo chown tokyo:vault-team bank-heist/access-codes.txt
sudo chown berlin:tech-team bank-heist/blueprints.pdf
sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```

### Verify
```bash
ls -l bank-heist/
```
<img width="648" height="261" alt="Screenshot 2026-02-26 at 10 10 57 PM" src="https://github.com/user-attachments/assets/98212fb6-a22d-41de-857a-4d9fe51dcbb7" />

---

## Ownership Changes Summary

- devops-file.txt → initial-user:initial-group → berlin:initial-group
- team-notes.txt → initial-user:initial-group → initial-user:heist-team
- project-config.yaml → initial-user:initial-group → professor:heist-team
- app-logs/ → initial-user:initial-group → berlin:heist-team
- heist-project/ → recursive change → professor:planners
- bank-heist/access-codes.txt → tokyo:vault-team
- bank-heist/blueprints.pdf → berlin:tech-team
- bank-heist/escape-plan.txt → nairobi:vault-team

---

## Commands Used

- ls -l
- ls -ld
- ls -lR
- touch
- mkdir -p
- useradd -m
- groupadd
- chown
- chown -R
- chgrp

---

## What I Learned

1. Ownership determines which user controls a file, while group ownership enables controlled shared access.
2. `chown` can modify both owner and group in a single command using owner:group syntax.
3. Recursive ownership changes are powerful and must be used carefully to avoid unintended permission changes.

---

## Why This Matters for DevOps

Proper ownership management is critical for:

- Application deployments
- Shared team directories
- Log file management
- Container file permissions
- CI/CD artifact handling

---


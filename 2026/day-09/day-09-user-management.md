# Day 09 Challenge

## Users & Groups Created

### Users Created
- tokyo
- berlin
- professor

### Groups Created
- developers
- admins
---

## Task 1: Create Users

### Commands Used
```bash
sudo useradd -m tokyo
sudo passwd tokyo

sudo useradd -m berlin
sudo passwd berlin

sudo useradd -m professor
sudo passwd professor
```

### Verification
```bash
cat /etc/passwd
ls -l /home/
```

<img width="1440" height="678" alt="Screenshot 2026-02-24 at 11 46 32 PM" src="https://github.com/user-attachments/assets/61dc4765-e5f5-4aac-9f5f-1af4e2b60d1d" />

---

## Task 2: Create Groups

### Commands Used
```bash
sudo groupadd developers
sudo groupadd admins
```

### Verification
```bash
cat /etc/group
```

<img width="1440" height="168" alt="Screenshot 2026-02-24 at 11 50 01 PM" src="https://github.com/user-attachments/assets/95db4a38-6b20-4c70-91aa-1930a3bf39b4" />

---

## Task 3: Assign Users to Groups

### Commands Used
```bash
sudo usermod -aG developers tokyo

sudo usermod -aG developers berlin
sudo usermod -aG admins berlin

sudo usermod -aG admins professor
```

### Verification
```bash
groups tokyo
groups berlin
groups professor
```
<img width="1440" height="148" alt="Screenshot 2026-02-24 at 11 51 55 PM" src="https://github.com/user-attachments/assets/c44ec2a8-9454-4dcb-9f3f-f62cedce442c" />

<img width="1440" height="148" alt="Screenshot 2026-02-24 at 11 52 23 PM" src="https://github.com/user-attachments/assets/8364a328-21b2-4ca8-8161-38fc0077ef0f" />

---

## Task 4: Shared Directory Setup

### Create Directory
```bash
mkdir /opt/dev-project
```

### Set Group Ownership
```bash
sudo chgrp developers /opt/dev-project
```

### Set Permissions
```bash
sudo chmod 775 /opt/dev-project
```

### Verify Permissions
```bash
ls -ld /opt/dev-project
```
<img width="1440" height="411" alt="Screenshot 2026-02-24 at 11 56 46 PM" src="https://github.com/user-attachments/assets/f2d9c6c1-2821-4903-b29a-2edcc2ea4702" />

### Test File Creation
```bash
sudo -u tokyo touch /opt/dev-project/tokyo-file.txt
sudo -u berlin touch /opt/dev-project/berlin-file.txt

ls -l /opt/dev-project
```
<img width="1440" height="411" alt="Screenshot 2026-02-25 at 12 00 30 AM" src="https://github.com/user-attachments/assets/a9eb8bd5-a44a-4588-afc5-c27899eeef89" />


---

## Task 5: Team Workspace Setup

### Create User & Group
```bash
sudo useradd -m nairobi
sudo passwd nairobi

sudo groupadd project-team
```

### Add Users to Group
```bash
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
```

### Create Workspace Directory
```bash
sudo mkdir -p /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace
```

### Verify
```bash
ls -ld /opt/team-workspace

groups nairobi
groups tokyo
```

### Test File Creation
```bash
sudo -u nairobi touch /opt/team-workspace/nairobi-file.txt
ls -l /opt/team-workspace
```

---

## Group Assignments Summary

- tokyo → developers, project-team
- berlin → developers, admins
- professor → admins
- nairobi → project-team

---

## Directories Created

- /opt/dev-project → Group: developers → Permissions: 775
- /opt/team-workspace → Group: project-team → Permissions: 775

---

## Commands Used (Complete List)

- useradd -m
- passwd
- groupadd
- usermod -aG
- chgrp
- chmod
- mkdir -p
- groups
- ls -l
- ls -ld
- sudo -u
- cat /etc/passwd
- cat /etc/group

---

## What I Learned

1. Users must be explicitly added to supplementary groups using `-aG`, otherwise previous group memberships get overwritten.
2. Directory group ownership and permissions control collaborative access.
3. Testing with `sudo -u username` is an effective way to validate permission setups.

---


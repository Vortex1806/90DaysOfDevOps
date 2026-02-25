# Day 10 Challenge

## Files Created

- devops.txt
- notes.txt
- script.sh
- project/ (directory)

---

## Task 1: Create Files

### Commands Used
```bash
touch devops.txt

echo "These are my DevOps notes" > notes.txt

vim script.sh
```

### Content inside script.sh
```bash
echo "Hello DevOps"
```

### Verify Initial Permissions
```bash
ls -l devops.txt notes.txt script.sh
```
<img width="583" height="148" alt="Screenshot 2026-02-25 at 10 16 08 PM" src="https://github.com/user-attachments/assets/5183d302-2244-4692-805d-e18341a07759" />



---

## Task 2: Read Files

### Read notes.txt
```bash
cat notes.txt
```

### View script.sh in read-only mode
```bash
vim -R script.sh
```

### First 5 lines of /etc/passwd
```bash
head -n 5 /etc/passwd
```

### Last 5 lines of /etc/passwd
```bash
tail -n 5 /etc/passwd
```
<img width="556" height="286" alt="Screenshot 2026-02-25 at 10 17 28 PM" src="https://github.com/user-attachments/assets/fe2a6a1b-8246-44d2-a5f8-388f558bccbe" />

---

## Task 3: Understand Permissions

Permission format: rwxrwxrwx

- First 3 → Owner
- Next 3 → Group
- Last 3 → Others

r = 4
w = 2
x = 1

### Check Permissions
```bash
ls -l devops.txt notes.txt script.sh
```
<img width="538" height="98" alt="Screenshot 2026-02-25 at 10 18 07 PM" src="https://github.com/user-attachments/assets/a2a52feb-6386-4d25-a020-40d77597b050" />

### Example Explanation (Initial State)
- devops.txt → -rw-r--r-- → Owner: read/write, Group: read, Others: read
- notes.txt → -rw-r--r-- → Owner: read/write, Group: read, Others: read
- script.sh → -rw-r--r-- → Owner: read/write, Group: read, Others: read

---

## Task 4: Modify Permissions

### 1. Make script.sh Executable
```bash
chmod +x script.sh
ls -l script.sh
```

### Run Script
```bash
./script.sh
```
<img width="538" height="98" alt="Screenshot 2026-02-25 at 10 19 04 PM" src="https://github.com/user-attachments/assets/84604336-aa58-4587-82c4-ffb740437372" />


---

### 2. Set devops.txt to Read-Only
```bash
chmod a-w devops.txt
ls -l devops.txt
```

Expected permission example:
-r--r--r--
<img width="538" height="121" alt="Screenshot 2026-02-25 at 10 19 48 PM" src="https://github.com/user-attachments/assets/f337b50d-b62e-4049-a96b-a300793767ce" />

---

### 3. Set notes.txt to 640
```bash
chmod 640 notes.txt
ls -l notes.txt
```

Meaning:
- Owner → rw (6)
- Group → r (4)
- Others → none (0)
<img width="538" height="121" alt="Screenshot 2026-02-25 at 10 20 32 PM" src="https://github.com/user-attachments/assets/4465b911-56c2-49d7-b2fa-519505d47102" />


---

### 4. Create project Directory with 755
```bash
mkdir project
chmod 755 project
ls -ld project
```

Meaning:
- Owner → rwx (7)
- Group → r-x (5)
- Others → r-x (5)

<img width="538" height="234" alt="Screenshot 2026-02-25 at 10 21 18 PM" src="https://github.com/user-attachments/assets/ccb058d8-3e57-45b8-b1ec-a1fc0d1c1543" />

---

## Task 5: Test Permissions

### 1. Try Writing to Read-Only File
```bash
echo "Trying to write" >> devops.txt
```

Expected Error:
Permission denied

<img width="538" height="73" alt="Screenshot 2026-02-25 at 10 22 27 PM" src="https://github.com/user-attachments/assets/63231bc6-5745-4ce8-93dc-89ae34b5edd8" />

---

### 2. Try Executing Without Execute Permission

Remove execute permission:
```bash
chmod -x script.sh
./script.sh
```

Expected Error:
Permission denied

<img width="538" height="73" alt="Screenshot 2026-02-25 at 10 22 52 PM" src="https://github.com/user-attachments/assets/943285f3-f72f-4a5e-a2a9-5ab10ccc33f2" />

---

## Permission Changes Summary

| File/Directory | Before | After |
|---------------|--------|--------|
| script.sh | -rw-r--r-- | -rwxr-xr-x (after +x) |
| devops.txt | -rw-r--r-- | -r--r--r-- |
| notes.txt | -rw-r--r-- | -rw-r----- |
| project/ | default | drwxr-xr-x |

---

## Commands Used

- touch
- echo >
- vim
- cat
- head -n
- tail -n
- ls -l
- ls -ld
- chmod +x
- chmod -x
- chmod a-w
- chmod 640
- chmod 755
- mkdir

---

## What I Learned

1. File permissions directly control who can read, write, or execute files in Linux.
2. Numeric (octal) permissions are faster and clearer for setting exact access levels.
3. Execute permission is mandatory to run scripts, even if you can read them.

---


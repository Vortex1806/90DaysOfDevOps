# Day 13 – Linux Volume Management (LVM)

## 🎯 Objective
Learn how to manage storage flexibly using LVM by:

- Creating a Physical Volume (PV)
- Creating a Volume Group (VG)
- Creating a Logical Volume (LV)
- Formatting and mounting the volume
- Extending the Logical Volume

---

# 🖥️ Task 1: Check Current Storage

## Commands Used

```bash
lsblk
```

```bash
df -h
```

<img width="1296" height="704" alt="image" src="https://github.com/user-attachments/assets/16b6c0d5-29c8-4c10-842d-c7bc9f4b97dc" />

pvs
vgs
lvs

---

# 🧱 Task 2: Create Physical Volume (PV)

## Commands Used

```bash
pvcreate /dev/nvme1n1
pvs
```

## Output

```bash
Physical volume "/dev/nvme1n1" successfully created.
```

```bash
pvs
  PV           VG Fmt  Attr PSize  PFree
  /dev/nvme1n1    lvm2 ---  20.00g 20.00g
```
<img width="468" height="124" alt="Screenshot 2026-03-02 at 10 38 47 PM" src="https://github.com/user-attachments/assets/b506a30e-53cf-4d03-aaab-57d56745834d" />


---

# 📦 Task 3: Create Volume Group (VG)

## Commands Used

```bash
vgcreate shubhvg /dev/nvme1n1
vgs
```

## Output

```bash
Volume group "shubhvg" successfully created
```

```bash
vgs
  VG      #PV #LV #SN Attr   VSize   VFree  
  shubhvg   1   0   0 wz--n- <20.00g <20.00g
```
<img width="464" height="81" alt="Screenshot 2026-03-02 at 10 39 03 PM" src="https://github.com/user-attachments/assets/61421738-13ce-450b-8770-7f78a0636954" />

---

# 📁 Task 4: Create Logical Volume (LV)

## Commands Used

```bash
lvcreate -L 500M -n shubhlv1 shubhvg
lvs
lvdisplay
```

## Output

```bash
Logical volume "shubhlv1" created.
```

```bash
lvs
  LV       VG      Attr       LSize   
  shubhlv1 shubhvg -wi-a----- 500.00m
```

```bash
lvdisplay
  LV Path                /dev/shubhvg/shubhlv1
  LV Name                shubhlv1
  VG Name                shubhvg
  LV Size                500.00 MiB
```

<img width="464" height="322" alt="Screenshot 2026-03-02 at 10 39 33 PM" src="https://github.com/user-attachments/assets/47635a33-8472-4338-bae5-16d35493f857" />

---

# 💾 Task 5: Format and Mount the Logical Volume

⚠️ Note: mkfs must be executed outside the LVM interactive shell.

## Commands Used

```bash
mkfs -t ext4 /dev/shubhvg/shubhlv1
mkdir /mnt/app-data
mount /dev/shubhvg/shubhlv1 /mnt/app-data
df -h /mnt/app-data
```

## Output

```bash
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 128000 4k blocks and 128000 inodes
```

> 📸 Insert screenshot of mkfs output here

```bash
df -h /mnt/app-data
Filesystem                    Size  Used Avail Use% Mounted on
/dev/mapper/shubhvg-shubhlv1  452M   24K  417M   1% /mnt/app-data
```

<img width="572" height="482" alt="Screenshot 2026-03-02 at 10 40 04 PM" src="https://github.com/user-attachments/assets/80fc6167-978e-442e-8198-2b13731c5b70" />

---

# 📈 Task 6: Extend the Logical Volume

## Step 1: Extend the LV

```bash
lvextend -L +500M /dev/shubhvg/shubhlv1
```

Output:

```bash
Size of logical volume shubhvg/shubhlv1 changed from 500.00 MiB to 1000.00 MiB.
Logical volume shubhvg/shubhlv1 successfully resized.
```

<img width="799" height="290" alt="Screenshot 2026-03-02 at 10 40 28 PM" src="https://github.com/user-attachments/assets/647e62d3-0e75-4e33-b9fc-cdcbb97623d4" />

---

## Step 2: Resize the Filesystem

```bash
resize2fs /dev/shubhvg/shubhlv1
```

Output:

```bash
The filesystem on /dev/shubhvg/shubhlv1 is now 256000 (4k) blocks long.
```

---

## Step 3: Verify New Size

```bash
df -h /mnt/app-data
```

Output:

```bash
Filesystem                    Size  Used Avail Use% Mounted on
/dev/mapper/shubhvg-shubhlv1  921M   24K  866M   1% /mnt/app-data
```

---

# 📚 What I Learned

1. LVM provides flexible storage management without repartitioning disks.
2. Logical Volumes can be extended dynamically without downtime (online resize).
3. Filesystem resizing (resize2fs) is required after extending an LV to utilize new space.

---

# ✅ Summary

- Created PV on `/dev/nvme1n1`
- Created VG `shubhvg`
- Created LV `shubhlv1`
- Mounted at `/mnt/app-data`
- Extended volume from 500MB → 1GB successfully

--


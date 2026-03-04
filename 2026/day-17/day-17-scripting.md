# Day 17 – Shell Scripting: Loops, Arguments & Error Handling

## Task 1: For Loop

### 1️⃣ for_loop.sh
```bash
#!/bin/bash

for fruit in apple mango banana
 do
    echo $fruit
done
```

**Output:**
```
apple
mango
banana
```

---

### 2️⃣ count.sh
```bash
#!/bin/bash

for i in {1..10}
do
    echo $i
done
```

**Output:**
```
1
2
3
4
5
6
7
8
9
10
```

---

## Task 2: While Loop

### 3️⃣ countdown.sh
```bash
#!/bin/bash

i=10
while [ $i -ne 0 ]
do
    echo $i
    i=$((i-1))
done

echo "done!"
```

**Output:**
```
10
9
8
7
6
5
4
3
2
1
done!
```

---

## Task 3: Command-Line Arguments

### 4️⃣ greet.sh
```bash
#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Usage: ./greet.sh <NAME>"
    exit 1
fi

echo "Hello, $1!"
```

**Example Run:**
```
./greet.sh Shubh
Hello, Shubh!
```

---

### 5️⃣ args_demo.sh
```bash
#!/bin/bash

echo "Total no of args: $#"
echo "Arguments are: $@"
echo "Script name: $0"
```

**Example Run:**
```
./args_demo.sh a b c
Total no of args: 3
Arguments are: a b c
Script name: ./args_demo.sh
```

---

## Task 4: Install Packages via Script

### 6️⃣ install_packages.sh
```bash
#!/bin/bash

if [ "$EUID" -ne 0 ]
then
    echo "Please run as root"
    exit 1
fi

apt-get update -y

for package in nginx curl wget
do
    if dpkg -s $package &>/dev/null
    then
        echo "Package $package already installed"
    else
        apt-get install $package -y
        echo "$package installed......."
    fi
done
```

**What it does:**
- Checks if the script is run as root
- Updates package list
- Loops through nginx, curl, wget
- Checks installation using `dpkg -s`
- Installs only if missing

---

## Task 5: Error Handling

### 7️⃣ safe_script.sh
```bash
#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || { echo "Directory not navigable"; exit 1; }

touch hello.txt || { echo "Could not create the file"; exit 1; }
```

**What it demonstrates:**
- `set -e` exits immediately if any command fails
- `||` handles failure cases
- Grouped error handling with `{ }`

---

# What I Learned

1. How `for` and `while` loops work in shell scripting.
2. How to use command-line arguments: `$1`, `$#`, `$@`, `$0`.
3. How `set -e` stops execution on errors and how `||` helps handle failures safely.
4. How to check if a user is root using `$EUID`.
5. How `dpkg -s` checks package installation status.
6. Why `-y` is important for non-interactive installations.
7. How arithmetic expansion works: `i=$((i-1))`.
8. How `$?` gives the exit status of the last executed command.

---



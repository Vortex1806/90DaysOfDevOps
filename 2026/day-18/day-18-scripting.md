\# Day 18 – Shell Scripting: Functions & Intermediate Concepts

## Task 1: Basic Functions

### functions.sh

```bash
#!/bin/bash

# Function to greet
greet() {
    name=$1
    echo "Hello, $name!"
}

# Function to add two numbers
add() {
    num1=$1
    num2=$2
    sum=$((num1 + num2))
    echo "Sum: $sum"
}

# Calling functions
greet "Shubham"
add 5 10
```

### Output

```
Hello, Shubham!
Sum: 15
```

---

## Task 2: Functions with Return Values

### disk_check.sh

```bash
#!/bin/bash

check_disk() {
    echo "Disk Usage:"
    df -h /
}

check_memory() {
    echo "Memory Usage:"
    free -h
}

main() {
    check_disk
    echo ""
    check_memory
}

main
```

### Output

```
Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        30G  5G   25G   18% /

Memory Usage:
              total        used        free
Mem:           3.7G        500M        2.9G
```

---

## Task 3: Strict Mode — set -euo pipefail

### strict_demo.sh

```bash
#!/bin/bash
set -euo pipefail

# Undefined variable demo
# echo $UNDEFINED_VAR

# Command failure demo
# false

# Pipe failure demo
# grep "hello" nonexistent.txt | sort
```

### Explanation

set -e → Script exits immediately if any command returns a non-zero status.

set -u → Script exits if an undefined variable is used.

set -o pipefail → If any command in a pipeline fails, the whole pipeline fails.

---

## Task 4: Local Variables

### local_demo.sh

```bash
#!/bin/bash

local_example() {
    local message="This is a local variable"
    echo "$message"
}

global_example() {
    message="This is a global variable"
}

local_example

echo "Trying to access local variable outside function: $message"

global_example

echo "Accessing global variable: $message"
```

---

## Task 5: System Info Reporter

### system_info.sh

```bash
#!/bin/bash
set -euo pipefail

print_header() {
    echo "================================="
    echo "$1"
    echo "================================="
}

system_info() {
    print_header "System Information"
    echo "Hostname: $(hostname)"
    echo "OS: $(uname -a)"
}

uptime_info() {
    print_header "Uptime"
    uptime
}

disk_usage() {
    print_header "Disk Usage"
    du -ah / 2>/dev/null | sort -rh | head -n 5
}

memory_usage() {
    print_header "Memory Usage"
    free -h
}

cpu_processes() {
    print_header "Top CPU Processes"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
}

main() {
    system_info
    uptime_info
    disk_usage
    memory_usage
    cpu_processes
}

main
```

---

## What I Learned

1. Functions help make scripts modular and reusable.
2. set -euo pipefail makes scripts safer by stopping execution on errors or undefined variables.
3. Local variables prevent accidental modification of global variables inside functions.

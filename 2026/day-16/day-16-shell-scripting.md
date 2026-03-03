# Day 16 – Shell Scripting Basics

## Overview
Today I started my shell scripting journey and learned the core fundamentals required to write basic Bash scripts. This includes understanding the shebang, variables, user input, and conditional statements.

---

## Task 1: Your First Script

### hello.sh
```bash
#!/bin/bash

echo "Hello, DevOps!"
```

### Commands Used
```bash
chmod +x hello.sh
./hello.sh
```

### Output
```
Hello, DevOps!
```

### What Happens If Shebang Is Removed?
When I removed the `#!/bin/bash` line, the script still worked normally when executed as `./hello.sh`.

### Why Shebang Is Important
Even though it worked in this case, the shebang line tells the operating system which interpreter should execute the script. Without it:
- The script runs using the current default shell.
- It may fail if executed in a different shell (e.g., `sh` instead of `bash`).
- It can cause compatibility issues if Bash-specific syntax is used.

So, the shebang ensures portability, predictability, and correct interpreter usage.

---

## Task 2: Variables

### variables.sh
```bash
#!/bin/bash

NAME="Shubh"
ROLE="DevOps Engineer"

echo "Hello, I am $NAME and I am a $ROLE"
```

### Output
```
Hello, I am Shubh and I am a DevOps Engineer
```

### Single Quotes vs Double Quotes

When I used single quotes:
```bash
echo 'Hello, I am $NAME and I am a $ROLE'
```

Output:
```
Hello, I am $NAME and I am a $ROLE
```

When I used double quotes:
```bash
echo "Hello, I am $NAME and I am a $ROLE"
```

Output:
```
Hello, I am Shubh and I am a DevOps Engineer
```

### Difference
- Single quotes (' ') treat everything literally.
- Double quotes (" ") allow variable expansion.

---

## Task 3: User Input with read

### greet.sh
```bash
#!/bin/bash

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
```

### Sample Output
```
Enter your name: Shubh
Enter your favourite tool: Docker
Hello Shubh, your favourite tool is Docker
```

---

## Task 4: If-Else Conditions

### check_number.sh
```bash
#!/bin/bash

read -p "Enter a number: " NUM

if [ $NUM -gt 0 ]; then
    echo "The number is positive"
elif [ $NUM -lt 0 ]; then
    echo "The number is negative"
else
    echo "The number is zero"
fi
```

### file_check.sh
```bash
#!/bin/bash

read -p "Enter filename: " FILE

if [ -f "$FILE" ]; then
    echo "File exists"
else
    echo "File does not exist"
fi
```

---

## Task 5: Combine It All

### server_check.sh
```bash
#!/bin/bash

SERVICE="nginx"

read -p "Do you want to check the status? (y/n): " CHOICE

if [ "$CHOICE" = "y" ]; then
    systemctl status $SERVICE
    if systemctl is-active --quiet $SERVICE; then
        echo "$SERVICE is active"
    else
        echo "$SERVICE is not active"
    fi
else
    echo "Skipped."
fi
```

---

## Key Learnings (3 Points)

1. The shebang (`#!/bin/bash`) ensures the script runs with the correct interpreter and improves portability.
2. Single quotes prevent variable expansion, while double quotes allow variables to be evaluated.
3. Conditional statements and file checks (`-f`, `-gt`, `-lt`) are essential for building logical and dynamic scripts.
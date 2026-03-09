# Shell Scripting Cheat Sheet

A quick reference guide for common **Bash scripting concepts and commands** used in DevOps and automation.

---

# Quick Reference Table

| Topic        | Key Syntax              | Example                            |
| ------------ | ----------------------- | ---------------------------------- |
| Variable     | `VAR="value"`           | `NAME="DevOps"`                    |
| Argument     | `$1, $2`                | `./script.sh arg1`                 |
| If condition | `if [ cond ]; then`     | `if [ -f file ]; then`             |
| For loop     | `for i in list; do`     | `for i in 1 2 3; do`               |
| Function     | `name() {}`             | `greet() { echo "Hi"; }`           |
| Grep         | `grep pattern file`     | `grep -i "error" log.txt`          |
| Awk          | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed          | `sed 's/old/new/g'`     | `sed -i 's/foo/bar/g' file`        |

---

# 1. Basics

## Shebang

Defines which interpreter runs the script.

```bash
#!/bin/bash
```

---

## Running a Script

Make script executable:

```bash
chmod +x script.sh
```

Run script:

```bash
./script.sh
```

Run with bash interpreter:

```bash
bash script.sh
```

---

## Comments

Single line comment:

```bash
# This is a comment
```

Inline comment:

```bash
echo "Hello" # print greeting
```

---

## Variables

Declare variable:

```bash
NAME="Shubh"
```

Use variable:

```bash
echo $NAME
```

Quoted variable:

```bash
echo "$NAME"
```

Single quotes prevent expansion:

```bash
echo '$NAME'
```

---

## Reading User Input

```bash
read NAME
echo "Hello $NAME"
```

Prompt example:

```bash
read -p "Enter name: " NAME
```

---

## Command Line Arguments

| Variable | Meaning                   |
| -------- | ------------------------- |
| `$0`     | Script name               |
| `$1`     | First argument            |
| `$2`     | Second argument           |
| `$#`     | Number of arguments       |
| `$@`     | All arguments             |
| `$?`     | Exit code of last command |

Example:

```bash
echo "First arg: $1"
```

---

# 2. Operators and Conditionals

## String Comparisons

```bash
[ "$a" = "$b" ]
[ "$a" != "$b" ]
[ -z "$a" ]   # empty string
[ -n "$a" ]   # not empty
```

---

## Integer Comparisons

```bash
[ $a -eq $b ]
[ $a -ne $b ]
[ $a -lt $b ]
[ $a -gt $b ]
[ $a -le $b ]
[ $a -ge $b ]
```

---

## File Test Operators

| Operator | Meaning          |
| -------- | ---------------- |
| `-f`     | File exists      |
| `-d`     | Directory exists |
| `-e`     | File exists      |
| `-r`     | Readable         |
| `-w`     | Writable         |
| `-x`     | Executable       |
| `-s`     | File not empty   |

Example:

```bash
if [ -f file.txt ]; then
 echo "File exists"
fi
```

---

## If / Elif / Else

```bash
if [ $a -gt 10 ]; then
 echo "Greater"
elif [ $a -eq 10 ]; then
 echo "Equal"
else
 echo "Smaller"
fi
```

---

## Logical Operators

```bash
[ condition ] && echo "Success"

[ condition ] || echo "Fail"

! [ condition ]
```

---

## Case Statement

```bash
case $VAR in
 start) echo "Starting" ;;
 stop) echo "Stopping" ;;
 *) echo "Unknown" ;;
esac
```

---

# 3. Loops

## For Loop (List)

```bash
for i in 1 2 3
do
 echo $i
done
```

---

## For Loop (C Style)

```bash
for ((i=0;i<5;i++))
do
 echo $i
done
```

---

## While Loop

```bash
i=1
while [ $i -le 5 ]
do
 echo $i
 ((i++))
done
```

---

## Until Loop

Runs until condition becomes true.

```bash
i=1
until [ $i -gt 5 ]
do
 echo $i
 ((i++))
done
```

---

## Loop Control

Break loop:

```bash
break
```

Skip iteration:

```bash
continue
```

---

## Loop Over Files

```bash
for file in *.log
do
 echo $file
done
```

---

## Loop Over Command Output

```bash
cat file.txt | while read line
do
 echo $line
done
```

---

# 4. Functions

## Define Function

```bash
greet() {
 echo "Hello"
}
```

---

## Call Function

```bash
greet
```

---

## Function Arguments

```bash
sum() {
 echo $(($1 + $2))
}

sum 5 3
```

---

## Return Values

Return status:

```bash
return 0
```

Print result:

```bash
echo "Result"
```

---

## Local Variables

```bash
my_func() {
 local VAR=10
}
```

---

# 5. Text Processing Commands

## Grep

Search pattern:

```bash
grep "error" file.log
```

Common flags:

```bash
grep -i "error" file
grep -r "pattern" dir
grep -c "error" file
grep -n "error" file
grep -v "error" file
grep -E "ERROR|FAILED" file
```

---

## Awk

Print columns:

```bash
awk '{print $1}' file
```

Field separator:

```bash
awk -F: '{print $1}' /etc/passwd
```

Example:

```bash
awk '$3 > 1000 {print $1}' /etc/passwd
```

---

## Sed

Substitute text:

```bash
sed 's/foo/bar/' file
```

Global replace:

```bash
sed 's/foo/bar/g' file
```

Edit file in place:

```bash
sed -i 's/foo/bar/g' file
```

Delete line:

```bash
sed '3d' file
```

---

## Cut

Extract columns:

```bash
cut -d: -f1 file
```

---

## Sort

Alphabetical:

```bash
sort file.txt
```

Numeric:

```bash
sort -n file.txt
```

Reverse:

```bash
sort -r file.txt
```

Unique sort:

```bash
sort -u file.txt
```

---

## Uniq

Remove duplicates:

```bash
uniq file.txt
```

Count duplicates:

```bash
uniq -c file.txt
```

---

## Tr

Translate characters:

```bash
tr 'a-z' 'A-Z'
```

Delete characters:

```bash
tr -d '\r'
```

---

## WC

Count lines:

```bash
wc -l file
```

Count words:

```bash
wc -w file
```

---

## Head / Tail

First lines:

```bash
head -n 10 file
```

Last lines:

```bash
tail -n 10 file
```

Follow logs:

```bash
tail -f log.txt
```

---

# 6. Useful One-Liners

Delete files older than 7 days:

```bash
find /path -type f -mtime +7 -delete
```

Count lines in all logs:

```bash
wc -l *.log
```

Replace text across files:

```bash
sed -i 's/foo/bar/g' *.txt
```

Check if service is running:

```bash
systemctl status nginx
```

Monitor disk usage:

```bash
df -h
```

Real-time log error monitoring:

```bash
tail -f app.log | grep ERROR
```

---

# 7. Error Handling and Debugging

Exit code of last command:

```bash
echo $?
```

Manual exit:

```bash
exit 1
```

Exit on error:

```bash
set -e
```

Error on unset variables:

```bash
set -u
```

Catch pipe failures:

```bash
set -o pipefail
```

Debug mode:

```bash
set -x
```

Trap cleanup on exit:

```bash
trap 'cleanup' EXIT
```

Example:

```bash
cleanup() {
 echo "Cleaning up..."
}
```

# Day 06 – Linux Fundamentals: Read and Write Text Files

## Objective

Practice basic file read/write operations using fundamental Linux commands.

---

## 1. Creating a File

```bash
touch notes.txt
```

Creates an empty file named `notes.txt`.

---

## 2. Writing to a File (Overwrite using >)

```bash
echo "Line1" > notes.txt
```

Writes `Line1` into the file and overwrites existing content.

Check content:

```bash
cat notes.txt
```

Output:

```
Line1
```

---

## 3. Appending to a File (Using >>)

```bash
echo "Line2" >> notes.txt
```

Appends text without deleting previous content.

Check:

```bash
cat notes.txt
```

Output:

```
Line1
Line2
```

---

## 4. Using tee (Write + Display)

```bash
echo "Line3" | tee -a notes.txt
```

Displays `Line3` on terminal and appends it to file.

Final file content:

```bash
cat notes.txt
```

Output:

```
Line1
Line2
Line3
```

---

## 5. Reading Full File

```bash
cat notes.txt
```

Displays entire file.

---

## 6. Reading First Few Lines

```bash
head -n 2 notes.txt
```

Output:

```
Line1
Line2
```

---

## 7. Reading Last Few Lines

```bash
tail -n 2 notes.txt
```

Output:

```
Line2
Line3
```

---

# Extra Concepts Learned During Practice

## Counting Files

```bash
ls | wc -l
```

Counts number of files in directory.

---

## Using xargs

```bash
cat filenames.txt | xargs mkdir
```

Creates directories from names listed inside `filenames.txt`.

Remove directories:

```bash
rmdir file*
```

---

## grep Usage

```bash
ps -ef | grep http
```

Learned flags:

- `-i` → case insensitive
- `-c` → count matches
- `-w` → match whole word
- `-n` → show line numbers
- `egrep` → extended regex

---

## Sorting & Removing Duplicates

```bash
cat names.txt countries.txt | sort | uniq
```

- `sort` arranges lines
- `uniq` removes duplicates (works properly on sorted input)

---

## Extracting Specific Line Range

```bash
cat data.txt | head -38 | tail -7
```

Extracts a specific line range using head and tail.

---

## more vs less

- `more` → basic paginated view
- `less` → scrollable, better navigation and search

---

## Why ls | echo Does Not Work

```bash
ls | echo
```

Does not work because `echo` does not read from standard input (stdin).

Correct usage:

```bash
ls | xargs echo
```

`xargs` converts stdin into command-line arguments.

---

# Final notes.txt Content

```
Line1
Line2
Line3
```

---

## Summary

Practiced:

- File creation using `touch`
- Overwrite vs append (`>` vs `>>`)
- Viewing full and partial file content (`cat`, `head`, `tail`)
- Using `tee` for write + display
- Basic piping and command chaining

Day 06 Complete.

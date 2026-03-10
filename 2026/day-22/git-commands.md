# Git Commands Reference

## Setup & Configuration

### git --version

Checks the installed Git version.
Example:

```
git --version
```

### git config

Used to configure Git username and email.
Example:

```
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"
```

### git config --list

Shows the current Git configuration.
Example:

```
git config --list
```

---

## Repository Setup

### git init

Initializes a new Git repository in the current directory.
Example:

```
git init
```

### git clone

Creates a local copy of a remote repository.
Example:

```
git clone https://github.com/user/repo.git
```

---

## Basic Workflow

### git status

Displays the state of the working directory and staging area.
Example:

```
git status
```

### git add

Stages changes so they can be committed.
Example:

```
git add file.txt
```

Stage all files:

```
git add .
```

### git commit

Records the staged changes in the repository history.
Example:

```
git commit -m "Initial commit"
```

---

## Viewing Changes

### git diff

Shows the difference between working directory and staged changes.
Example:

```
git diff
```

### git log

Displays the commit history.
Example:

```
git log
```

Compact history:

```
git log --oneline
```

---

## Branching

### git branch

Lists all branches in the repository.
Example:

```
git branch
```

### git switch

Switches to another branch.
Example:

```
git switch branch-name
```

### git checkout

Used to switch branches or restore files.
Example:

```
git checkout branch-name
```

---

## Remote Repositories

### git remote add

Adds a remote repository.
Example:

```
git remote add origin https://github.com/user/repo.git
```

### git push

Pushes local commits to the remote repository.
Example:

```
git push origin main
```

### git pull

Fetches and merges changes from the remote repository.
Example:

```
git pull origin main
```

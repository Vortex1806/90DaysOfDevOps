# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches

### What is a branch in Git?

A branch in Git is a lightweight pointer to a specific commit. It allows developers to create separate lines of development so they can work on new features, experiments, or bug fixes without affecting the main codebase. Each branch can evolve independently until it is merged back.

### Why do we use branches instead of committing everything to main?

Branches allow safe experimentation and feature development without breaking the stable version of the project. If everything were committed directly to the main branch, unstable or incomplete changes could affect the entire codebase. Using branches keeps development organized and reduces risk.

### What is HEAD in Git?

HEAD is a reference that points to the current commit and branch you are working on. When you switch branches, HEAD moves to point to the latest commit of that branch. It essentially represents the current working state of the repository.

### What happens to your files when you switch branches?

When switching branches, Git updates the working directory to match the snapshot stored in the target branch. Files that exist in the new branch appear, and files that do not exist in that branch are removed from the working directory.

---

# Task 2: Branching Commands — Hands-On

### List all branches

```
git branch
```

Output showed:

```
feature1
* main
```

The `*` indicates the current branch.

---

### Create a new branch called feature1

```
git branch feature1
```

---

### Switch to feature1

```
git switch feature1
```

Git confirmed:

```
Switched to branch 'feature1'
```

---

### Create a new branch and switch to it in one command

```
git checkout -b feature2
```

Output:

```
Switched to a new branch 'feature2'
```

---

### Using git switch vs git checkout

Both commands can move between branches:

```
git switch feature1
git checkout feature1
```

Difference:

- `git switch` is the modern command specifically designed for switching branches.
- `git checkout` is older and performs multiple tasks such as switching branches and restoring files.

Because `git checkout` does multiple things, Git introduced `git switch` to make branch switching clearer and safer.

---

### Make a commit on feature1 that does not exist on main

Created a file:

```
touch hello
git add .
git commit -m "Added hello"
```

Output:

```
[feature1 42bf56b] Added hello
1 file changed
create mode 100644 hello
```

Files in feature1 branch:

```
README.md
hello
```

---

### Switch back to main and verify commit is not there

```
git checkout main
```

Then checked files:

```
ls
```

Output:

```
README.md
```

The `hello` file does not exist in the `main` branch, proving that commits in a branch remain isolated.

---

### Delete a branch you no longer need

```
git branch -d feature2
```

Output:

```
Deleted branch feature2
```

Remaining branches:

```
feature1
main
```

---

# Task 3: Push to GitHub

A new repository was created on GitHub without initializing it.

The local repository was connected to the remote and pushed.

Push main branch:

```
git push -u origin main
```

Push feature1 branch:

```
git push -u origin feature1
```

Both branches were verified on GitHub.

---

### What is the difference between origin and upstream?

**origin**

Origin is the default name Git gives to the remote repository you cloned from or connected to. It usually points to your own repository on GitHub.

Example:

```
origin → your GitHub repository
```

**upstream**

Upstream refers to the original repository from which a project was forked. It is used to keep your fork updated with changes from the original project.

Example:

```
origin → your fork
upstream → original repository
```

---

# Task 4: Pull from GitHub

A file was modified directly on GitHub using the online editor.

To bring those changes into the local repository:

```
git pull origin main
```

---

### Difference between git fetch and git pull

**git fetch**

Downloads the latest changes from the remote repository but does not merge them into the current branch. It only updates remote tracking branches.

Example:

```
git fetch origin
```

You can review changes before merging.

---

**git pull**

Fetches the changes and immediately merges them into the current branch.

Example:

```
git pull origin main
```

So essentially:

```
git pull = git fetch + git merge
```

---

# Task 5: Clone vs Fork

### Clone a public repository

Cloning creates a local copy of a repository.

Example:

```
git clone https://github.com/user/repo.git
```

This downloads the full repository and its history to your local machine.

---

### Fork a repository

Forking is a feature of GitHub that creates a personal copy of someone else's repository in your own GitHub account.

You can modify the fork without affecting the original repository.

---

### Difference between clone and fork

Clone:

- A Git operation
- Creates a local copy of a repository

Fork:

- A GitHub feature
- Creates a copy of a repository under your GitHub account

---

### When would you clone vs fork?

Clone when:

- You have direct access to the repository
- You are working on your own project
- You want a local copy

Fork when:

- You want to contribute to someone else's project
- You do not have write access to the original repository
- You plan to submit pull requests

---

### How to keep a fork in sync with the original repository

Add the original repository as upstream:

```
git remote add upstream https://github.com/original-owner/repository.git
```

Fetch latest changes:

```
git fetch upstream
```

Merge them into your main branch:

```
git merge upstream/main
```

Then push the updated fork to your GitHub repository.

# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge — Hands-On

### Steps Performed

1. Created a new branch from main

```
git checkout -b feature-login
```

2. Added commits to feature-login

```
echo "login feature" >> app.txt
git add .
git commit -m "Add login feature"

echo "login validation" >> app.txt
git add .
git commit -m "Add login validation"
```

3. Switched back to main and merged

```
git checkout main
git merge feature-login
```

### Observation

Git performed a fast-forward merge.

### What is a fast-forward merge?

A fast-forward merge happens when the main branch has not moved ahead since the feature branch was created. In this case Git simply moves the main branch pointer forward to the latest commit of the feature branch. No extra merge commit is created.

### When does Git create a merge commit instead?

Git creates a merge commit when both branches have new commits. If the main branch has commits that the feature branch does not have, Git cannot simply move the pointer forward. Instead it creates a new merge commit that combines the histories of both branches.

### Second Scenario

Created another branch:

```
git checkout -b feature-signup
```

Added commits on feature-signup.

Before merging, a commit was added on main.

When merging feature-signup into main:

```
git merge feature-signup
```

Git created a **merge commit** because both branches had diverged.

### What is a merge conflict?

A merge conflict happens when two branches modify the same part of a file and Git cannot automatically decide which version to keep.

Example:

Branch A:

```
Hello World
```

Branch B:

```
Hello DevOps
```

If both modify the same line, Git stops the merge and asks the developer to manually resolve the conflict.

Conflict markers appear like:

```
<<<<<<< HEAD
Hello World
=======
Hello DevOps
>>>>>>> feature-branch
```

The developer edits the file, removes the markers, keeps the correct code, then commits the resolution.

---

# Task 2: Git Rebase — Hands-On

### Steps Performed

Create a new branch:

```
git checkout -b feature-dashboard
```

Added multiple commits.

Then switched to main and added another commit.

Now main was ahead of the feature branch.

Switched back to the feature branch and ran:

```
git rebase main
```

### Observation

The commits from feature-dashboard were **replayed on top of the latest main branch commit**.

Using

```
git log --oneline --graph --all
```

showed a **linear history**.

### What does rebase actually do?

Rebase takes the commits from the current branch and reapplies them on top of another branch. Instead of creating a merge commit, Git rewrites the commit history so that the feature branch appears as if it was created from the latest commit of the base branch.

### How is the history different from a merge?

Merge creates a branch structure in history with merge commits.

Rebase creates a **clean linear history** where commits appear in a straight line.

Example:

Merge History:

```
A---B---C main
     \   \
      D---E feature
```

Rebase History:

```
A---B---C---D'---E'
```

### Why should you never rebase commits that have been pushed and shared with others?

Rebase rewrites commit history. If the commits were already pushed and other developers have based work on them, rebasing will change commit hashes and create conflicts in the shared repository.

This can break collaboration and force others to manually fix history.

### When would you use rebase vs merge?

Use **merge**:

- When preserving exact branch history is important
- In shared branches
- In collaborative environments

Use **rebase**:

- To clean up local commit history
- Before merging a feature branch
- When keeping history linear is preferred

---

# Task 3: Squash Commit vs Merge Commit

### Steps Performed

Created a branch:

```
git checkout -b feature-profile
```

Added multiple small commits:

- typo fixes
- formatting
- small updates

Merged with squash:

```
git merge --squash feature-profile
```

Then committed.

### Observation

All commits from the feature branch were combined into **one single commit** on main.

### What does squash merging do?

Squash merging combines all commits from a feature branch into a single commit before merging into the main branch.

This keeps the commit history clean and prevents many small commits from cluttering the main branch history.

### Regular Merge Comparison

Created another branch:

```
git checkout -b feature-settings
```

Added several commits and merged normally:

```
git merge feature-settings
```

This preserved **all commits individually** in the history.

### When would you use squash merge vs regular merge?

Use **squash merge**:

- When feature branch contains many small or messy commits
- When you want one clean commit representing the entire feature

Use **regular merge**:

- When individual commits are meaningful
- When commit history matters
- When debugging changes later

### Trade-off of Squashing

While squashing keeps history clean, it removes the detailed commit history from the feature branch. This can make debugging harder because intermediate commits are lost.

---

# Task 4: Git Stash — Hands-On

### Steps Performed

Started modifying a file but did not commit the changes.

Tried switching branches:

```
git checkout another-branch
```

Git warned about uncommitted changes.

Saved work using stash:

```
git stash
```

Then switched branches successfully.

Later returned to the branch and restored work:

```
git stash pop
```

### Working with Multiple Stashes

Create stash with message:

```
git stash push -m "work in progress"
```

List stashes:

```
git stash list
```

Apply a specific stash:

```
git stash apply stash@{1}
```

### Difference between git stash pop and git stash apply

`git stash apply`

- Applies the stash
- Keeps the stash saved in the stash list

`git stash pop`

- Applies the stash
- Removes it from the stash list

### When would you use stash in real-world workflow?

Stash is useful when:

- You are in the middle of work and need to quickly switch branches
- A production bug needs urgent fixing
- Your current changes are not ready to commit yet

Stash temporarily saves your work without committing incomplete code.

---

# Task 5: Cherry Picking

### Steps Performed

Created a branch:

```
git checkout -b feature-hotfix
```

Made three commits.

Switched back to main:

```
git checkout main
```

Found the commit hash using:

```
git log --oneline
```

Cherry-picked the second commit:

```
git cherry-pick <commit-hash>
```

### Observation

Only that specific commit was applied to the main branch.

### What does cherry-pick do?

Cherry-pick applies a specific commit from another branch onto the current branch.

Instead of merging the entire branch, only the selected commit is copied.

### When would you use cherry-pick in a real project?

Cherry-pick is useful when:

- A specific bug fix needs to be applied to multiple branches
- A hotfix needs to be moved into production quickly
- You only want a particular change from another branch

Example:
A bug fix was committed in a development branch, but production needs it immediately. Instead of merging the entire branch, the fix commit can be cherry-picked.

### What can go wrong with cherry-picking?

- Conflicts may occur if the commit modifies code that has changed in the target branch
- Duplicate commits can appear in history
- It can create confusion if overused

Cherry-picking should be used carefully and mainly for targeted fixes.

---

# Summary

Today I learned how Git integrates different branches and manages work across multiple contexts. Merge allows branches to combine histories, while rebase rewrites commit history to keep it clean and linear. Squash merges help simplify commit history by combining multiple commits into one. Git stash allows temporary storage of unfinished work, enabling quick context switching. Cherry-picking makes it possible to apply specific commits without merging entire branches.

Understanding these commands is essential for real-world development workflows where multiple branches, urgent fixes, and collaborative work are common.

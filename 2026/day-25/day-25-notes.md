# Day 25 – Git Reset vs Revert & Branching Strategies

## Task 1: Git Reset — Hands-On

### Steps Performed

Created three commits in the repository:

```
Commit A
Commit B
Commit C
```

### git reset --soft

Command used:

```
git reset --soft HEAD~1
```

Observation:

- The last commit was removed from the commit history
- The changes from that commit remained staged in the index
- The files were ready to be committed again

This means the commit was undone but the work was preserved in the staging area.

---

### git reset --mixed

Command used:

```
git reset --mixed HEAD~1
```

Observation:

- The last commit was removed from history
- Changes from that commit were kept in the working directory
- However, they were **not staged** anymore

This means the changes still existed but needed to be added again using `git add` before committing.

---

### git reset --hard

Command used:

```
git reset --hard HEAD~1
```

Observation:

- The last commit was removed from history
- All changes from that commit were permanently deleted
- The working directory was reset to match the previous commit

---

### Difference Between --soft, --mixed, and --hard

| Reset Type | Commit History  | Staging Area          | Working Directory |
| ---------- | --------------- | --------------------- | ----------------- |
| --soft     | Moves HEAD back | Changes remain staged | Files unchanged   |
| --mixed    | Moves HEAD back | Unstaged              | Files unchanged   |
| --hard     | Moves HEAD back | Cleared               | Files reset       |

---

### Which one is destructive and why?

`git reset --hard` is destructive because it deletes both the commit and the associated file changes from the working directory. If those changes are not backed up or recoverable via `git reflog`, they may be permanently lost.

---

### When would you use each one?

**--soft**

- When you want to undo a commit but keep the changes staged
- Useful for fixing commit messages or combining commits

**--mixed**

- When you want to undo a commit but keep the changes as unstaged modifications
- Useful when you want to review changes again before committing

**--hard**

- When you want to completely discard changes
- Useful for cleaning the repository or resetting to a known stable state

---

### Should you ever use git reset on commits that are already pushed?

Generally, no. Using reset on commits that have already been pushed changes the commit history. This can cause problems for other collaborators who have already pulled those commits. Rewriting shared history may lead to conflicts and confusion.

---

# Task 2: Git Revert — Hands-On

### Steps Performed

Created three commits:

```
Commit X
Commit Y
Commit Z
```

Reverted the middle commit:

```
git revert <commit-hash-of-Y>
```

### Observation

Git created a **new commit** that reversed the changes introduced by commit Y.

### Checking git log

Running:

```
git log --oneline
```

Showed that:

- Commit Y still existed in history
- A new commit was added that negated its changes

---

### How is git revert different from git reset?

`git revert` does not remove commits from history. Instead, it creates a new commit that reverses the effect of a previous commit.

`git reset` moves the branch pointer backwards and removes commits from the history.

---

### Why is revert considered safer than reset for shared branches?

Revert preserves the commit history and does not rewrite existing commits. Since history remains intact, it avoids breaking collaboration or causing issues for developers who have already pulled the commits.

---

### When would you use revert vs reset?

Use **revert**:

- When working with shared repositories
- When the commit has already been pushed
- When you want a clear audit trail of changes

Use **reset**:

- When working locally
- When cleaning up commit history before pushing
- When discarding mistakes during development

---

# Task 3: Reset vs Revert — Comparison

| Feature                      | git reset                     | git revert                                 |
| ---------------------------- | ----------------------------- | ------------------------------------------ |
| What it does                 | Moves branch pointer backward | Creates a new commit that reverses changes |
| Removes commit from history? | Yes                           | No                                         |
| Safe for shared branches?    | No                            | Yes                                        |
| When to use                  | Local history cleanup         | Undo changes in shared repositories        |

---

# Task 4: Branching Strategies

## 1. GitFlow

### How it works

GitFlow uses multiple long-lived branches to organize development and releases.

Main branches:

- `main` (production-ready code)
- `develop` (integration branch for features)

Supporting branches:

- `feature/*`
- `release/*`
- `hotfix/*`

### Diagram

```
main -----------o---------o
      \        /\
       \      /  release
        develop----o----o
           \      \
        feature    feature
```

### When it is used

- Large teams
- Enterprise environments
- Projects with scheduled releases

### Pros

- Structured release management
- Clear separation of environments

### Cons

- Complex workflow
- Slower development cycles

---

## 2. GitHub Flow

### How it works

GitHub Flow is a simpler model.

Developers create feature branches from `main`, make changes, open pull requests, review code, and merge back into `main`.

### Diagram

```
main -----------o------o
      \        /
       feature
```

### When it is used

- Continuous deployment environments
- Startups
- Web applications

### Pros

- Simple workflow
- Fast development

### Cons

- Less structure for complex releases

---

## 3. Trunk-Based Development

### How it works

All developers work on a single main branch (trunk). Feature branches exist but are very short-lived.

Code is integrated frequently and often behind feature flags.

### Diagram

```
main ----o----o----o----o
        /    /
   short feature branches
```

### When it is used

- Large engineering teams
- Continuous integration environments
- High deployment frequency systems

### Pros

- Reduces merge conflicts
- Encourages frequent integration

### Cons

- Requires strong testing and CI systems

---

### Which strategy would you use for a startup shipping fast?

GitHub Flow or Trunk-Based Development because both support fast development cycles, continuous integration, and rapid deployments.

---

### Which strategy would you use for a large team with scheduled releases?

GitFlow because it supports structured release management with dedicated release and hotfix branches.

---

### Example from Open Source

Many open-source projects such as React primarily follow a workflow similar to **GitHub Flow**, where feature branches are merged into the main branch through pull requests.

---

# Task 5: Git Commands Reference Update

The following sections were added to `git-commands.md`:

### Setup & Config

```
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"
```

### Basic Workflow

```
git status
git add
git commit
git log
git diff
```

### Branching

```
git branch
git checkout
git switch
```

### Remote

```
git clone
git push
git pull
git fetch
```

### Merging & Rebasing

```
git merge
git rebase
```

### Stash & Cherry Pick

```
git stash
git stash pop
git cherry-pick
```

### Reset & Revert

```
git reset --soft
git reset --mixed
git reset --hard
git revert
```

---

# Summary

Today I learned how to safely undo changes in Git using reset and revert. Reset rewrites history by moving the branch pointer, while revert preserves history by creating a new commit that reverses changes. Understanding the difference is important when working in collaborative environments. I also explored branching strategies like GitFlow, GitHub Flow, and Trunk-Based Development. Each strategy serves different team sizes and release models, and choosing the right one depends on the development workflow and deployment frequency.

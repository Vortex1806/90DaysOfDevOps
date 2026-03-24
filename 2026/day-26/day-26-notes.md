# Day 26 – GitHub CLI: Manage GitHub from Your Terminal

## Objective

Learn how to use the GitHub CLI (gh) to manage repositories, issues, pull requests, and workflows directly from the terminal.

---

## Task 1: Install and Authenticate

### Steps

- Install GitHub CLI on your system
- Authenticate with your GitHub account using:
  ```bash
  gh auth login
  ```
- Verify authentication:
  ```bash
  gh auth status
  ```

### Observations

- gh supports authentication via:
  - Browser-based login (HTTPS)
  - Personal Access Token (PAT)
  - SSH authentication

---

## Task 2: Working with Repositories

### Commands Used

- Create a repository:

  ```bash
  gh repo create my-test-repo --public --clone --add-readme
  ```

- Clone a repository:

  ```bash
  gh repo clone <owner/repo>
  ```

- View repository details:

  ```bash
  gh repo view
  ```

- List repositories:

  ```bash
  gh repo list
  ```

- Open in browser:

  ```bash
  gh repo view --web
  ```

- Delete repository:
  ```bash
  gh repo delete my-test-repo --confirm
  ```

---

## Task 3: Issues

### Commands Used

- Create issue:

  ```bash
  gh issue create --title "Test Issue" --body "This is a test issue" --label bug
  ```

- List issues:

  ```bash
  gh issue list
  ```

- View issue:

  ```bash
  gh issue view <issue-number>
  ```

- Close issue:
  ```bash
  gh issue close <issue-number>
  ```

### Observations

- gh issue can be used in automation to:
  - Auto-create issues when CI/CD fails
  - Log system errors
  - Track recurring failures

---

## Task 4: Pull Requests

### Steps

1. Create a branch and push changes:

   ```bash
   git checkout -b feature-branch
   git add .
   git commit -m "feature added"
   git push origin feature-branch
   ```

2. Create PR:
   ```bash
   gh pr create --fill
   ```

### Commands Used

- List PRs:

  ```bash
  gh pr list
  ```

- View PR:

  ```bash
  gh pr view
  ```

- Merge PR:
  ```bash
  gh pr merge
  ```

### Observations

- Merge methods supported:
  - Merge commit
  - Squash merge
  - Rebase merge

- Reviewing PRs:
  ```bash
  gh pr checkout <pr-number>
  gh pr review --approve
  gh pr review --comment
  ```

---

## Task 5: GitHub Actions (Preview)

### Commands Used

- List workflow runs:

  ```bash
  gh run list
  ```

- View workflow run:
  ```bash
  gh run view <run-id>
  ```

### Observations

- Useful for:
  - Monitoring CI/CD pipelines
  - Debugging failures
  - Triggering workflows from scripts

---

## Task 6: Useful gh Commands

### Advanced Commands

- GitHub API:

  ```bash
  gh api repos/:owner/:repo
  ```

- Gists:

  ```bash
  gh gist create file.txt
  ```

- Releases:

  ```bash
  gh release create v1.0
  ```

- Aliases:

  ```bash
  gh alias set co "pr checkout"
  ```

- Search repositories:
  ```bash
  gh search repos <query>
  ```

---

## Conclusion

The GitHub CLI (gh) significantly improves developer productivity by enabling full GitHub workflow management directly from the terminal. It is especially powerful for DevOps engineers when integrated into scripts and CI/CD pipelines.

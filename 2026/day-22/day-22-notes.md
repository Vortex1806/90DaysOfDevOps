# Day 22 – Git Notes

## 1. Difference between git add and git commit

`git add` moves changes from the working directory to the staging area. It tells Git which files should be included in the next commit.

`git commit` records the staged changes permanently in the repository history with a message describing the change.

## 2. What the staging area does

The staging area acts like a preparation layer where we choose exactly which changes should go into the next commit. It allows us to organize commits instead of committing everything at once.

## 3. What git log shows

`git log` shows the commit history including commit hash, author name, date, and the commit message.

## 4. What the .git folder is

The `.git` folder contains the entire Git repository including commit history, branches, configuration and metadata. If this folder is deleted, the project will no longer be a Git repository and the history will be lost.

## 5. Working directory vs staging area vs repository

Working directory is the actual project files where changes are made.

Staging area is the intermediate place where selected changes are prepared for commit.

Repository is the stored history of commits maintained by Git.

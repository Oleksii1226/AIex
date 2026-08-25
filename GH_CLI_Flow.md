# GH_CLI_Flow.md

This document describes common gh CLI flows used in this project for creating repositories, pull requests, and merging.

Prerequisites
- GitHub CLI (gh) installed and authenticated: gh auth login
- Local repository cloned or present

Common commands

1) Create a new repo from the current folder and push (useful when setting up a new remote):
   gh repo create windows-mvp-wrapper --public --source=. --remote=origin --push

2) Create a branch and push it:
   git checkout -b feature/windows-mvp-wrapper
   git add .
   git commit -m "Add MVP wrapper placeholders"
   git push -u origin feature/windows-mvp-wrapper

3) Create a pull request from a branch to main:
   gh pr create --base main --head feature/windows-mvp-wrapper --title "Add Windows MVP wrapper scripts and documentation" --body "See PR description"

4) Add reviewers and labels to an existing PR:
   gh pr edit <PR_NUMBER> --add-reviewer username
   gh pr edit <PR_NUMBER> --add-label documentation --add-label scripts

5) Checkout PR locally for testing:
   gh pr checkout <PR_NUMBER>

6) Merge PR after approval (recommended: squash for feature branches):
   gh pr merge <PR_NUMBER> --squash --delete-branch

Notes
- Replace <PR_NUMBER> with the actual PR number or use the PR URL.
- Use `gh pr view --web` to open the PR in the browser.

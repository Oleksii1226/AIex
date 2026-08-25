# First_Push_Checklist.md

A short checklist to run before your first push and before merging a PR.

Before first push
- [ ] Remove or exclude any secrets (PATs, keys) from files.
- [ ] Add sensitive files to .gitignore (e.g., local-config.json, *.pem)
- [ ] Ensure large binaries (model weights) are not committed; host externally and reference download steps.
- [ ] Create a minimal .gitattributes if you need to control line endings.
- [ ] Confirm commit message follows the project's convention (if any).

Before creating PR
- [ ] Run `git status` and ensure only intended files are staged.
- [ ] Run `git diff --staged` to review staged changes.
- [ ] Run setup_env.ps1 locally and verify venv creation (if applicable).
- [ ] Run windows_run_wrapper.ps1 to ensure no immediate runtime errors and logs are produced.

Before merge
- [ ] Ensure PR review comments are resolved.
- [ ] Run security check for accidental secrets in history (eg. use git-secrets or truffleHog).
- [ ] Ensure tests / smoke tests passed locally.
- [ ] Choose merge policy (squash for small feature branch recommended).

After merge
- [ ] Pull main locally and delete the feature branch:
  - git checkout main
  - git pull origin main
  - git branch -d feature/windows-mvp-wrapper
- [ ] Remove any short-lived PATs used for pushing (revoke on GitHub if created).


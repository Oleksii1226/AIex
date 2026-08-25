AI Agent Wrapper — Workflow Sample

Purpose
- Provide a concise sample workflow for preparing, creating, and running the Windows MVP Wrapper and related AI Agent files on Windows and GitHub.

Prerequisites
- Windows 10/11 with Administrator rights for PowerShell when required
- Git installed or GitHub CLI (gh)
- Python 3.10+ installed and available in PATH
- Local folder with repository files: C:\Users\<your_user>\windows_mvp_wrapper_github_repo
  - Required files: bootstrap_win.ps1, setup_env.ps1, windows_run_wrapper.ps1, orchestrator.py, README_win_repo.md, test_scenario.md, AI_Agent_Project_Overview.md

Typical workflow (manual)
1) Prepare local folder
   - Place all files into C:\Users\<your_user>\windows_mvp_wrapper_github_repo
   - Open PowerShell as Administrator if installers will run

2) Initialize git and create remote repo (two options)
   Option A — GH CLI (recommended)
     - gh auth login
     - gh repo create windows-mvp-wrapper --public --source=. --remote=origin --push
   Option B — Using a PAT (one-time)
     - git init
     - git add .
     - git commit -m "Initial commit: Windows MVP Wrapper"
     - git remote add origin https://github.com/<your_account>/windows-mvp-wrapper.git
     - git push -u origin main
     - (Revoke PAT after first push if desired)

3) Validate environment locally
   - Run bootstrap_win.ps1 to install prerequisites (if required)
   - Run setup_env.ps1 to create virtualenv and install pip requirements
   - Verify Python and dependencies: python --version; pip list

4) Run the wrapper
   - From the repository folder, run:
     - Open PowerShell, then:
       ./windows_run_wrapper.ps1
   - The wrapper should:
     - Check Python availability
     - Unpack MVP zip (if present)
     - Start orchestrator.py in the created environment
     - Stream logs to a log file in ./logs/

5) Inspect logs
   - Check ./logs/orchestrator.log and ./logs/windows_run_wrapper.log for status and errors
   - For quick verification, run the sample scenario described in test_scenario.md

Sample workflow (automated via setup script)
- If you use setup_github_wrapper.ps1:
  - The script can prompt for a PAT or use gh CLI
  - It will create the repository remotely, add files, and push
  - After the push runs, run windows_run_wrapper.ps1 locally to start the orchestrator

Troubleshooting
- Permission errors: run PowerShell as Administrator
- Missing Python: install Python 3.10+ and add to PATH
- Network / downloads fail: ensure Internet access and proxies are configured
- If orchestrator fails quickly, inspect error trace in orchestrator.log and ensure required model files are present/unpacked

Security notes
- Prefer GH CLI interactive login over embedding PATs in scripts
- If using a PAT, give it minimal scope and revoke it when finished

What to commit alongside this file (recommended)
- setup_github_wrapper.ps1 (optional helper to create repo & push)
- bootstrap_win.ps1, setup_env.ps1, windows_run_wrapper.ps1, orchestrator.py (scripts)
- test_scenario.md and IMPORT_GUIDE.md (docs)

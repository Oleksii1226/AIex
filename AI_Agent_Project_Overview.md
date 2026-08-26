AI Agent Project Overview

Purpose
- Describe the AI Agent Project and how the Windows MVP Wrapper integrates with it.

Summary
- The AI Agent Project bundles an AI model (MVP) together with orchestration and a simple Windows wrapper so non-developers can launch and monitor the agent on Windows 10/11.
- The Windows MVP Wrapper provides environment checks, unpacking of the MVP package, environment setup, and a single-run entrypoint (windows_run_wrapper.ps1) to start orchestrator.py and capture lo[

Repository layout (relevant files)
- README_win_repo.md  — Starter guide for Windows users (this file)
- setup_github_wrapper.ps1 — optional script to create a GitHub repo and push local files using a PAT or GH CLI
- bootstrap_win.ps1 — prepares Windows environment, installs prerequisites
- setup_env.ps1 — creates virtualenv and installs Python requirements
- windows_run_wrapper.ps1 — single-run PowerShell runner that launches the orchestrator
- orchestrator.py — main Python entrypoint for MVP orchestration/monitoring
- test_scenario.md — example scenario for quick verification
- AI_Agent_Project_Overview.md — (this file)
- AI_Agent_Wrapper_Workflow_Sample.md — workflow sample for running the wrapper

Goals
- Make it easy for a Windows user to run the MVP with one action (double-click or single PowerShell command).
- Keep the repository usable for CI and future automation (scripts separated from documentation).
- Provide clear, minimal documentation so non-developers can deploy and test the solution.

Security and tokens
- Use a short-lived PAT with minimal scopes (repo:create & repo) or prefer the GH CLI interactive login to avoid embedding tokens in scripts.
- If a PAT is used for initial push, revoke it immediately after the repository is created and populated.

Quick run checklist (for testers)
1) Ensure Windows PowerShell is run as Administrator if scripts require system installs.
2) Verify Python 3.10+ is installed and available in PATH.
3) Place repository files into C:\Users\<your_user>\windows_mvp_wrapper_github_repo and run windows_run_wrapper.ps1 or follow README_win_repo.md.
4) Inspect logs produced by the wrapper and orchestrator for success/failure details.

Contact
- Repo owner: GitHub user Oleksii1226

# test_scenario.md

# Test scenario — quick verification of Windows MVP Wrapper

1. Ensure required files are present in the repo folder:
   - orchestrator.py, windows_run_wrapper.ps1, setup_env.ps1, bootstrap_win.ps1
2. (Optional) Run bootstrap_win.ps1 as Administrator to install system dependencies.
3. Run setup_env.ps1 to create a virtual environment and install Python dependencies.
4. Activate the virtual environment (if created):
   - .\venv\Scripts\Activate.ps1
5. Run the wrapper:
   - .\windows_run_wrapper.ps1
6. Open logs/ to inspect windows_run_wrapper.log and orchestrator.log

Expected result: orchestrator.py starts and writes logs to logs/orchestrator.log.

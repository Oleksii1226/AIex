# IMPORT_GUIDE.md

# Import Guide (placeholder)

This document explains common import or migration scenarios for the Windows MVP Wrapper project.

1. Importing into a new GitHub repository
   - Create a new repo (e.g., windows-mvp-wrapper) on GitHub or use the provided setup script.
   - Push the repository files from your local folder to the new remote.

2. Importing into an existing organization
   - Ensure you have permissions to create repositories or push to the target org.
   - Use gh CLI (`gh repo create`) or create the repo via the GitHub web UI, then push.

3. Import into GitHub Codespaces / Devcontainers
   - Add a .devcontainer/ folder and Dockerfile or devcontainer.json as needed.
   - Ensure Python and any required system libraries are included.

4. Notes
   - Do not commit large model binaries to Git; host them externally (cloud storage) and add download/unpack steps to bootstrap or orchestrator.
   - Keep any PATs or secrets out of repo. Use gh auth, GitHub Actions secrets, or local environment variables.


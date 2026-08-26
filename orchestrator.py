"""Minimal orchestrator for Windows MVP Wrapper (placeholder)

This script is a lightweight, minimal entrypoint that the windows_run_wrapper.ps1
can call. It is intentionally simple so you can expand it with model loading,
network calls, or process orchestration as needed.

Behavior:
 - Ensures logs/ directory exists
 - Writes start/stop messages to logs/orchestrator.log with timestamps
 - Supports --once to run a single short job and exit
 - Otherwise runs a simple loop writing a heartbeat every 5 seconds (Ctrl+C to stop)

Usage (PowerShell):
  python orchestrator.py --once
  python orchestrator.py

"""
import argparse
import os
import time
from datetime import datetime

LOG_DIR = "logs"
LOG_FILE = os.path.join(LOG_DIR, "orchestrator.log")


def ensure_logs_dir():
    os.makedirs(LOG_DIR, exist_ok=True)


def log(msg: str):
    ts = datetime.utcnow().isoformat() + "Z"
    line = f"{ts}\t{msg}\n"
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(line)
    print(line, end="")


def run_once():
    ensure_logs_dir()
    log("orchestrator: start (once)")
    # Placeholder for actual work: simulate short task
    log("orchestrator: performing short task...")
    time.sleep(1)
    log("orchestrator: task completed")
    log("orchestrator: stop (once)")


def run_loop():
    ensure_logs_dir()
    log("orchestrator: start (loop)")
    try:
        i = 0
        while True:
            i += 1
            log(f"orchestrator: heartbeat {i}")
            # Placeholder: here you'd poll queues, process tasks, etc.
            time.sleep(5)
    except KeyboardInterrupt:
        log("orchestrator: received KeyboardInterrupt, exiting")
    finally:
        log("orchestrator: stop (loop)")


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--once", action="store_true", help="Run a single short task and exit")
    args = p.parse_args()

    if args.once:
        run_once()
    else:
        run_loop()


if __name__ == "__main__":
    main()

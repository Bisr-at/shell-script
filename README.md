# System Configuration Backup Script

## Description

This Bash script automates the backup of important system configuration files and directories listed in `backup_list.conf`. It creates timestamped, gzipped tar archives in a specified backup destination and includes optional pruning of old backups.

## Features

*   Reads list of files/directories to back up from `backup_list.conf`.
*   Creates timestamped `.tar.gz` archives (e.g., `config-backup-YYYYMMDD-HHMMSS.tar.gz`).
*   Creates the backup destination directory if it doesn't exist.
*   Logs actions with timestamps.
*   Includes basic error handling (checks for config file, destination writability, required commands).

## Prerequisites

*   Bash shell
*   Core utilities: `tar`, `gzip`, `date`, `mkdir`, `find`, `grep` (usually standard on Linux/macOS).

## Installation

1.  Clone this repository or download the script files (`config_backup.sh`, `backup_list.conf`).
2.  Make the script executable: `chmod +x config_backup.sh`

## Configuration

1.  **Edit `config_backup.sh`:**
    *   Set the `BACKUP_DEST` variable to your desired backup directory path. Ensure you have write permissions to this location.
2.  **Edit `backup_list.conf`:**
    *   List the full paths of the files and directories you want to back up, one per line.
    *   Lines starting with `#` are ignored.

## Usage

Run the script from its directory:

```bash
./config_backup.sh

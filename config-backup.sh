#!/usr/bin/env bash

BACKUP_DEST="$HOME/config_backups"
FILES_TO_BACKUP="/etc/nsswitch.conf"
# Later we might add: /etc/ssh/sshd_config /etc/hosts /etc/resolv.conf etc.

# --- Backup Logic ---
# Create the destination directory if it doesn't exist
# The -p option ensures no error if it already exists and creates parent dirs if needed.

mkdir -p "$BACKUP_DEST"
# Generate a timestamp for the filename (e.g., 20250427-153001)

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Construct the full archive filename

ARCHIVE_NAME="config-backup-$TIMESTAMP.tar.gz"
ARCHIVE_FULL_PATH="$BACKUP_DEST/$ARCHIVE_NAME"

echo "Starting configuration backup..."
echo "Source files/dirs: $FILES_TO_BACKUP"
echo "Destination archive: $ARCHIVE_FULL_PATH"

# Create the compressed tar archive
# c = create, z = gzip compress, v = verbose (list files), f = specify filename
# Using --ignore-failed-read to prevent tar from exiting if a file is unreadable (useful for /etc)
# Absolute paths are stored in the archive. Use -P if you need this.
# For relative paths (safer often), consider changing directory or using -C, but absolute is okay for /etc backups.

tar -czvf "$ARCHIVE_FULL_PATH" --ignore-failed-read $FILES_TO_BACKUP

echo "Configuration backup complete!"
echo "Archive created at: $ARCHIVE_FULL_PATH"

# Exit with success
exit 0

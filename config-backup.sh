#!/usr/bin/env bash

BACKUP_DEST="$HOME/config_backups"
CONFIG_FILE="backup_list.conf"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

#checking the CONFIG_FILE
log "INFO: Starting configuration backup script."
if [[ ! -f "$CONFIG_FILE" ]]; then
    log "ERROR: Configuration file '$CONFIG_FILE' not found."
    exit 1
elif [[ ! -r "$CONFIG_FILE" ]]; then
	    log "ERROR: Configuration file '$CONFIG_FILE' is not readable."
    exit 1
fi
log "INFO: Using configuration file '$CONFIG_FILE'."

#checking the destination file

if [[ ! -d "$BACKUP_DEST" ]]; then
	log "INFO: Backup directory '$BACKUP_DEST' does not exit creating ..."
	makdir -p "BACKUP_DEST"
	log "INFO: backup destination created."

elif [[ ! -w "$BACKUP_DEST" ]]; then
    log "ERROR: Backup destination '$BACKUP_DEST' is not writable."
    exit 1
else
     log "INFO: Backup destination '$BACKUP_DEST' found and is writable."
fi


#checking if the tar and grep command workes well or noT

if ! command -v tar &> /dev/null; then
	    log "ERROR: 'tar' command not found. Please install tar."
    exit 1
fi
if ! command -v grep &> /dev/null; then
    log "ERROR: 'grep' command not found. Please install grep."
    exit 1
fi

#backup configuaration

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
ARCHIVE_NAME="config-backup-$TIMESTAMP.tar.gz"
ARCHIVE_FULL_PATH="$BACKUP_DEST/$ARCHIVE_NAME"

log "INFO: Preparing backup..."
log "INFO: Reading backup list from '$CONFIG_FILE'."
log "INFO: Destination archive: $ARCHIVE_FULL_PATH"

grep -v '^#' "$CONFIG_FILE" | grep -v '^$' | tar -czvPf "$ARCHIVE_FULL_PATH" --ignore-failed-read --files-from=-

#Check tar Success

if [[ $? -ne 0 ]]; then
    log "ERROR: tar command failed to create the archive properly. Check output above."
    exit 1
fi

log "SUCCESS: Configuration backup complete!"
log "SUCCESS: Archive created at: $ARCHIVE_FULL_PATH"
exit 0







# Later we might add: /etc/ssh/sshd_config /etc/hosts /etc/resolv.conf etc.

# --- Backup Logic ---
# Create the destination directory if it doesn't exist
# The -p option ensures no error if it already exists and creates parent dirs if needed.

mkdir -p "$BACKUP_DEST"
# Generate a timestamp for the filename 

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

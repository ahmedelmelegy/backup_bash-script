# Backup and Restore Script

This project contains two scripts, `backup.sh` and `restore.sh`, that provide functionality for performing backups and restores of directories using tar, gzip, and GPG encryption.

## Usage

### Backup Script

The `backup.sh` script creates a backup of directories and files in the specified source directory. It supports encryption and can backup only the modified files within a specified number of days.

#### Usage:

```bash
./backup.sh source_path destination_path encryption_key num_days
```
- source_path: The path to the directory that needs to be backed up.
- destination_path: The path to the directory where the backup should be stored.
- encryption_key: The encryption key used to encrypt the backup.
- num_days: The number of days to consider for backing up only the modified files.

### Backup Script

The `restore.sh` script Restores the backup by decrypting and extracting the files in reverse order.

#### Usage:

```bash
./restore.sh backup_directory destination_directory decryption_key
```

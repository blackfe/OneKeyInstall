#!/bin/bash
####################################
#
# Backup to NFS mount script.
#
####################################

# What to backup. 
backup_files="/etc"

# Where to backup to.
dest="/mnt/backup"
if [ ! -d $dest]; then
    mkdir $dest
fi

# Create archive filename.
day=$(date +%F_%H_%M_%S)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar -cvpzf  $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
old_path=`pwd`
cd $dest

python3 $old_path/backup-and-restore-example.py  --mode Backup --filename $archive_file


rm /mnt/backup/* -rf

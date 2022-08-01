# Daily-Backup-Using-Shell-Scripting

Accessing files on servers, and backup those that were updated within the last 24-hours introduces human error, lowers security, and takes an unreasonable amount of work.
Using Linux a script "backup.sh" can be created which automatically backs up any of these files that have been updated within the past 24 hours.

Using "crontab" , a schedule of the script can be created to backup a folder every 24 hours to new directory: 0 0 * * * /usr/local/bin/backup.sh

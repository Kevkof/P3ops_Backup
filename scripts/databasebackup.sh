#!/bin/bash
#database credentials
 user="november1"
 password="november1"
 host="172.16.128.5"
 db_name="mike1DB"
# Other options
 backup_path="/vagrant/databases"
 date=$(date +"%d-%b-%Y")
# Set default file permissions
 umask 177
# Dump database into SQL file
 mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql


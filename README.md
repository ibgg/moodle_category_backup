# Moodle Category Backup
This script generates backups of courses given a category name

## Prerequisites
Give execute permissions to the script:
`chmod +x backup.sh`

Setup a config file including your database credentials and moodle config. You can copy the CONFIG file and replace your setup

`$cp CONFIG.EXAMPLE CONFIG`

Then, you shoud put your setup:
`DBUSER=moodle_db_user
DBNAME=moodle_db_name
DBPASS=moodle_db_password
MOODLE_DATA_DIR=moodle_data_dir
MOODLE_DIR=moodle_home_dir
`

## Run
`./backup.sh --category "category_name"`

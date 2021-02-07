#!/bin/bash

#Setup Config
source CONFIG

MOODLE_CLI_DIR=$MOODLE_DIR/admin/cli
OUTPUT_FOLDER=$MOODLE_DATA_DIR/backups
OUPUT_FILENAME=courseids.txt
IFS=$'\n'

CATEGORY_SQL=`mysql -u $DBUSER -p"$DBPASS" -e "use $DBNAME;select id from mdl_course_categories where name LIKE '%$2%'"`
CATEGORY_ID=$(echo $CATEGORY_SQL | cut -d' ' -f 2)
mysql -u $DBUSER -p"$DBPASS" -e "use $DBNAME;select CONCAT_WS('|',id,fullname) from mdl_course where category=$CATEGORY_ID" > $OUPUT_FILENAME

# Lets create category folder
if [[ -e $2 ]]
then
    echo "Directory $OUTPUT_FOLDER/$2 exists."
else
    echo "Directory $2 does not exists, lets create it."
	mkdir -pv "$OUTPUT_FOLDER/$2"
fi

COURSES_LIST=`tail -n +2 ./$OUPUT_FILENAME`

for course in `tail -n +2 ./$OUPUT_FILENAME`
do
    coursename=$(echo $course | cut -d'|' -f 2)
	courseid=$(echo $course | cut -d'|' -f 1)
    printf "\n=== Lets backup course: $coursename ID: $courseid... ==="
    php $MOODLE_CLI_DIR/backup.php --courseid=$courseid --destination=$OUTPUT_FOLDER/$2
done

rm $OUPUT_FILENAME
echo "=== Category $2 backup Finished ==="

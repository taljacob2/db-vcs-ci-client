#!/bin/sh

LOG_TITLE="### export-db.sh ###: "
LOG_BOUNDARY="#######################"

echo
echo $LOG_BOUNDARY
echo $LOG_TITLE "Attempting To Export DB From Server..."

echo $LOG_TITLE "Attempting To Create .bak File In The Server..."

echo $LOG_TITLE "SHOWING OUTPUT FROM SERVER:"

echo
curl -k -X 'POST' \
            'https://localhost:7179/api/execute-cmd-command?workingDirectory=C:\Bak' \
            -H 'accept: */*' \
            -H 'Content-Type: application/sql' \
            -d @git-config-setup/db-vcs-ci/export-db/export-db-sql-query.bat
echo


echo $LOG_TITLE "DONE SHOWING OUTPUT FROM SERVER."
echo $LOG_TITLE "Export DB Process Finished."
echo $LOG_BOUNDARY
echo

exit
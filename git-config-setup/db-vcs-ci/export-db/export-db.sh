#!/bin/sh

COMPUTER_NAME="(localdb)"
INSTANCE_NAME="Local"
DB_NAME="Klil-Local-Tal"
WORKING_DIRECTORY="C:\Bak"
EXPORTED_DB_BAK_NAME="db.bak"
SERVER="https://localhost:7179"

# -----------------------------------------------------------------------------

function surroundWithSingleQuotes {
  args
    : @required string sourceStringToSurround

  surroundWithSingleQuotes_RETURN_VALUE=\'"${sourceStringToSurround}"\'
  echo $surroundWithSingleQuotes_RETURN_VALUE
}

surroundWithSingleQuotes
# -----------------------------------------------------------------------------


LOG_TITLE="### export-db.sh ###: "
LOG_BOUNDARY="################################"
SERVER_LOG_HALF_BOUNDARY="###########"

URL=$SERVER
echo \'"$URL"\'

echo
echo $LOG_BOUNDARY
echo $LOG_TITLE "Attempting To Export DB From Server..."

echo $LOG_TITLE "Attempting To Create .bak File In The Server..."

echo $LOG_TITLE $SERVER_LOG_HALF_BOUNDARY OPENED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

echo
curl -k -X 'POST' \
            'https://localhost:7179/api/execute-cmd-command?workingDirectory=${WORKING_DIRECTORY}' \
            -H 'accept: */*' \
            -H 'Content-Type: application/sql' \
            -d "@git-config-setup/db-vcs-ci/export-db/export-db-sql-query.bat $COMPUTER_NAME $INSTANCE_NAME $DB_NAME $WORKING_DIRECTORY"
echo

echo $LOG_TITLE $SERVER_LOG_HALF_BOUNDARY CLOSED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY
echo
echo $LOG_TITLE "Export DB Process Finished."
echo $LOG_BOUNDARY
echo

exit
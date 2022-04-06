#!/bin/sh

LOG_TITLE="### export-db.sh ###: "
LOG_BOUNDARY="#######################"

echo
echo $LOG_BOUNDARY
echo $LOG_TITLE "Exporting DB..."
echo

curl -k -X 'POST' \
  'https://localhost:7179/api/execute-a-export-db-sql' \
  -H 'accept: */*' \
  -H 'Content-Type: application/sql' \
  -d @git-config-setup/db-vcs-ci/export-db/export-db-sql-query.bat

echo
echo $LOG_TITLE "Export DB Process Finished."
echo $LOG_BOUNDARY
echo
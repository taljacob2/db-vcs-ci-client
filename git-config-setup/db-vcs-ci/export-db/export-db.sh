#!/bin/sh

LOG_TITLE="### export-db.sh ###: "
LOG_BOUNDARY="#######################"

echo
echo $LOG_BOUNDARY
echo $LOG_TITLE "Exporting DB..."
echo
# curl -k -d @git-config-setup/db-vcs-ci/export-db/export-db.sql https://localhost:7179/api/execute-a-export-db-sql
curl -k https://localhost:7179/api/script
echo
echo $LOG_TITLE "Export DB Process Finished."
echo $LOG_BOUNDARY
echo
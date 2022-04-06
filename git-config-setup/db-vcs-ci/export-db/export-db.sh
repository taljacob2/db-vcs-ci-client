#!/bin/sh

LOG_TITLE="### export-db.sh ###: "
LOG_BOUNDARY="#######################"

echo
echo $LOG_BOUNDARY
echo $LOG_TITLE "Attempting To Export DB From Server..."
echo

status_code=$(curl -k -X 'POST' \
              'https://localhost:7179/api/execute-a-export-db-sql?pathToExportBakInServer=C:\Bak\db.bak' \
              -H 'accept: */*' \
              -H 'Content-Type: application/sql' \
              -d @git-config-setup/db-vcs-ci/export-db/export-db-sql-query.bat \
              --output git-config-setup/db-vcs-ci/db.bak \
              --write-out %{http_code})
echo

if [[ "$status_code" -ne 200 ]] ; then
  echo $LOG_TITLE "Encountered An Error."
else
    echo $LOG_TITLE "Received .bak File Successfully!"
    echo $LOG_TITLE "Adding The .bak File To Your Commit..."
    git add git-config-setup/db-vcs-ci/db.bak
    echo $LOG_TITLE "Finished Adding The .bak File To Your Commit."
fi

echo
echo $LOG_TITLE "Export DB Process Finished."
echo $LOG_BOUNDARY
echo
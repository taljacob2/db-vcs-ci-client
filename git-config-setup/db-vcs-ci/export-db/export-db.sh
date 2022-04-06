#!/bin/sh

LOG_TITLE="### export-db.sh ###: "
LOG_BOUNDARY="#######################"

echo
echo $LOG_BOUNDARY
echo $LOG_TITLE "Exporting DB..."
echo

status_code=$(curl -k -X 'POST' \
              'https://localhost:7179/api/execute-a-export-db-sql?pathToExportBakInServer=C:\Bak\db.bak' \
              -H 'accept: */*' \
              -H 'Content-Type: application/sql' \
              -d @git-config-setup/db-vcs-ci/export-db/export-db-sql-query.bat \
              --output git-config-setup/db-vcs-ci/db.bak \
              --write-out %{http_code})

if [[ "$status_code" -ne 200 ]] ; then
  echo $LOG_TITLE "Encountered an error."
else
    echo $LOG_TITLE "Received .bak file successfully!"
    echo $LOG_TITLE "Adding the .bak file to your commit..."
    git add git-config-setup/db-vcs-ci/db.bak
    echo $LOG_TITLE "Finished adding the .bak file to your commit."
fi

echo
echo $LOG_TITLE "Export DB Process Finished."
echo $LOG_BOUNDARY
echo
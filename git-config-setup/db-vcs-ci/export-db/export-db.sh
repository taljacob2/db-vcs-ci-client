#!/bin/sh

LOG_TITLE="### export-db.sh ###: "
LOG_BOUNDARY="#######################"

echo
echo $LOG_BOUNDARY
echo $LOG_TITLE "Attempting To Export DB From Server..."

echo $LOG_TITLE "Attempting To Create .bak File In The Server..."

echo
status_code=$(curl -k -X 'POST' \
              'https://localhost:7179/api/execute-a-export-db-sql?pathToExportBakInServer=C:\Bak\db.bak' \
              -H 'accept: */*' \
              -H 'Content-Type: application/sql' \
              -d @git-config-setup/db-vcs-ci/export-db/export-db-sql-query.bat \
              --write-out %{http_code})
echo

if [[ "$status_code" -ne 200 ]] ; then
  echo $LOG_TITLE "Encountered An Error."
else
    echo $LOG_TITLE "Successfully Created .bak File In The Server!"
    echo $LOG_TITLE "Attempting To Download .bak File From Server..."

    echo
    status_code=$(curl -k -X 'GET' \
                  -H 'accept: */*' \
                  'https://localhost:7179/api/download-file?filePathInServer=C:\Bak\db.bak&mimeType=application/octet-stream' \
                  --output git-config-setup/db-vcs-ci/db.bak \
                  --write-out %{http_code})
    echo

    if [[ "$status_code" -ne 200 ]] ; then
      echo $LOG_TITLE "Encountered An Error."
    else
        echo $LOG_TITLE "Received .bak File Successfully!"

        # Create a dummy file for indication that the "pre-commit" process has finished,
        # and the files were not commited yet.
        touch git-config-setup/db-vcs-ci/export-db/.commit
    fi
fi


echo
echo $LOG_TITLE "Export DB Process Finished."
echo $LOG_BOUNDARY
echo

exit
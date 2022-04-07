#!/bin/sh

# ---------------------------- Basic Settings ---------------------------------

COMPUTER_NAME="(localdb)"
INSTANCE_NAME="Local"
DB_NAME="Klil-Local-Tal"
EXPORTED_DB_BAK_PATH_IN_CLIENT="git-config-setup/db-vcs-ci/db.bak"

# ------------------------ Server Advaced Settings ----------------------------

WORKING_DIRECTORY_IN_SERVER="C:\Bak"
EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY="db.bak"
SERVER="https://localhost:7179"

# ---------------------------------- Code -------------------------------------

LOG_TITLE="### export-db.sh ###: "
LOG_BOUNDARY="################################"
SERVER_LOG_HALF_BOUNDARY="###########"

echo
echo $LOG_BOUNDARY
echo $LOG_TITLE "Attempting To Export DB From Server..."

echo $LOG_TITLE "Attempting To Create .bak File In The Server..."

echo $LOG_TITLE $SERVER_LOG_HALF_BOUNDARY OPENED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

echo

URL="$SERVER/api/execute-cmd-command?workingDirectory=$WORKING_DIRECTORY_IN_SERVER"

curl -k -X 'POST' \
              $URL \
              -H 'accept: */*' \
              -H 'Content-Type: application/sql' \
              -d @git-config-setup/db-vcs-ci/export-db/export-db-sql-query.bat \
              -o %{http_code} out.txt

echo

if [[ "$status_code" -ne 200 ]] ; then
    echo $LOG_TITLE "Encountered An Error."
else
    echo $LOG_TITLE "Successfully Created .bak File In The Server!"
    echo $LOG_TITLE "Attempting To Download .bak File From Server..."

    echo

    URL="$SERVER/api/download-file?filePathInServer=$WORKING_DIRECTORY_IN_SERVER/$EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY&mimeType=application/octet-stream"

    curl -k -X 'GET' \
                  -H 'accept: */*' \
                  $URL \
                  --output git-config-setup/db-vcs-ci/db.bak \
                  --write-out %{http_code}

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

echo $LOG_TITLE $SERVER_LOG_HALF_BOUNDARY CLOSED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY
echo
echo $LOG_TITLE "Export DB Process Finished."
echo $LOG_BOUNDARY
echo

exit
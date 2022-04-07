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

HTTP_RESPONSE=$(curl -k -X 'POST' \
                $URL \
                -H 'accept: */*' \
                -H 'Content-Type: application/sql' \
                -d @git-config-setup/db-vcs-ci/export-db/export-db-sql-query.bat \
                --write-out "HTTPSTATUS:%{http_code}" \
                -o http-response.txt)

HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')
HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

echo

echo $HTTP_BODY

echo

if [[ "$HTTP_STATUS" -ne 200 ]] ; then
    echo $LOG_TITLE "Encountered An Error."
else
    echo $LOG_TITLE "Successfully Created .bak File In The Server!"
    echo $LOG_TITLE "Attempting To Download .bak File From Server..."

    echo

    URL="$SERVER/api/download-file?filePathInServer=$WORKING_DIRECTORY_IN_SERVER/$EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY&mimeType=application/octet-stream"

    HTTP_RESPONSE=$(curl -k -X 'GET' \
                    -H 'accept: */*' \
                    $URL \
                    -o $EXPORTED_DB_BAK_PATH_IN_CLIENT \
                    --write-out "HTTPSTATUS:%{http_code}")

    HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')
    HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

    echo

    echo $HTTP_BODY

    echo

    if [[ "$HTTP_STATUS" -ne 200 ]] ; then
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

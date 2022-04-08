#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-setup.sh

# ---------------------------------- Code -------------------------------------

LOG_TITLE="### pre-commit-export-db.sh ###: "
SERVER_LOG_HALF_BOUNDARY="##########################"

echo

# echo $LOG_BOUNDARY

echo $LOG_TITLE "Attempting To Export DB From Server..."

echo $LOG_TITLE "Attempting To Create .bak File In The Server..."

echo $SERVER_LOG_HALF_BOUNDARY OPENED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

echo

URL="$SERVER/api/execute-cmd-command?workingDirectory=$WORKING_DIRECTORY_IN_SERVER"

RESPONSE_FILE_NAME=last-response-from-server.txt

RESPONSE_FILE_PATH=$EXPORT_DB_FOLDER_PATH/$RESPONSE_FILE_NAME

# 1. Create a file if not already created.
# 2. Empty the file if already contains content from last response.
touch $RESPONSE_FILE_PATH
truncate -s 0 $RESPONSE_FILE_PATH

HTTP_RESPONSE=$(curl -k -X 'POST' \
                $URL \
                -H 'accept: */*' \
                -H 'Content-Type: text/plain' \
                -d @$EXPORT_DB_FOLDER_PATH/export-db-sql-query.bat \
                --write-out "HTTPSTATUS:%{http_code}" \
                -o $RESPONSE_FILE_PATH)

cat $RESPONSE_FILE_PATH

HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')

echo

echo $SERVER_LOG_HALF_BOUNDARY CLOSED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

if [[ "$HTTP_STATUS" -ne 200 ]] ; then
    echo $LOG_TITLE "Encountered An Error."
else
    echo $LOG_TITLE "Successfully Executed Command In The Server!"
    
    echo $LOG_TITLE "Attempting To Download .bak File From Server..."

    echo $SERVER_LOG_HALF_BOUNDARY OPENED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

    echo

    URL="$SERVER/api/download-file?filePathInServer=$WORKING_DIRECTORY_IN_SERVER/$EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY&mimeType=application/octet-stream"

    HTTP_RESPONSE=$(curl -k -X 'GET' \
                    -H 'accept: */*' \
                    $URL \
                    -o $EXPORTED_DB_BAK_PATH_IN_CLIENT \
                    --write-out "HTTPSTATUS:%{http_code}")

    HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')

    echo

    echo $SERVER_LOG_HALF_BOUNDARY CLOSED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

    if [[ "$HTTP_STATUS" -ne 200 ]] ; then
      echo $LOG_TITLE "Encountered An Error."
    else
        echo $LOG_TITLE "Received .bak File Successfully!"

        # Create a dummy file for indication that the "pre-commit" process has finished,
        # and the files were not commited yet.
        touch $EXPORT_DB_FOLDER_PATH/.commit
    fi
fi

echo

echo $LOG_TITLE "Export DB Process Finished."

exit
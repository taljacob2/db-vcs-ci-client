#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-intern-config.sh

# ---------------------------------- Code -------------------------------------

LOG_TITLE="### pre-commit-export-db.sh ###: "
SERVER_LOG_HALF_BOUNDARY="##########################"

echo

echo $LOG_BOUNDARY

echo $LOG_TITLE "Attempting To Export DB From Server..."

echo $LOG_TITLE "Attempting To Create '.bak' File In The Server..."

echo $SERVER_LOG_HALF_BOUNDARY OPENED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

echo

URL="$SERVER/api/execute-cmd-command?workingDirectory=$WORKING_DIRECTORY_IN_SERVER"

COMMAND_FILE_CONTENT=`cat $EXPORT_DB_FOLDER_PATH/cmd-command-for-windows-server.bat`
COMMAND_FILE_PARAMETERS_CONTENT=`cat $EXPORT_DB_FOLDER_PATH/cmd-command-for-windows-server-parameters.bat`

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
                -d "$COMMAND_FILE_CONTENT" \
                -d "$COMMAND_FILE_PARAMETERS_CONTENT" \
                -w "HTTPSTATUS:%{http_code}" \
                -o $RESPONSE_FILE_PATH)

cat $RESPONSE_FILE_PATH

HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')

echo

echo $SERVER_LOG_HALF_BOUNDARY CLOSED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

if [[ "$HTTP_STATUS" -ne 200 ]] ; then
    echo $LOG_TITLE $ERROR_MESSAGE $HTTP_STATUS
else
    echo $LOG_TITLE "Successfully Executed Command In The Server!"
    
    echo $LOG_TITLE "Attempting To Download '.bak' File From Server..."

    echo $SERVER_LOG_HALF_BOUNDARY OPENED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

    echo

    URL="$SERVER/api/download-file?filePathInServer=$WORKING_DIRECTORY_IN_SERVER/$EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY&mimeType=application/octet-stream"

    EXPORTED_DB_BAK_PATH_IN_CLIENT="$DB_VCS_CI_FOLDER_PATH/$EXPORTED_DB_BAK_NAME_IN_CLIENT"

    # Download to a "ghost" '.bak', so if the response returns with an error it
    # won't affect the good '.bak' we already have.
    GHOST_EXPORTED_DB_BAK_PATH_IN_CLIENT="$DB_VCS_CI_FOLDER_PATH/ghost_$EXPORTED_DB_BAK_NAME_IN_CLIENT"

    HTTP_RESPONSE=$(curl -k -X 'GET' \
                    -H 'accept: */*' \
                    $URL \
                    -o $GHOST_EXPORTED_DB_BAK_PATH_IN_CLIENT \
                    -w "HTTPSTATUS:%{http_code}")

    HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')

    echo

    echo $SERVER_LOG_HALF_BOUNDARY CLOSED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

    if [[ "$HTTP_STATUS" -ne 200 ]] ; then
        echo $LOG_TITLE $ERROR_MESSAGE $HTTP_STATUS
    else
        echo $LOG_TITLE "Successfully Downloaded '.bak' File!"

        # Create a dummy file for indication that the "pre-commit" process has finished successfully.
        # This may be useful for the "post-commit" hook.
        touch $PRE_COMMIT_SUCCESS_DUMMY_FILE_PATH

        # Overwrite our old '.bak' file if exists.
        # rm $EXPORTED_DB_BAK_PATH_IN_CLIENT
        cp -f $GHOST_EXPORTED_DB_BAK_PATH_IN_CLIENT $EXPORTED_DB_BAK_PATH_IN_CLIENT

        echo $LOG_TITLE "Adding The '.bak' File To Your Index..."

        RESULT=$?
        git add $EXPORTED_DB_BAK_PATH_IN_CLIENT
        if [ $RESULT -ne 0 ]
            then
            echo $ERROR_MESSAGE
        else        
            echo $LOG_TITLE "Successfully Added The '.bak' File To Your Index!"
        fi        
    fi

    # Remove "ghost" '.bak'
    rm $GHOST_EXPORTED_DB_BAK_PATH_IN_CLIENT
fi

echo $LOG_BOUNDARY

echo

exit
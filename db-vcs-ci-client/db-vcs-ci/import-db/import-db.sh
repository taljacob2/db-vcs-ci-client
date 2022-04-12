#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-intern-config.sh

# ---------------------------------- Code -------------------------------------

LOG_TITLE="### import-db.sh ###: "
SERVER_LOG_HALF_BOUNDARY="##########################"

echo

echo $LOG_BOUNDARY

echo $LOG_TITLE "Attempting To Import DB To Server..."

echo $LOG_TITLE "Deleting The Last Imported '.bak' File To Server (If Exists)..."

echo $SERVER_LOG_HALF_BOUNDARY OPENED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

echo

URL="$SERVER/api/execute-cmd-command?workingDirectory=$WORKING_DIRECTORY_IN_SERVER"

FILE_CONTENT=`cat $IMPORT_DB_FOLDER_PATH/cmd-command1-for-windows-server.bat`

HTTP_RESPONSE=$(curl -k -X 'POST' \
                $URL \
                -H 'accept: */*' \
                -H 'Content-Type: text/plain' \
                -d "$FILE_CONTENT" \
                -d "ARGS[]=$WORKING_DIRECTORY_IN_SERVER&ARGS[]=$IMPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY" \
                -w "HTTPSTATUS:%{http_code}")

HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')

echo

echo $SERVER_LOG_HALF_BOUNDARY CLOSED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

if [[ "$HTTP_STATUS" -ne 200 ]] ; then
    echo $LOG_TITLE $ERROR_MESSAGE HTTP_STATUS: $HTTP_STATUS
else
    echo $LOG_TITLE "Successfully Executed Command In The Server!"
    
    echo $LOG_TITLE "Attempting To Upload '.bak' File To Server..."

    echo $SERVER_LOG_HALF_BOUNDARY OPENED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

    echo

    EXPORTED_DB_BAK_PATH_IN_CLIENT="$DB_VCS_CI_FOLDER_PATH/$EXPORTED_DB_BAK_NAME_IN_CLIENT"
    IMPORTED_DB_BAK_PATH_IN_CLIENT=$EXPORTED_DB_BAK_PATH_IN_CLIENT

    FILE_CONTENT=`cat $IMPORTED_DB_BAK_PATH_IN_CLIENT`

    : '
    Upload to a "ghost" `.bak`, so if the response returns with an error it
    won`t affect the good `.bak` the server already has.
    '
    GHOST_IMPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY="ghost_$IMPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY"

    URL="$SERVER/api/upload-file?workingDirectory=$WORKING_DIRECTORY_IN_SERVER&fileNameToBeInServerWorkingDirectory=$GHOST_IMPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY"

    HTTP_RESPONSE=$(curl -k -X 'POST' \
                    $URL \
                    -H 'accept: */*' \
                    -H 'Content-Type: application/octet-stream' \
                    -d "$FILE_CONTENT" \
                    -w "HTTPSTATUS:%{http_code}")

    HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -E 's/.*HTTPSTATUS:([0-9]{3})$/\1/')

    echo

    echo $SERVER_LOG_HALF_BOUNDARY CLOSED OUTPUT FROM SERVER $SERVER_LOG_HALF_BOUNDARY

    if [[ "$HTTP_STATUS" -ne 201 ]] ; then
        echo $LOG_TITLE $ERROR_MESSAGE HTTP_STATUS: $HTTP_STATUS
    # else
    #     echo $LOG_TITLE "Successfully Downloaded '.bak' File!"

    #     # Create a dummy file for indication that the "pre-commit" process has finished successfully.
    #     # This may be useful for the "post-commit" hook.
    #     touch $PRE_COMMIT_SUCCESS_DUMMY_FILE_PATH

    #     # Overwrite our old '.bak' file if exists.
    #     # rm $EXPORTED_DB_BAK_PATH_IN_CLIENT
    #     cp -f $GHOST_EXPORTED_DB_BAK_PATH_IN_CLIENT $EXPORTED_DB_BAK_PATH_IN_CLIENT

    #     echo $LOG_TITLE "Adding The '.bak' File To Your Index..."

    #     RESULT=$?
    #     git add $EXPORTED_DB_BAK_PATH_IN_CLIENT
    #     if [ $RESULT -ne 0 ]
    #         then
    #         echo $ERROR_MESSAGE
    #     else        
    #         echo $LOG_TITLE "Successfully Added The '.bak' File To Your Index!"
    #     fi        
    fi

    # # Remove "ghost" '.bak'
    # rm $GHOST_EXPORTED_DB_BAK_PATH_IN_CLIENT
fi

echo $LOG_BOUNDARY

echo

exit
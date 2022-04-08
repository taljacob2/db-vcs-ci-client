#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-intern-config.sh

# ---------------------------------- Code -------------------------------------

LOG_TITLE="### post-commit-export-db.sh ###: "

echo

# In case there is an on-going execution to export the db.
if [ -e $EXPORT_DB_FOLDER_PATH/.commit ]
    then
    rm $EXPORT_DB_FOLDER_PATH/.commit


    # Get to code.  Exit if unsaved changes in repo
    if `git status db-vcs-ci-client/db-vcs-ci/db.bak | grep -q "nothing to commit"`; then
        echo GOOD
    else
        echo BAD
    fi



    # echo $LOG_TITLE "Adding The '.bak' File To Your Commit..."

    # RESULT=$?
    # git add $EXPORTED_DB_BAK_PATH_IN_CLIENT
    # if [ $RESULT -ne 0 ]
    #     then
    #     echo $ERROR_MESSAGE
    # else        
    #     echo $LOG_TITLE "Successfully Added The '.bak' File To Your Commit!"
    #     git commit --amend -C HEAD --no-verify
    # fi
fi

# echo $LOG_BOUNDARY

exit
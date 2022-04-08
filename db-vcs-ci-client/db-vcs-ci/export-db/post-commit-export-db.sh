#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-setup.sh

# ---------------------------------- Code -------------------------------------

LOG_TITLE="### post-commit-export-db.sh ###: "

echo

# In case there is an on-going execution to export the db.
if [ -e $EXPORT_DB_FOLDER_PATH/.commit ]
    then
    rm $EXPORT_DB_FOLDER_PATH/.commit

    echo $LOG_TITLE "Adding The .bak File To Your Commit..."
    git add $EXPORTED_DB_BAK_PATH_IN_CLIENT
    echo $LOG_TITLE "Successfully Added The .bak File To Your Commit!"
    git commit --amend -C HEAD --no-verify
fi

# echo $LOG_BOUNDARY

exit
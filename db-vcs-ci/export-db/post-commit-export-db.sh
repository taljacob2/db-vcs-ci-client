#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-intern-config.sh

# ---------------------------------- Code -------------------------------------

LOG_TITLE="### post-commit-export-db.sh ###: "

# echo

# In case there is an on-going execution to export the db.
if [ -e $PRE_COMMIT_SUCCESS_DUMMY_FILE_PATH ]
    then
    rm $PRE_COMMIT_SUCCESS_DUMMY_FILE_PATH

    ### Add Content Here...
fi

# echo $LOG_BOUNDARY

exit
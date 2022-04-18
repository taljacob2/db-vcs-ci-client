#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-intern-config.sh

# ---------------------------------- Code -------------------------------------

./$EXPORT_DB_FOLDER_PATH/post-commit-export-db.sh

exit
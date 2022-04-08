#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-setup.sh

# ---------------------------------- Code -------------------------------------

./$EXPORT_DB_FOLDER_PATH/post-commit-export-db.sh

exit
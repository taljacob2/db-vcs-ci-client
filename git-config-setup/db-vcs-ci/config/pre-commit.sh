#!/bin/sh

source git-config-setup/db-vcs-ci/config/db-vcs-ci-setup.sh

git stash -q --keep-index

# ---------------------------------- Code -------------------------------------

./$EXPORT_DB_FOLDER_PATH/pre-commit-export-db.sh

# -----------------------------------------------------------------------------

RESULT=$?
git stash pop -q
[ $RESULT -ne 0 ] && exit 1
exit 0
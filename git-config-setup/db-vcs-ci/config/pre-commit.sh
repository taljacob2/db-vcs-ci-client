#!/bin/sh
git stash -q --keep-index

# ------------------------ Intern DB-VCS-CI Settings --------------------------

DB_VCS_CI_FOLDER_PATH=git-config-setup/db-vcs-ci

# ---------------------------------- Code -------------------------------------

./$DB_VCS_CI_FOLDER_PATH/config/db-vcs-ci-setup.sh

./$EXPORT_DB_FOLDER_PATH/export-db.sh

# -----------------------------------------------------------------------------

RESULT=$?
git stash pop -q
[ $RESULT -ne 0 ] && exit 1
exit 0
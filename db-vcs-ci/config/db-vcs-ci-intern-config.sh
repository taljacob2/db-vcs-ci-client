#!/bin/sh

source db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-settings.sh

# ------------------------ DB-VCS-CI Intern Config --------------------------

DB_VCS_CI_FOLDER_PATH=db-vcs-ci-client/db-vcs-ci
EXPORT_DB_FOLDER_PATH=$DB_VCS_CI_FOLDER_PATH/export-db
IMPORT_DB_FOLDER_PATH=$DB_VCS_CI_FOLDER_PATH/import-db

EXPORTED_DB_BAK_PATH_IN_CLIENT="$DB_VCS_CI_FOLDER_PATH/$EXPORTED_DB_BAK_NAME_IN_CLIENT"

LOG_BOUNDARY="###############################################################################"
ERROR_MESSAGE="Encountered An Error."

PRE_COMMIT_SUCCESS_DUMMY_FILE_PATH=$EXPORT_DB_FOLDER_PATH/.pre-commit-has-finished-successfully
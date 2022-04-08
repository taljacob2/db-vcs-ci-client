#!/bin/sh

# ------------------------ Intern DB-VCS-CI Settings --------------------------

DB_VCS_CI_FOLDER_PATH=db-vcs-ci-client/db-vcs-ci
EXPORT_DB_FOLDER_PATH=$DB_VCS_CI_FOLDER_PATH/export-db
IMPORT_DB_FOLDER_PATH=$DB_VCS_CI_FOLDER_PATH/import-db

LOG_BOUNDARY="###############################################################################"

# ---------------------------- Basic Settings ---------------------------------

COMPUTER_NAME="(localdb)"
INSTANCE_NAME="Local"
DB_NAME="Klil-Local-Tal"
EXPORTED_DB_BAK_PATH_IN_CLIENT="$DB_VCS_CI_FOLDER_PATH/db.bak"

# ------------------------ Server Advanced Settings ---------------------------

WORKING_DIRECTORY_IN_SERVER="C:\Bak"
EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY="db.bak"
SERVER="https://localhost:7179"

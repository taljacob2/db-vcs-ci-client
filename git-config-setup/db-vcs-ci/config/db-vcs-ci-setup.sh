#!/bin/sh

# ---------------------------- Basic Settings ---------------------------------

COMPUTER_NAME="(localdb)"
INSTANCE_NAME="Local"
DB_NAME="Klil-Local-Tal"
EXPORTED_DB_BAK_PATH_IN_CLIENT="git-config-setup/db-vcs-ci/db.bak"

# ------------------------ Server Advanced Settings ---------------------------

WORKING_DIRECTORY_IN_SERVER="C:\Bak"
EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY="db.bak"
SERVER="https://localhost:7179"

# ------------------------ Intern DB-VCS-CI Settings --------------------------

EXPORT_DB_FOLDER_PATH=$DB_VCS_CI_FOLDER_PATH/export-db
IMPORT_DB_FOLDER_PATH=$DB_VCS_CI_FOLDER_PATH/import-db

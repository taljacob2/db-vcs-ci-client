#!/bin/sh

LOG_TITLE="### export-db.sh ###: "

echo "#######################"
echo $LOG_TITLE "Exporting DB..."
curl -d @git-config-setup/db-vcs-ci/export-db/export-db.sql https://localhost:7179/api/upload-export-db-sql
echo $LOG_TITLE "Export DB Process Finished."
echo "#######################"
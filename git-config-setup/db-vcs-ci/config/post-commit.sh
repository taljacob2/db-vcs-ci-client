#!/bin/sh
if [ -e git-config-setup/db-vcs-ci/export-db/.commit ]
    then
    rm git-config-setup/db-vcs-ci/export-db/.commit

    echo $LOG_TITLE "Adding The .bak File To Your Commit..."
    git add git-config-setup/db-vcs-ci/db.bak
    echo $LOG_TITLE "Finished Adding The .bak File To Your Commit."
    git commit --amend -C HEAD --no-verify
fi
exit
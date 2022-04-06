#!/bin/sh
if [ -e .commit ]
    then
    rm .commit
    
    echo $LOG_TITLE "Adding The .bak File To Your Commit..."
    git add git-config-setup/db-vcs-ci/db.bak
    echo $LOG_TITLE "Finished Adding The .bak File To Your Commit."
    git commit --amend -C HEAD --no-verify
fi
exit
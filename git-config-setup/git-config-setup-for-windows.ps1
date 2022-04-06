git config merge.keepTheirs.driver "./git-config-setup/merge-driver/keepTheirs.sh %O %A %B"
git config merge.keepMine.driver "./git-config-setup/merge-driver/keepMine.sh %O %A %B"

copy git-config-setup/db-vcs-ci/export-db/pre-commit.sh .git/hooks/pre-commit
copy git-config-setup/db-vcs-ci/export-db/post-commit.sh .git/hooks/post-commit

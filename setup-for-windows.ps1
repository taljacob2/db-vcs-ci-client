git config merge.keepTheirs.driver "./db-vcs-ci-client/merge-driver/keepTheirs.sh %O %A %B"
git config merge.keepMine.driver "./db-vcs-ci-client/merge-driver/keepMine.sh %O %A %B"

copy db-vcs-ci-client/db-vcs-ci/config/pre-commit.sh .git/hooks/pre-commit
copy db-vcs-ci-client/db-vcs-ci/config/post-commit.sh .git/hooks/post-commit

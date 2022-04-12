# merge-driver
git config merge.keepTheirs.driver "./db-vcs-ci-client/merge-driver/keepTheirs.sh %O %A %B"
git config merge.keepMine.driver "./db-vcs-ci-client/merge-driver/keepMine.sh %O %A %B"

# db-vcs-ci: config
ln -s db-vcs-ci-client/db-vcs-ci/config/pre-commit.sh .git/hooks/pre-commit
ln -s db-vcs-ci-client/db-vcs-ci/config/post-commit.sh .git/hooks/post-commit

# db-vcs-ci: import-db
git config alias.import-db "!sh ./db-vcs-ci-client/db-vcs-ci/import-db/import-db.sh"
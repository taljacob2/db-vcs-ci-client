git config merge.keepTheirs.driver "./git-config-setup/merge-driver/keepTheirs.sh %O %A %B"
git config merge.keepMine.driver "./git-config-setup/merge-driver/keepMine.sh %O %A %B"

ln -s git-config-setup/db-vcs-ci/config/pre-commit.sh .git/hooks/pre-commit
ln -s git-config-setup/db-vcs-ci/config/post-commit.sh .git/hooks/post-commit

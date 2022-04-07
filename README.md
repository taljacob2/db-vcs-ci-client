# db-vcs-ci-client

## Installation

### On Windows:

Open *powershell.exe* and run:
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; git-config-setup/git-config-setup-for-windows.ps1
```

### On Linux:

Open *terminal* and run:
```
./git-config-setup/git-config-setup-for-linux.sh
```

## NOTE

The backup runs as a "pre-commit" hook.
Means, after you run `git commit`, but before the actual commit process.

In case you don't want to backup the database in your commit,
then you can skip the backuping process with:
```
git commit --no-verify
```

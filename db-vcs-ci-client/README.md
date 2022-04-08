# db-vcs-ci-client

## Installation

Copy the current [`db-vcs-ci-client` folder](../db-vcs-ci-client/) to the root folder of your project, and follow the following instructions:

### On Windows:

Open *powershell.exe* and run:
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; db-vcs-ci-client/setup-for-windows.ps1
```

### On Linux:

Open *terminal* and run:
```
./db-vcs-ci-client/setup-for-linux.sh
```

## NOTE

The backup runs as a "pre-commit" hook.
Means, after you run `git commit`, but before the actual commit process.

In case you don't want to backup the database in your commit,
then you can skip the backuping process with:
```
git commit --no-verify
```

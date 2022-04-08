# db-vcs-ci-client

"db-vcs-ci" is a tool to automatically backup your database along your code, and inserts the backups to your commits,
so you could source-control the backups of your database.

### Export Database

Right after you commit your files via
```
git commit
```

"db-vcs-ci" executes a sql command on the server which the database is located on, that:
1. Exports a backup `.bak` file of the database.
1. Downloads it from the server to your actual working-directory.
1. And finally adds it to your commit.

So the database you are working on will be automatically backed-up to your source-code.
The default settings set the `.bak` file to be placed at: [db-vcs-ci-client//db-vcs-ci/db.bak](../db-vcs-ci-client//db-vcs-ci/db.bak).

### Import Database

Also, "db-vcs-ci" is able to use a backup `.bak` file you already own, to import it staight into the server's database.
This can be done by running:
```
git import-db
```

## Installation

Copy the current [`db-vcs-ci-client`](../db-vcs-ci-client/) folder to the root folder of your project, and follow the following instructions:

### On Windows

Open *powershell.exe* and run:
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; db-vcs-ci-client/setup-for-windows.ps1
```

### On Linux

Open *terminal* and run:
```
./db-vcs-ci-client/setup-for-linux.sh
```

## Using "db-vcs-ci"

"db-vcs-ci" would backup your database automatically, when you make the `git commit` command, and will insert the `.bak` file to your commit.

### Skip Backup

The backup runs as a "pre-commit" hook.
Means, after you run `git commit`, but before the actual commit process.

In case you don't want to backup the database in your commit,
then you can skip the backuping process with:
```
git commit --no-verify
```

### Change Settings

You can change the settings of "db-vcs-ci" in the [`db-vcs-ci-settings.sh`](../db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-settings.sh) file.

# db-vcs-ci-client

"db-vcs-ci" is a tool that automatically backups your database along your code, and inserts the backups to your commits,
so you could source-control the backups of your database.

The default sql commands that come with "db-vcs-ci" extract / import a MSSQL database that uses [SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15) and is run on *Windows Server 2012 R2*,
but you can edit the sql commands to be any commands, for any database.

![db-vcs-ci-client-export-db](https://user-images.githubusercontent.com/70590583/162724024-abac3bd3-b005-4453-b58d-c0ba2ba73b81.gif)

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
The default settings set the `.bak` file to be placed at: [db-vcs-ci-client/db-vcs-ci/db.bak](../db-vcs-ci-client/db-vcs-ci/db.bak).
You can change the settings [here](#change-settings).

#### Screenshot Example

![image](https://user-images.githubusercontent.com/70590583/162546023-2594372a-4317-4282-9b69-f159d03642d7.png)

#### Skip Exporting A Backup

The backup runs as a "pre-commit" hook.
Means, after you run `git commit`, but before the actual commit process.

In case you don't want to backup the database in your commit,
then you can skip the backuping process with:
```
git commit --no-verify
```

### Import Database

Also, "db-vcs-ci" is able to use a backup `.bak` file you already own, to import it staight into the server's database.
This can be done by running:
```
git import-db
```

### Change Settings

You can change the settings of "db-vcs-ci" in the [`db-vcs-ci-settings.sh`](../db-vcs-ci-client/db-vcs-ci/config/db-vcs-ci-settings.sh) file.

## FAQ

### Export Database

#### Q:
AFter exporting, I am receiving the following output:
```
Msg 916, Level 14, State 1, Server WBX-VPS-P42\SQLEXPRESS, Line 1
The server principal "IIS APPPOOL\dbvcsci.example.com" is not able to access the database "KlilDBCore" under the current security context.
Msg 3013, Level 16, State 1, Server WBX-VPS-P42\SQLEXPRESS, Line 1
BACKUP DATABASE is terminating abnormally.
```
#### A:
The IIS app that runs the "sqlcmd" command doesn't have credentials for managing the database.
You should create a new "SQL Server Authentication" user in your SSMS, so your IIS app could use it to export the database through "sqlcmd".
1. Follow this [video](https://www.youtube.com/watch?v=qfuK0V1tlrA) for doing so.
1. Navigate to [`db-vcs-ci/export-db/cmd-command-for-windows-server.bat`](./db-vcs-ci/export-db/cmd-command-for-windows-server.bat) and add the credentials you have made to the "sqlcmd" command, like the following template:
   ```bat
   -U USERNAME -P PASSWORD
   ```
   For example:
   ```bat
   del /f %3\%4 >nul 2>&1
   sqlcmd -S %1 -U db-vcs-ci -P pass123456 -Q "BACKUP DATABASE [%2] TO DISK = '%3\%4'"
   ```

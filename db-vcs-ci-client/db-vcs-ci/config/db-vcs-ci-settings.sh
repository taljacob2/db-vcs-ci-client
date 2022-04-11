#!/bin/sh

# WARNING: Do not choose paths or names that contain white-spaces.

# ---------------------------- Basic Settings ---------------------------------

: '
For example:

- "(localdb)\\Local"
- "(localdb)\\MSSQLDBLocal"
- localhost:
  - "."
  - ".\\"
  - "localhost"
  - "localhost\\"
'
COMPUTER_NAME_SLASH_INSTANCE_NAME="localhost"

DB_NAME="KlilDBCore"

EXPORTED_DB_BAK_NAME_IN_CLIENT="db.bak"

# ------------------------ Server Advanced Settings ---------------------------

: '
WARNING: Make sure that `WORKING_DIRECTORY_IN_SERVER` was NOT created in the
         server manually. It should be created by "db-vcs-ci" "export-db" process.
         
         OR: You may create `WORKING_DIRECTORY_IN_SERVER` in the server manually,
             but make sure that the "db-vcs-ci-server" app will have permission to
             manage it.
'
WORKING_DIRECTORY_IN_SERVER="C:\Bak"

: '
If there are many "db-vcs-ci-clients" that use this database,
and they all have the same `WORKING_DIRECTORY_IN_SERVER` name,
it is recommended (but not mandatory) to choose a unique name for
`EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY`, so in the working-directory
of the server the backups of all the contributors that use it will be presented.

For example:

- "taljacob-db.bak"
- "johndoe-db.bak"
- "richardroe-db.bak"
'
EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY="taljacob-db.bak"

SERVER="https://dbvcsci.trustech.co.il"

# SERVER="https://localhost:7179"  # For development with "db-vcs-ci-server".

# USERNAME=""  # For powershell "Get-Credentials" - currently in alpha

# PASSWORD=""  # For powershell "Get-Credentials" - currently in alpha

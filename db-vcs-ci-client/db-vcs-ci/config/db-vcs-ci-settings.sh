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

# SERVER="https://dbvcsci.trustech.co.il"
SERVER="https://localhost:7179"

USER="tal"

PASSWORD="129729tal"

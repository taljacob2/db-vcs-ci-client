# Currently in alpha

# ------------------------------- Credentials  --------------------------------

$pass = ConvertTo-SecureString $args[5] -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($args[4], $pass)
Get-Credential -Credential $credential

# ---------------------------------- Code -------------------------------------

echo "-------------------------------------"

# Remove-Item C:\Bak\taljacob-db.bak
$WORKING_DIRECTORY_IN_SERVER = $args[2]
$EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY = $args[3]
Remove-Item $WORKING_DIRECTORY_IN_SERVER\$EXPORTED_DB_BAK_NAME_IN_SERVER_WORKING_DIRECTORY
# sqlcmd -S $args[0] -U db-vcs-ci -P Trust1234! -Q "BACKUP DATABASE [$args[1]] TO DISK = '$args[2]\$args[3]'"

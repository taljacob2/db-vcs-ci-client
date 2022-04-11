# ------------------------------- Credentials  --------------------------------

$pass = ConvertTo-SecureString $args[5] -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($args[4], $pass)
Get-Credential -Credential $credential

# ---------------------------------- Code -------------------------------------

echo "-------------------------------------"

Remove-Item $args[2]\$args[3]
# sqlcmd -S $args[0] -U db-vcs-ci -P Trust1234! -Q "BACKUP DATABASE [$args[1]] TO DISK = '$args[2]\$args[3]'"

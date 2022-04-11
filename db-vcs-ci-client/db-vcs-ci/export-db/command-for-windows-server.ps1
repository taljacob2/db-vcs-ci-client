# ------------------------------- Credentials  --------------------------------

$pass = ConvertTo-SecureString $args[4] -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($args[5], $pass)
Get-Credential -Credential $credential

# ---------------------------------- Code -------------------------------------

echo hello
# ------------------------------- Credentials  --------------------------------

$pass = ConvertTo-SecureString $args[5] -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($args[6], $pass)
Get-Credential -Credential $credential

# ---------------------------------- Code -------------------------------------

echo hello
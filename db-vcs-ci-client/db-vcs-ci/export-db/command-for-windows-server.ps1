# ------------------------------- Credentials  --------------------------------

$password=$args[5]
$username=$args[6]
$pass = ConvertTo-SecureString $password -AsPlainText -Force

echo $password
echo $username

# $credential = New-Object System.Management.Automation.PSCredential ($username, $pass)
# Get-Credential -Credential $credential

# ---------------------------------- Code -------------------------------------

echo hello
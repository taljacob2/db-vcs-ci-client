# ------------------------------- Credentials  --------------------------------


$username=$args[5]
$password="$args"
$pass = ConvertTo-SecureString $password -AsPlainText -Force

echo $username
echo $password

# $credential = New-Object System.Management.Automation.PSCredential ($username, $pass)
# Get-Credential -Credential $credential

# ---------------------------------- Code -------------------------------------

echo hello
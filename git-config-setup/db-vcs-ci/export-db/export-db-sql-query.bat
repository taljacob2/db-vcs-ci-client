mkdir C:\Bak && 
sqlcmd -S (localdb)\Local -Q "BACKUP DATABASE [Klil-Local-Tal] TO DISK = 'C:\Bak\db.bak'" && 
copy C:\Bak\db.bak C:\Code\db-vcs-ci-client\git-config-setup\db-vcs-ci\db.bak && 
PAUSE
del /f C:\Bak\db.bak
sqlcmd -S (localdb)\Local -Q "BACKUP DATABASE [Klil-Local-Tal] TO DISK = 'C:\Bak\db.bak'"
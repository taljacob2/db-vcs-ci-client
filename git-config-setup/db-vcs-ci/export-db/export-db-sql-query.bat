mkdir C:\Bak &
sqlcmd -S (localdb)\Local -Q "BACKUP DATABASE [Klil-Local-Tal] TO DISK = 'C:\Bak\db.bak'" && 
move C:\Bak\db.bak C:\Theoretical-Server-Backend\db.bak && 
PAUSE
del /f %4\%5 >nul 2>&1
sqlcmd -S %1\%2 -Q "BACKUP DATABASE [%3] TO DISK = '%4\%5'"
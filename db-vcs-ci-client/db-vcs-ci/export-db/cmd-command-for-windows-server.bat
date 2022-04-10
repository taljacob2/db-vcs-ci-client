whoami
del /f %3\%4 >nul 2>&1
sqlcmd -S %1 -U WBX-VPS-P42\trustech -P Trust1234! -Q "BACKUP DATABASE [%2] TO DISK = '%3\%4'"
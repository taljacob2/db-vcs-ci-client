del /f %3\%4 >nul 2>&1
runas /user:WBX-VPS-P42\trustech sqlcmd -S %1 -Q "BACKUP DATABASE [%2] TO DISK = '%3\%4'"
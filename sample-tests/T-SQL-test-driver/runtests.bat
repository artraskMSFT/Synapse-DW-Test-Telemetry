
REM serverDNS = %1
REM poolname = %2


REM adminuser = %3
REM adminpwd = %4

REM testuser = %5
REM testpwd = %6


sqlcmd -S %1 -d master -I -U %3 -P %4 -i C:\Users\artrask\scale-dw.sql -v DBName="%2" -v DWU="DW400c" 


sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_droprolemember 'largerc', '%5'; EXEC sp_droprolemember 'mediumrc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="smallrc" -v DWU="400" -v CacheState="Cold" 1> NUL

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="smallrc" -v DWU="400" -v CacheState="Warm" 1> NUL

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_addrolemember 'mediumrc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="mediumrc" -v DWU="400" -v CacheState="Warm" 1> NUL


sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_addrolemember 'largerc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="largerc" -v DWU="400" -v CacheState="Warm" 1> NUL


sqlcmd -S %1 -d master -I -U %3 -P %4 -i C:\Users\artrask\scale-dw.sql -v DBName="%2" -v DWU="DW300c" 


sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_droprolemember 'largerc', '%5'; EXEC sp_droprolemember 'mediumrc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="smallrc" -v DWU="300" -v CacheState="Cold" 1> NUL

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="smallrc" -v DWU="300" -v CacheState="Warm" 1> NUL

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_addrolemember 'mediumrc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="mediumrc" -v DWU="300" -v CacheState="Warm" 1> NUL


sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_addrolemember 'largerc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="largerc" -v DWU="300" -v CacheState="Warm" 1> NUL


sqlcmd -S %1 -d master -I -U %3 -P %4 -i C:\Users\artrask\scale-dw.sql -v DBName="%2" -v DWU="DW200c" 


sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_droprolemember 'largerc', '%5'; EXEC sp_droprolemember 'mediumrc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="smallrc" -v DWU="200" -v CacheState="Cold" 1> NUL

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="smallrc" -v DWU="200" -v CacheState="Warm" 1> NUL

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_addrolemember 'mediumrc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="mediumrc" -v DWU="200" -v CacheState="Warm" 1> NUL


sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_addrolemember 'largerc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="largerc" -v DWU="200" -v CacheState="Warm" 1> NUL


sqlcmd -S %1 -d master -I -U %3 -P %4 -i C:\Users\artrask\scale-dw.sql -v DBName="%2" -v DWU="DW100c" 


sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_droprolemember 'largerc', '%5'; EXEC sp_droprolemember 'mediumrc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="smallrc" -v DWU="100" -v CacheState="Cold" 1> NUL

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="smallrc" -v DWU="100" -v CacheState="Warm" 1> NUL

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_addrolemember 'mediumrc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="mediumrc" -v DWU="100" -v CacheState="Warm" 1> NUL


sqlcmd -S %1 -d %2 -I -U %5 -P %6 -Q "EXEC sp_addrolemember 'largerc', '%5';"

sqlcmd -S %1 -d %2 -I -U %5 -P %6 -i C:\Users\artrask\source\repos\Synapse-DW-Test-Telemetry\sample-tests\T-SQL-test-driver\AdvWorks-TestDriver-sqlcmd.sql -v ResourceClass="largerc" -v DWU="100" -v CacheState="Warm" 1> NUL


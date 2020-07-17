
ALTER DATABASE [$(DBName)] MODIFY (SERVICE_OBJECTIVE = '$(DWU)');

WHILE
(
    SELECT TOP 1 state_desc
    FROM sys.dm_operation_status
    WHERE
        1=1
        AND resource_type_desc = 'Database'
        AND major_resource_id = '$(DBName)'
        AND operation = 'ALTER DATABASE'
    ORDER BY
        start_time DESC
) = 'IN_PROGRESS'
BEGIN
    PRINT 'Scale operation in progress';
    WAITFOR DELAY '00:00:15';
END
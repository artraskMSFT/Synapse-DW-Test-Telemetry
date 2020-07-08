/*
DELETE telemetry.SynapseTestWorkload 
DELETE telemetry.TestCase 
DELETE telemetry.SynapseTestPass
*/

--Create Workload Header Record
INSERT INTO telemetry.SynapseTestWorkload (WorkloadID, Name, Description, AdditionalInfo) VALUES
(1, 'Sales Analytics Test Cases', 'Customer-defined sales analysis test cases for benchmarking DW', 'Expected to be run with test data set XYZ v1.2');
GO


--Insert individual test cases that make up the workload
DECLARE @NewRowId uniqueidentifier;

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 1, 1, 1, 'CTAS', '01-CTAS_RPT.sql', 400);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 2, 1, 2, 'INSERT Supplemental Data', '02-INSERT_SELECT_FROM.sql', 500);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 3, 1, 3, 'Agg by Month', '03-DELETE_WHERE.sql', 700);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 4, 1, 4, 'Agg by Region', '04-INSERT_SELECT.sql', 3100);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 5, 1, 5, 'Agg by Sales Manager', '05-DELETE_WHERE.sql', 857);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 6, 1, 6, 'In-place Update', '06-INSERT_SELECT.sql', 4340);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 7, 1, 7, 'Scoped Delete', '07-DELETE_WHERE.sql', 250);

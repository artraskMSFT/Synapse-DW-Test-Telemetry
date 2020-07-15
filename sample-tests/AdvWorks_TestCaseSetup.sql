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
(@NewRowId, 1, 1, 1, 'CTAS', '01-CTAS_RPT.sql', 1400);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 2, 1, 2, 'Count Reseller Sales', '02-COUNT_RESELLER_SALES.sql', 500);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 3, 1, 3, 'Category Summary', '03-SELECT_CATEGORY.sql', 700);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 4, 1, 4, 'Agg by Region', '04-GET_SALES_AGG.sql', 3100);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 5, 1, 5, 'Agg Sales by Date', '05-SALES_BY_DATE.sql', 857);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 6, 1, 6, 'Sales Analysis', '06-SALES_QUERIES.sql', 4340);

SET @NewRowId = NEWID();
INSERT INTO telemetry.TestCase (TestCaseID, TestCaseNum, WorkloadId, ExecutionOrder, TestCaseName, SqlFileName, DurationTargetInMs) VALUES
(@NewRowId, 7, 1, 7, 'Count Internet Sales', '07-COUNT_INTERNET_SALES.sql', 250);

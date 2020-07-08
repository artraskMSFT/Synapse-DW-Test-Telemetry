
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = N'usp_logtestpass_start' AND schema_id = SCHEMA_ID('telemetry'))
	DROP PROCEDURE telemetry.usp_logtestpass_start
GO
CREATE PROC [telemetry].[usp_logtestpass_start] @WorkloadId [int], @DWU [int], @CacheState [varchar](50), @OptLevel [varchar](50), @ScriptMods [varchar](50), @ResourceClass [nvarchar](20), @ConcurrentOrSerial [nvarchar](20), @test_pass_id [int] OUT AS
BEGIN

    BEGIN TRANSACTION 

	DECLARE @NewRowId int
	SET @NewRowId = (SELECT 1 + ISNULL(MAX(TestPassID),0) FROM telemetry.SynapseTestPass)

	DECLARE @now datetime2 = getdate();


	INSERT telemetry.SynapseTestPass (TestPassID, WorkloadId, StartTime, DWU, CacheState, OptLevel, ScriptMods, ResourceClass, ConcurrentOrSerial, HasErrors)
	VALUES (@NewRowId, @WorkloadId, @now, @DWU, @CacheState, @OptLevel, @ScriptMods, @ResourceClass, @ConcurrentOrSerial, 0);

	SET @test_pass_id = @NewRowId;

	COMMIT
END
GO

/****** Object:  StoredProcedure [telemetry].[usp_logtestrun_start]    Script Date: 4/2/2020 9:41:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = N'usp_logtestrun_start' AND schema_id = SCHEMA_ID('telemetry'))
	DROP PROCEDURE telemetry.usp_logtestrun_start
GO
CREATE PROC [telemetry].[usp_logtestrun_start] @TestPassID [int], @TestCaseNum [int], @test_run_id [uniqueidentifier] OUT AS
BEGIN

	DECLARE @WorkloadId int;
	DECLARE @TestCaseId uniqueidentifier;
	SELECT @WorkloadId = WorkloadID FROM telemetry.SynapseTestPass WHERE TestPassID = @TestPassID;
	SELECT @TestCaseId = TestCaseID FROM telemetry.TestCase WHERE TestCaseNum = @TestCaseNum AND WorkloadId = @WorkloadId;


	DECLARE @NewRowId uniqueidentifier;
	--SET @NewRowId = (SELECT 1 + ISNULL(MAX(ID),500) FROM telemetry.TestCaseRun)
	SET @NewRowId = NEWID();

	DECLARE @now datetime2 = getdate();


	INSERT telemetry.TestCaseRun (TestCaseRunID, TestPassID, TestCaseId, StartTime)
	VALUES (@NewRowId, @TestPassID, @TestCaseId, @now);

	SET @test_run_id = @NewRowId;

END
GO



/****** Object:  StoredProcedure [telemetry].[usp_logtest_end]    Script Date: 4/2/2020 9:41:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = N'usp_logtestrun_end' AND schema_id = SCHEMA_ID('telemetry'))
	DROP PROCEDURE telemetry.usp_logtestrun_end
GO
CREATE PROC [telemetry].[usp_logtestrun_end] @TestCaseRunID [uniqueidentifier], @ErrorInfo [varchar](4096) AS
BEGIN

    BEGIN TRANSACTION 

	DECLARE @start_time datetime2;
	SELECT @start_time = StartTime FROM telemetry.TestCaseRun WHERE TestCaseRunID = @TestCaseRunID;

	UPDATE telemetry.TestCaseRun SET EndTime = getdate(), ErrorInfo = @ErrorInfo WHERE TestCaseRunID = @TestCaseRunID;

	INSERT [telemetry].[TestCaseRunStatements]
	SELECT @TestCaseRunID,
			[request_id],
			[session_id],
			[status],
			[submit_time],
			[start_time],
			[end_compile_time],
			[end_time],
			[total_elapsed_time],
			[label],
			[error_id],
			[database_id],
			[command],
			[resource_class],
			[importance],
			[group_name],
			[classifier_name],
			[resource_allocation_percentage],
			[result_cache_hit]
	FROM sys.dm_pdw_exec_requests
	WHERE submit_time >= @start_time
	 AND  [session_id] = SESSION_ID()  --assumes that this sproc is being called by the same session/connection tha tran the test case(s)
	 AND  [label] IS NOT NULL --assumes that since this is a structured test, all statements of interest have labels

	COMMIT
END
GO


/****** Object:  StoredProcedure [telemetry].[usp_logtestpass_end]    Script Date: 4/2/2020 9:41:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = N'usp_logtestpass_end' AND schema_id = SCHEMA_ID('telemetry'))
	DROP PROCEDURE telemetry.usp_logtestpass_end
GO
CREATE PROC [telemetry].[usp_logtestpass_end] @test_pass_id [int] AS
BEGIN

	DECLARE @HasErrors bit = 0;
	IF EXISTS (SELECT * FROM telemetry.TestCaseRun WHERE TestPassID = @test_pass_id AND ErrorInfo IS NOT NULL)
		SET @HasErrors = 1
	
	UPDATE telemetry.SynapseTestPass
	SET EndTime = getdate(),
		HasErrors = @HasErrors
	WHERE TestPassID = @test_pass_id 

END

GO


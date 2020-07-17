
/* TO BE RUN IN SQLCMD MODE */

:SETVAR ScriptPath "C:\faketestcases\"

--:SETVAR DWU 400
--:SETVAR CacheState Warm
:SETVAR OptLevel "Stage 1"
:SETVAR ScriptMods "v1.0"
--:SETVAR ResourceClass "smallrc"


:SETVAR WorkloadId 1


declare @workload_id int;
declare @pass_id int;
declare @run_id uniqueidentifier;
declare @err_info varchar(4096);


/*
	LOG START OF TEST PASS
*/
exec telemetry.usp_logtestpass_start $(WorkloadId), $(DWU), '$(CacheState)', '$(OptLevel)', '$(ScriptMods)', '$(ResourceClass)', 'Serial', @pass_id OUTPUT


exec telemetry.usp_logtestrun_start @TestPassID = @pass_id, @TestCaseNum = 1, @test_run_id = @run_id OUTPUT
BEGIN TRY
	:R $(ScriptPath)\01-CTAS_RPT.sql
	exec telemetry.usp_logtestrun_end @run_id, NULL
END TRY
BEGIN CATCH
	SET  @err_info = 'ErrorNumber: ' + CONVERT(varchar, ERROR_NUMBER()) + ' | ErrorSeverity: ' + CONVERT(varchar, ERROR_SEVERITY()) + ' | ErrorState: ' + CONVERT(varchar, ERROR_STATE())+ ' | ErrorProcedure: ' + COALESCE(ERROR_PROCEDURE(), '<none>') + ' | ErrorMessage: ' + ERROR_MESSAGE();
	exec telemetry.usp_logtestrun_end @run_id, @err_info;
	SET @err_info = NULL;
END CATCH


exec telemetry.usp_logtestrun_start @TestPassID = @pass_id, @TestCaseNum = 2, @test_run_id = @run_id OUTPUT
BEGIN TRY
	:R $(ScriptPath)\02-COUNT_RESELLER_SALES.sql
	exec telemetry.usp_logtestrun_end @run_id, NULL
END TRY
BEGIN CATCH
	SET  @err_info = 'ErrorNumber: ' + CONVERT(varchar, ERROR_NUMBER()) + ' | ErrorSeverity: ' + CONVERT(varchar, ERROR_SEVERITY()) + ' | ErrorState: ' + CONVERT(varchar, ERROR_STATE())+ ' | ErrorProcedure: ' + COALESCE(ERROR_PROCEDURE(), '<none>') + ' | ErrorMessage: ' + ERROR_MESSAGE();
	exec telemetry.usp_logtestrun_end @run_id, @err_info;
	SET @err_info = NULL;
END CATCH



exec telemetry.usp_logtestrun_start @TestPassID = @pass_id, @TestCaseNum = 3, @test_run_id = @run_id OUTPUT
BEGIN TRY
	:R $(ScriptPath)\03-SELECT_CATEGORY.sql
	exec telemetry.usp_logtestrun_end @run_id, NULL
END TRY
BEGIN CATCH
	SET  @err_info = 'ErrorNumber: ' + CONVERT(varchar, ERROR_NUMBER()) + ' | ErrorSeverity: ' + CONVERT(varchar, ERROR_SEVERITY()) + ' | ErrorState: ' + CONVERT(varchar, ERROR_STATE())+ ' | ErrorProcedure: ' + COALESCE(ERROR_PROCEDURE(), '<none>') + ' | ErrorMessage: ' + ERROR_MESSAGE();
	exec telemetry.usp_logtestrun_end @run_id, @err_info;
	SET @err_info = NULL;
END CATCH


exec telemetry.usp_logtestrun_start @TestPassID = @pass_id, @TestCaseNum = 4, @test_run_id = @run_id OUTPUT
BEGIN TRY
	:R $(ScriptPath)\04-GET_SALES_AGG.sql
	exec telemetry.usp_logtestrun_end @run_id, NULL
END TRY
BEGIN CATCH
	SET  @err_info = 'ErrorNumber: ' + CONVERT(varchar, ERROR_NUMBER()) + ' | ErrorSeverity: ' + CONVERT(varchar, ERROR_SEVERITY()) + ' | ErrorState: ' + CONVERT(varchar, ERROR_STATE())+ ' | ErrorProcedure: ' + COALESCE(ERROR_PROCEDURE(), '<none>') + ' | ErrorMessage: ' + ERROR_MESSAGE();
	exec telemetry.usp_logtestrun_end @run_id, @err_info;
	SET @err_info = NULL;
END CATCH


exec telemetry.usp_logtestrun_start @TestPassID = @pass_id, @TestCaseNum = 5, @test_run_id = @run_id OUTPUT
BEGIN TRY
	:R $(ScriptPath)\05-SALES_BY_DATE.sql
	exec telemetry.usp_logtestrun_end @run_id, NULL
END TRY
BEGIN CATCH
	SET  @err_info = 'ErrorNumber: ' + CONVERT(varchar, ERROR_NUMBER()) + ' | ErrorSeverity: ' + CONVERT(varchar, ERROR_SEVERITY()) + ' | ErrorState: ' + CONVERT(varchar, ERROR_STATE())+ ' | ErrorProcedure: ' + COALESCE(ERROR_PROCEDURE(), '<none>') + ' | ErrorMessage: ' + ERROR_MESSAGE();
	exec telemetry.usp_logtestrun_end @run_id, @err_info;
	SET @err_info = NULL;
END CATCH


exec telemetry.usp_logtestrun_start @TestPassID = @pass_id, @TestCaseNum = 6, @test_run_id = @run_id OUTPUT
BEGIN TRY
	:R $(ScriptPath)\06-SALES_QUERIES.sql
	exec telemetry.usp_logtestrun_end @run_id, NULL
END TRY
BEGIN CATCH
	SET  @err_info = 'ErrorNumber: ' + CONVERT(varchar, ERROR_NUMBER()) + ' | ErrorSeverity: ' + CONVERT(varchar, ERROR_SEVERITY()) + ' | ErrorState: ' + CONVERT(varchar, ERROR_STATE())+ ' | ErrorProcedure: ' + COALESCE(ERROR_PROCEDURE(), '<none>') + ' | ErrorMessage: ' + ERROR_MESSAGE();
	exec telemetry.usp_logtestrun_end @run_id, @err_info;
	SET @err_info = NULL;
END CATCH


exec telemetry.usp_logtestrun_start @TestPassID = @pass_id, @TestCaseNum = 7, @test_run_id = @run_id OUTPUT
BEGIN TRY
	:R $(ScriptPath)\07-COUNT_INTERNET_SALES.sql
	exec telemetry.usp_logtestrun_end @run_id, NULL
END TRY
BEGIN CATCH
	SET  @err_info = 'ErrorNumber: ' + CONVERT(varchar, ERROR_NUMBER()) + ' | ErrorSeverity: ' + CONVERT(varchar, ERROR_SEVERITY()) + ' | ErrorState: ' + CONVERT(varchar, ERROR_STATE())+ ' | ErrorProcedure: ' + COALESCE(ERROR_PROCEDURE(), '<none>') + ' | ErrorMessage: ' + ERROR_MESSAGE();
	exec telemetry.usp_logtestrun_end @run_id, @err_info;
	SET @err_info = NULL;
END CATCH


/*
	LOG END OF TEST PASS
*/
exec telemetry.usp_logtestpass_end @pass_id

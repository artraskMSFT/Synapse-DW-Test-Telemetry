--CREATE SCHEMA [telemetry]
--GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = N'SynapseTestWorkload' AND schema_id = SCHEMA_ID('telemetry'))
	DROP TABLE [telemetry].[SynapseTestWorkload]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [telemetry].[SynapseTestWorkload]
(
	[WorkloadID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](256) NULL,
	[AdditionalInfo] [varchar](8000) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = N'SynapseTestPass' AND schema_id = SCHEMA_ID('telemetry'))
	DROP TABLE [telemetry].[SynapseTestPass]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [telemetry].[SynapseTestPass]
(
	[TestPassID] [int] NOT NULL,
	[WorkloadID] int NOT NULL,
	[StartTime] [datetime2](7) NOT NULL,
	[EndTime] [datetime2](7) NULL,
	[DWU] [int] NOT NULL,
	[CacheState] [varchar](50) NOT NULL,
	[OptLevel] [varchar](50) NOT NULL,
	[ScriptMods] [varchar](50) NOT NULL,
	[ResourceClass] [nvarchar](20) NULL,
	[ConcurrentOrSerial] [nvarchar](20) NOT NULL, -- 'Serial' or 'Concurrent'
	[HasErrors] [bit] NOT NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = N'TestCase' AND schema_id = SCHEMA_ID('telemetry'))
	DROP TABLE [telemetry].[TestCase]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [telemetry].[TestCase]
(
	[TestCaseID] [uniqueidentifier] NOT NULL, --surrogate key to play nice with Power BI expectation of a single-column join
	[TestCaseNum] [int] NOT NULL,
	[WorkloadID] [int] NOT NULL,
	[ExecutionOrder] [int] NOT NULL,
	[TestCaseName] [varchar](100) NOT NULL,
	[SqlFileName] [varchar](256) NOT NULL,
	[DurationTargetInMs] int NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = N'TestCaseRun' AND schema_id = SCHEMA_ID('telemetry'))
	DROP TABLE [telemetry].[TestCaseRun]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [telemetry].[TestCaseRun]
(
	[TestCaseRunID] [uniqueidentifier] NOT NULL,
	[TestPassID] [int] NOT NULL,
	[TestCaseID] [uniqueidentifier] NOT NULL, --using artificial SK for relationship to TestCase table since Power BI requires single-column relationship
	[StartTime] [datetime2](7) NOT NULL,
	[EndTime] [datetime2](7) NULL,
	[ErrorInfo] [varchar](8000) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = N'TestCaseRunStatements' AND schema_id = SCHEMA_ID('telemetry'))
	DROP TABLE [telemetry].[TestCaseRunStatements]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [telemetry].[TestCaseRunStatements]
(
	[TestCaseRunID] [uniqueidentifier] NOT NULL,
	[request_id] [nvarchar](32) NULL,
	[session_id] [nvarchar](32) NULL,
	[status] [nvarchar](32) NULL,
	[submit_time] [datetime] NULL,
	[start_time] [datetime] NULL,
	[end_compile_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[total_elapsed_time] [int] NULL,
	[label] [nvarchar](255) NULL,
	[error_id] [nvarchar](36) NULL,
	[database_id] [int] NULL,
	[command] [nvarchar](4000) NULL,
	[resource_class] [nvarchar](20) NULL,
	[importance] [nvarchar](128) NULL,
	[group_name] [nvarchar](128) NULL,
	[classifier_name] [nvarchar](128) NULL,
	[resource_allocation_percentage] [decimal](5, 2) NULL,
	[result_cache_hit] [bit] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO

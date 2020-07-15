# Synapse-DW-Test-Telemetry
The Synapse Test Telemetry framework is a lightweight set of tables and stored procedures that make it easy to instrument Synapse performance tests or benchmarks.

You may be performing a competitive DW benchmark, a POC with/for a customer, or pre-deployment testing.  In all these cases, the importance of consistent measurement cannot be overstated.  And, the ability to easily visualize and analyze performance, perhaps through multiple changes in configuration or optimization, is extremely valuable.

This framework provides a pre-built and tested mechanism for capturing test execution times and reporting/analyzing them.  In particular, comparison over multiple iterations of optimization, configuration changes, or resizing is made very easy.  The framework also captures a detailed log of each statement run as part of your tests for later analysis (from sys.dm_pdw_exec_requests).

Finally, Power BI visuals, either pre-built or customized for your purpose, provide a powerful way to communicate your work to customers.

Conceptually, the Test Telemetry framework simply supports the logging of test durations, capturing start/end time for each step in a test, error information, and the content of sys.dm_pdw_exec_requests associated with each step in your tests.  It also captures descriptive attributes such as DW size, resource class, optimization level, and versions of your T-SQL so that you can slice-and-dice performance as these things change.

The picture below captures the intended use of the framework.  The way tests are driven is up to you, and can vary by scenario.  For any method of driving tests, simply wire in a few calls to the framework stored procedures, and the metrics needed for consistent measurement and analysis are captured.

![alt tag](assets/concept-lg.png)

Besides two scripts to create the framework in your target Synapse DW, this repository includes two example test drivers. 

Example #1 is a SQL script which drives tests and is meant to be run in SSMS or Azure Data Studio in SQLCMD mode.

Example #2 is a very simple C# console application that drives series of test scripts.

To drive more full-featured testing, you can also use [Adam Paternostro's Synapse Test Runner](https://github.com/AdamPaternostro/Azure-SQL-DW-Synapse-Test-Case-Runner) available in this repo.  The Synapse Test Runner supports both serial and multi-connection concurrent tests against Synapse, and it logs timings with the Test Telemetry Framework.

Finally, this repo includes a starting Power BI report template that you can connect to your target DW and refresh to show your timings.  This report has some nice visualizations to examine the results of your tests.  But, it should be considered a tool more than a finished product.  Modify or add to the report to support your own understanding of your workload's performance, and to communicate results in the most effective way to your customer.

## Terminology

The tables, procs, and reports used in the framework use the following terminology to describe tests.  There is no single right set of terms that could be used; these are the ones used by this framework.

Test Case - a single test to be run and measured as a unit.  The test could be a single query or it could be many queries that make a logical whole.  Queries that make up one test case are often contained in one SQL script file, but this is not required.

Workload - a collection of Test Cases that comprise one testing scenario.  In many cases, only one workload needs to be defined.  Sometimes though, you may want to test and report on multiple workloads.  For example, a Sales Analytics workload, a Nightly Batch workload, and a Bulk Data Load workload might be distinct parts of your benchmark test.  Each of these workloads would be made up of one or more Test Cases and could be analyzed independently.

Test Pass - this is one execution of a workload, for which timings are captured.

Test Case Run - one execution of a Test Case, with captured start time, end time, and other attributes.  A Test Pass is made up of Test Case Runs for each Test Case.




## Assumptions

### All SQL Statements Should use a Label
To aid in accurate capture of SQL run in your tests, the framework looks for statements in sys.dm_pdw_exec_requests which have a non-NULL label (session id and time range are also used).

Therefore, by convention, every statement in your test cases should have a label using the T-SQL OPTION (LABEL = 'xxxxxx') clause.  

If desired, this assumption can be removed by commenting one line from the WHERE clause in one of the framework stored procedures (usp_logtestrun_end).




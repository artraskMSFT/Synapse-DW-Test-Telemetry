using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using SynapseTestTelemetry;
using System.IO;

namespace SynapseTestDriver
{
    class Program
    {
        static void Main(string[] args)
        {

            //These test parameters could be from command line args, config file, or dynamically assigned
            int workloadId = 1;
            string DWU = "200";
            string cascheState = "Warm";
            string optLevel = "Stage 1";
            string scriptMods = "v2.0";
            string resourceClass = "smallrc";


            string connString = ConfigurationManager.ConnectionStrings["targetSynapseDW"].ConnectionString;
            string scriptPath = ConfigurationManager.AppSettings["sqlScriptPath"];

            if (scriptPath == null)
                throw new ArgumentException("The sqlScriptPath config value is missing");

            if (!Directory.Exists(scriptPath))
                throw new ArgumentException("The configured sqlScriptPath does not exist on the local machine. ({0})", scriptPath);

            List<TestCaseInfo> tests = TelemetrySqlHelper.GetTestCases(connString, 1);
            TelemetrySqlHelper.LogTestPassStart(connString, workloadId, DWU, cascheState, optLevel, scriptMods, resourceClass, "Serial");

            TelemetrySqlHelper helper = new TelemetrySqlHelper();

            SqlConnection conn = new SqlConnection(connString);
            string testRunId = null;

            try
            {
                conn.Open();

                foreach (TestCaseInfo test in tests)
                {
                    Console.WriteLine("Running test number {0}: '{1}'", test.TestCaseNum, test.TestCaseName);
                    testRunId = helper.LogTestRunStart(conn, test.TestCaseNum);


                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = conn;
                        cmd.CommandText = File.ReadAllText(Path.Combine(scriptPath, test.SqlFileName));
                        cmd.ExecuteNonQuery();

                        helper.LogTestRunEnd(conn, testRunId, null);
                    }
                }
            }
            catch (SqlException e)
            {
                helper.LogTestRunEnd(conn, testRunId, e);
            }
            finally
            {
                conn.Close();
                conn.Dispose();
            }

            TelemetrySqlHelper.LogTestPassEnd(connString);


            Console.ReadLine();
        }
    }
}

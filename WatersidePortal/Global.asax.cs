using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace WatersidePortal
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        public static bool hasPermission(string user, string permission)
        {
            //select from database
            //Command
            //connection.Open();

            //SqlDataReader reader = command.ExecuteReader();

            //while (reader.Read())
            {
                // if read == permission
                {
                    //return read == 1
                }
            }
              
            //reader.Close();
            return false;
        }
    }
}
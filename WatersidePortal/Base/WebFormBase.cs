using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WatersidePortal.Base
{
    public class WebFormBase : System.Web.UI.Page
    {
        /// <summary>
        /// The the Customer full name.
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        public string GetCustomerFullName(string customerId)
        {
            var cmdString = "Select FullName From [dbo].[Customers] Where CustomerID=@customerId";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@CustomerID", customerId);
                    try
                    {
                        conn.Open();
                        string customerFullName = (string)comm.ExecuteScalar();
                        return customerFullName;
                    }
                    catch (SqlException ex)
                    {
                        return string.Empty;
                    }
                }
            }
        }

        /// <summary>
        /// Determine if a Project Exists for a Customer.
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        public bool DoesProjectExist(string customerId)
        {
            string cmdString = "SELECT [CurrentProject] FROM [Customers] WHERE [CustomerID] = @ID";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", customerId);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string pr = String.Format("{0}", reader["CurrentProject"]);
                                if (pr.Length < 1)
                                {
                                    pr = "-1";
                                    return false;
                                }
                                int projectId = Convert.ToInt32(pr);
                                return true;
                            }
                        }
                    }
                    catch (SqlException err)
                    {
                        return false;
                    }
                    return false;
                }
            }
        }

    }
}
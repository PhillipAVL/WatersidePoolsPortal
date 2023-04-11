using Microsoft.Graph;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WatersidePortal
{
    public partial class CustomerPricebook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
                /*if (arr.Length > 1)
                {
                    Info.
                }*/
            }

            string cmdString = "SELECT [FirstName], [LastName], [CustomerID], [Address], [City], [State], [Telephone] FROM [Customers] WHERE [CustomerID] = " + ID;
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                header_title.Text = String.Format("{0} {1}'s Bid Proposal Version #1", reader["FirstName"], reader["LastName"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
        }

        protected void GridView_Items_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }
        protected void GridView_Items_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

        }
    }
}
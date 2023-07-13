using Microsoft.Graph;
using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WatersidePortal.Base;

namespace WatersidePortal
{
    public partial class CSubsubPriceBook : WebFormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string projectId = HttpContext.Current.Session["CurrentProjectId"].ToString();
            ProjectId.Value = projectId;
            string customerId = HttpContext.Current.Session["CurrentCustomerId"].ToString(); ;
            CustomerId.Value = customerId;
            string customerName = HttpContext.Current.Session["CurrentCustomerName"].ToString(); ;
            CustomerName.Value = GetCustomerFullName(customerId);

            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;

            string[] arr = HttpContext.Current.Request.Url.Query.Remove(0, 1).Split('&');
            string filter = "DECKING";
            string filter2 = "TRAVERTINE";
            if (arr.Length > 1)
            {
                filter = arr[0];
                filter2 = arr[1];
                hdr.Text = CItemPriceBook.convertURL(filter) + " - " + CItemPriceBook.convertURL(filter2);
            }
            else
            {
                return;
            }
            SqlDataSource1.SelectCommand = "SELECT distinct [Subsubcategory] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil AND [dbo].[PriceBook].[Subcategory] = @fil2 AND Datalength([Subsubcategory]) > 0";
            SqlDataSource1.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
            SqlDataSource1.SelectParameters.Add("fil2", CItemPriceBook.convertURL(filter2));
            SqlDataSource2.SelectCommand = "SELECT [Item], [Description], [CustomerPrice], [Unit], [ItemID] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil AND [dbo].[PriceBook].[Subcategory] = @fil2 AND ([dbo].[PriceBook].[Subsubcategory] is null or [dbo].[PriceBook].[Subsubcategory] = '')";
            SqlDataSource2.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
            SqlDataSource2.SelectParameters.Add("fil2", CItemPriceBook.convertURL(filter2));
            SqlDataSource1.DataBind();
            SqlDataSource2.DataBind();

            if (GridView_Items.Rows.Count == 0)
                GridView_Items.Visible = false;

            if (GridView1.Rows.Count == 0)
                GridView1.Visible = false;
            GridView1.Sort("Item", SortDirection.Ascending);
            GridView_Items.Sort("Subsubcategory", SortDirection.Ascending);
        }

        protected void GridView_Items_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void GridView_Items_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("testing");
        }

        protected void Selected(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Remove(0, 1).Split('&');
            string filter = "DECKING";
            string filter2 = "TRAVERTINE";
            string ID = "!";
            if (arr.Length > 2)
            {
                filter = arr[0];
                filter2 = arr[1];
                ID = arr[2];
            }
            else
            {
                return;
            }
            Response.Redirect("/CItemPriceBook.aspx?" + filter + "&" + filter2 + "&" + GridView_Items.SelectedRow.Cells[1].Text.Replace("#", "numpound").Replace("&", "andamp") + "&" + ID);
        }

        protected void Back(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;
            string[] arr = HttpContext.Current.Request.Url.Query.Remove(0, 1).Split('&');
            if (arr.Length < 3)
                return;
            Response.Redirect("/CPriceBook.aspx?" + arr[2] + "&Select");
        }

        protected void Submit(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;
            string[] arr = HttpContext.Current.Request.Url.Query.Remove(0, 1).Split('&');
            if (arr.Length < 3)
                return;
            int proj = -1;
            string cmdString = "SELECT [CurrentProject] FROM [Customers] WHERE [CustomerID] = @ID";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", arr[2]);
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
                                }
                                proj = Convert.ToInt32(pr);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            string built = "";
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                TextBox txt2 = (TextBox)GridView1.Rows[i].Cells[0].Controls[1];
                if (Convert.ToInt32(txt2.Text) < 0)
                {
                    txt2.Text = "0";
                }
                if (txt2.Text == "0")
                {
                    continue;
                }
                CheckBox box = (CheckBox)GridView1.Rows[0].Cells[5].Controls[1];
                string checked_box = box.Checked ? "1" : "0";
                string selected = unfinished.Checked ? "Unfinished" : "Selected";
                built += checked_box + "`" + selected + "`" + txt2.Text + "`" + GridView1.Rows[i].Cells[6].Text + "`" + GridView1.Rows[i].Cells[2].Text + "`" + GridView1.Rows[i].Cells[3].Text + "`0`" + DateTime.Now.ToString() + "~";
            }
            if (built.Length < 1)
            {
                return;
            }
            built = built.Remove(built.Length - 1, 1).Replace("&nbsp;", "");

            if (proj == -1)
            {
                cmdString = "INSERT INTO Projects ([Items],[CustomerID]) VALUES (@items, @id)";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand())
                    {
                        comm.Connection = conn;
                        comm.CommandText = cmdString;
                        comm.Parameters.AddWithValue("@items", built);
                        comm.Parameters.AddWithValue("@id", arr[2]);

                        try
                        {
                            conn.Open();
                            comm.ExecuteNonQuery();
                        }
                        catch (SqlException f)
                        {
                            System.Diagnostics.Debug.WriteLine(f.Message);
                        }
                    }
                }
            }
            else
            {
                cmdString = "SELECT [Items] FROM Projects WHERE [ProjectID] = @ID";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand(cmdString, conn))
                    {
                        comm.Parameters.AddWithValue("@ID", proj);
                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = comm.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    built += "~" + String.Format("{0}", reader["Items"]);
                                }
                            }
                        }
                        catch (SqlException err)
                        {

                        }
                    }
                }


                cmdString = "UPDATE Projects SET [Items] = @items WHERE ProjectID = @id";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand())
                    {
                        comm.Connection = conn;
                        comm.CommandText = cmdString;
                        comm.Parameters.AddWithValue("@items", built);
                        comm.Parameters.AddWithValue("@id", proj);

                        try
                        {
                            conn.Open();
                            comm.ExecuteNonQuery();
                        }
                        catch (SqlException f)
                        {
                            System.Diagnostics.Debug.WriteLine(f.Message);
                        }
                    }
                }
            }

            Response.Redirect("/CPriceBook.aspx?" + arr[2] + "&Select");
        }
    }
}
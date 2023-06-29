using Microsoft.Graph;
using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Providers.Entities;
using System.Web.UI;
using System.Web.UI.WebControls;
using WatersidePortal.Base;

namespace WatersidePortal
{
    public partial class CSubPriceBook : WebFormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CSubPriceBook frm = (CSubPriceBook)sender;

            var pid = HttpContext.Current.Session["CurrentProjectId"];
            var customerId = HttpContext.Current.Session["CurrentCustomerId"];
            var customerName = HttpContext.Current.Session["CurrentCustomerName"];

            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;
            string[] arr = HttpContext.Current.Request.Url.Query.Remove(0, 1).Split('&');
            string filter = "1";
            if (arr.Length > 1)
            {
                filter = arr[0];
                hdr.Text = CItemPriceBook.convertURL(filter);
            }
            else
            {
                return;
            }
            SqlDataSource1.SelectCommand = "SELECT [Subcategory], STRING_AGG(nullif([Subsubcategory],''), ', ') WITHIN GROUP (ORDER BY [Subsubcategory]) AS Subsub FROM (select distinct [Subsubcategory], [Subcategory] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil AND Datalength([Subcategory]) > 0) x GROUP BY [Subcategory]";
            SqlDataSource1.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
            SqlDataSource2.SelectCommand = "SELECT [Item], [Description], [CustomerPrice], [Unit], [ItemID] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil AND ([dbo].[PriceBook].[Subcategory] is null or [dbo].[PriceBook].[Subcategory] = '')";
            SqlDataSource2.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
            SqlDataSource1.DataBind();
            SqlDataSource2.DataBind();
            if (GridView_Items.Rows.Count == 0)
                GridView_Items.Visible = false;
            if (GridView1.Rows.Count == 0)
                GridView1.Visible = false;
            GridView1.Sort("Item", SortDirection.Ascending);
            GridView_Items.Sort("Subcategory", SortDirection.Ascending);
        }

        
        #region Page Events

        // Save the changes from the Pricebook
        protected void Submit(object sender, EventArgs e)
        {
            // Get session vars.
            ProjectId.Value = HttpContext.Current.Session["CurrentProjectId"].ToString();
            CustomerId.Value = HttpContext.Current.Session["CurrentCustomerId"].ToString();
            CustomerName.Value = HttpContext.Current.Session["CurrentCustomerName"].ToString();

            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;
            string[] arr = HttpContext.Current.Request.Url.Query.Remove(0, 1).Split('&');
            if (arr.Length < 2)
                return;
            int proj = -1;

            string cmdString = string.Empty;
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;

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

            // Determine if a default custoer project exists.
            // If so, add the project and itmes.
            if (DoesProjectExist(CustomerId.Value) == false)
            {
                cmdString = "INSERT INTO Projects ([Items],[CustomerID]) VALUES (@items, @id)";
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand())
                    {
                        comm.Connection = conn;
                        comm.CommandText = cmdString;
                        comm.Parameters.AddWithValue("@items", built);
                        comm.Parameters.AddWithValue("@id", CustomerId.Value);

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
                // Build the list of bid proposal items when items exist.
                cmdString = "SELECT [Items] FROM Projects WHERE [ProjectID] = @ID";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand(cmdString, conn))
                    {
                        comm.Connection = conn;
                        comm.CommandText = cmdString;
                        comm.Parameters.AddWithValue("@ID", ProjectId.Value);
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

                // Update the project items field with the new items.
                cmdString = "UPDATE Projects SET [Items] = @items WHERE ProjectID = @id";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand())
                    {
                        comm.Connection = conn;
                        comm.CommandText = cmdString;
                        comm.Parameters.AddWithValue("@items", built);
                        comm.Parameters.AddWithValue("@id", ProjectId.Value);

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

            Response.Redirect("/CPriceBook.aspx?" + arr[1] + "&Select");
        }

        protected void Back(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;
            string[] arr = HttpContext.Current.Request.Url.Query.Remove(0, 1).Split('&');
            if (arr.Length < 2)
                return;
            Response.Redirect("/CPriceBook.aspx?" + arr[1] + "&Select");
        }

        #endregion


        #region Page Methods

        
        #endregion


        #region Grid Events

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
            string filter = "1";
            string ID = "1";
            if (arr.Length > 1)
            {
                filter = arr[0];
                ID = arr[1];
            }
            else
            {
                return;
            }
            Response.Redirect("/CSubsubPriceBook.aspx?" + filter + "&" + GridView_Items.SelectedRow.Cells[1].Text.Replace("#", "numpound").Replace("&", "andamp") + "&" + ID);
        }

        #endregion

    }
}
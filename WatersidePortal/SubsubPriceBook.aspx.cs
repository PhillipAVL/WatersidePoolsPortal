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

namespace WatersidePortal
{
    public partial class SubsubPriceBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            SqlDataSource1.SelectCommand = "SELECT distinct [Subsubcategory] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil AND [dbo].[PriceBook].[Subcategory] = @fil2";
            SqlDataSource1.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
            SqlDataSource1.SelectParameters.Add("fil2", CItemPriceBook.convertURL(filter2));
            SqlDataSource2.SelectCommand = "SELECT [Item], [Description], [CustomerPrice], [Unit] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil AND [dbo].[PriceBook].[Subcategory] = @fil2";
            SqlDataSource2.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
            SqlDataSource2.SelectParameters.Add("fil2", CItemPriceBook.convertURL(filter2));
            SqlDataSource1.DataBind();
            SqlDataSource2.DataBind();
            if (GridView_Items.Rows.Count > 0)
            {
                GridView_Items.Rows[0].Visible = false;
                if (GridView_Items.Rows.Count == 1)
                    GridView_Items.Visible = false;
            }

            if (GridView_Items.Rows.Count == 0)
                GridView_Items.Visible = false;

            if (GridView1.Rows.Count == 0)
                GridView1.Visible = false;
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
            System.Diagnostics.Debug.WriteLine(HttpContext.Current.Request.Url.Query);
            if (arr.Length > 1)
            {
                filter = arr[0];
                filter2 = arr[1];
            }
            else
            {
                return;
            }
            Response.Redirect("/ItemPriceBook.aspx?" + filter + "&" + filter2 + "&" + GridView_Items.SelectedRow.Cells[1].Text.Replace("#", "numpound").Replace("&", "andamp"));
        }
        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("/PriceBook.aspx?");
        }
    }
}
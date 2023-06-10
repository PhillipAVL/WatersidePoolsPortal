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
    public partial class ItemPriceBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;
            string[] arr = HttpContext.Current.Request.Url.Query.Remove(0, 1).Split('&');
            string filter = "DECKING";
            string filter2 = "TRAVERTINE";
            string filter3 = "Alaskan Silver (Travertine - Tumbled)";
            if (arr.Length > 2)
            {
                filter = arr[0];
                filter2 = arr[1];
                filter3 = arr[2];
                hdr.Text = CItemPriceBook.convertURL(filter) + " - " + CItemPriceBook.convertURL(filter2) + " - " + CItemPriceBook.convertURL(filter3);
            }
            else
            {
                return;
            }
            SqlDataSource2.SelectCommand = "SELECT [Item], [Description], [CustomerPrice], [Unit] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil AND [dbo].[PriceBook].[Subcategory] = @fil2 AND [dbo].[PriceBook].[Subsubcategory] = @fil3";
            SqlDataSource2.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
            SqlDataSource2.SelectParameters.Add("fil2", CItemPriceBook.convertURL(filter2));
            SqlDataSource2.SelectParameters.Add("fil3", CItemPriceBook.convertURL(filter3));
            SqlDataSource2.DataBind();

            if (GridView1.Rows.Count == 0)
                GridView1.Visible = false;
            GridView1.Sort("Item", SortDirection.Ascending);
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
        }
        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("/PriceBook.aspx?");
        }
    }
}
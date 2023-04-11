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
    public partial class SubPriceBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.AbsoluteUri.Split('?');
            string filter = "1";
            if (arr.Length > 1)
            {
                filter = arr[1];
                hdr.Text = CItemPriceBook.convertURL(filter);
            }
            else
            {
                return;
            }
            SqlDataSource1.SelectCommand = "SELECT [Subcategory], STRING_AGG(nullif([Subsubcategory],''), ', ') WITHIN GROUP (ORDER BY [Subsubcategory]) AS Subsub FROM (select distinct [Subsubcategory], [Subcategory] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil) x GROUP BY [Subcategory]";
            SqlDataSource1.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
            SqlDataSource2.SelectCommand = "SELECT [Item], [Description], [CustomerPrice], [Unit] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = @fil";
            SqlDataSource2.SelectParameters.Add("fil", CItemPriceBook.convertURL(filter));
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
            string[] arr = HttpContext.Current.Request.Url.AbsoluteUri.Split('?');
            string filter = "1";
            if (arr.Length > 1)
            {
                filter = arr[1];
            }
            else
            {
                return;
            }
            Response.Redirect("/SubsubPriceBook.aspx?" + filter + "&" + GridView_Items.SelectedRow.Cells[1].Text.Replace("#", "numpound").Replace("&", "andamp"));
        }
        protected void Back(object sender, EventArgs e)
        {
            Response.Redirect("/PriceBook.aspx?");
        }
    }
}
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

namespace WatersidePortal.Admin
{
    public partial class PriceBookEZ : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView_Items_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void Button_AddItem_Click(object sender, EventArgs e)
        {
            string cmdString = "INSERT INTO PriceBookEZ ([Category],[Subcategory],[Item],[Description],[Unit],[CustomerPrice],[COGS],[ImageString]) VALUES (@Category, @Subcategory, @Item, @Description, @Unit, @CustomerPrice, @COGS, @ImageString)";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@Category", TextBox_Category.Text);
                    TextBox_Category.Text = "";
                    comm.Parameters.AddWithValue("@Subcategory", TextBox_Subcategory.Text);
                    TextBox_Subcategory.Text = "";
                    comm.Parameters.AddWithValue("@Item", TextBox_Item.Text);
                    TextBox_Item.Text = "";
                    comm.Parameters.AddWithValue("@Description", TextBox_Description.Text);
                    TextBox_Description.Text = "";
                    comm.Parameters.AddWithValue("@Unit", TextBox_Unit.Text);
                    TextBox_Unit.Text = "";
                    comm.Parameters.AddWithValue("@CustomerPrice", TextBox_CustomerPrice.Text);
                    TextBox_CustomerPrice.Text = "";
                    comm.Parameters.AddWithValue("@COGS", TextBox_COGS.Text);
                    TextBox_COGS.Text = "";
                    comm.Parameters.AddWithValue("@ImageString", TextBox_ImageString.Text);
                    TextBox_ImageString.Text = "";

                    //try
                    {
                        conn.Open();
                        comm.ExecuteNonQuery();
                    }
                    //catch(SqlException f)
                    {
                        // do something with the exception
                        // don't hide it
                    }
                    this.DataBind();
                }
            }
        }
    }
}
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
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvCustomers.DataSource = GetData("select * from PriceBookGenesis");
                gvCustomers.DataBind();
            }
        }


        private static DataTable GetData(string query)
        {
            string strConnString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = query;
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }


        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string customerId = gvCustomers.DataKeys[e.Row.RowIndex].Value.ToString();
                GridView gvOrders = e.Row.FindControl("gvOrders") as GridView;
                gvOrders.DataSource = GetData(string.Format("select * from PriceBookGenesis where ItemId='{0}'", customerId));
                gvOrders.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            /*foreach (RepeaterItem item in Repeater1.Items)
            {
                TextBox txtName = (TextBox)item.FindControl("TextBox");
                if (txtName != null)
                {
                    Label1.Text = Label1.Text + txtName.Text;
                }
            }*/
        }

    }
}
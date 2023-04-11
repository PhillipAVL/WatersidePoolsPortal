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
    public partial class Repair : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.SelectedIndexChanged += CustomersGridView_SelectedIndexChanged;
            GridView1.SelectedIndexChanging += CustomersGridView_SelectedIndexChanged2;

            if (search.Text.Length > 0)
            {
                foreach (GridViewRow row in GridView1.Rows)
                {
                    bool exists = false;
                    foreach (DataControlFieldCell cell in row.Cells)
                    {
                        if (cell.Text.ToLower().Contains(search.Text.ToLower()))
                        {
                            exists = true;
                            break;
                        }
                    }
                    if (!exists)
                    {
                        row.Visible = false;
                    }
                }
            }
        }
        protected void AddUser(Object sender, EventArgs e)
        {
            string connString = SqlDataSource1.ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string cmdString = "INSERT INTO [Customers] ([FirstName], [LastName], [Address], [City], [State], [Telephone], [Alternate], [Email], [WPCustomer]) VALUES (@first, @last, @add, @city, @state, @tele, @alt, @email, @wp)";
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@first", TextBox_FirstName.Text);
                    comm.Parameters.AddWithValue("@last", TextBox_LastName.Text);
                    comm.Parameters.AddWithValue("@add", TextBox_Address.Text);
                    comm.Parameters.AddWithValue("@city", TextBox_City.Text);
                    comm.Parameters.AddWithValue("@state", TextBox_State.Text);
                    comm.Parameters.AddWithValue("@tele", TextBox_Telephone.Text);
                    comm.Parameters.AddWithValue("@alt", TextBox_Alternate_Telephone.Text);
                    comm.Parameters.AddWithValue("@email", TextBox_Email_Address.Text);
                    comm.Parameters.AddWithValue("@wp", "1");
                    try
                    {
                        conn.Open();
                        comm.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {

                    }
                }
            }
        }

        protected void CustomersGridView_SelectedIndexChanged2(Object sender, EventArgs e)
        {
        }

        protected void CustomersGridView_SelectedIndexChanged(Object sender, EventArgs e)
        {
            string ind = GridView1.SelectedRow.Cells[9].Text;
            //selectedID = Int32.Parse(ind);
            Response.Redirect("/ModifyCustomer.aspx?" + ind + "&Info");
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}
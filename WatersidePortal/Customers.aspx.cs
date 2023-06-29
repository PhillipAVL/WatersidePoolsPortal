using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using WatersidePortal.Base;
using WatersidePortal.Models;

namespace WatersidePortal
{
    public partial class CreateCustomer : WebFormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();

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
                            row.Visible = true;
                        }
                    }
                    if (!exists)
                    {
                        row.Visible = false;
                    }
                }
            }
            else
            {
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.Visible = true;
                }
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.Cells[1].Text.Length == 1)
                    row.Visible = false;
            }
        }


        #region Page Events

        protected void AddUser(Object sender, EventArgs e)
        {
            ApplicationDbContext context = new ApplicationDbContext();
            var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));

            string userid = User.Identity.GetUserId();
            if (userid == null || userid.Length == 0)
            {
                userid = "Unknown";
            }
            if (TextBox_FirstName.Text.Length == 0 || TextBox_LastName.Text.Length == 0 || TextBox_Address.Text.Length == 0 || TextBox_Telephone.Text.Length == 0 || TextBox_Email_Address.Text.Length == 0)
                return;

            string connString = SqlDataSource1.ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string cmdString = "INSERT INTO [Customers] ([FirstName], [LastName], [Address], [City], [State], [ZipCode], [Telephone], [Alternate], [Email], [Salesman], [WPCustomer]) VALUES (@first, @last, @add, @city, @state, @zip, @tele, @alt, @email, @sales, @wp)";
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@first", TextBox_FirstName.Text);
                    comm.Parameters.AddWithValue("@last", TextBox_LastName.Text);
                    comm.Parameters.AddWithValue("@add", TextBox_Address.Text);
                    comm.Parameters.AddWithValue("@city", TextBox_City.Text);
                    comm.Parameters.AddWithValue("@state", "FL");
                    comm.Parameters.AddWithValue("@zip", TextBox_ZipCode.Text);
                    comm.Parameters.AddWithValue("@tele", TextBox_Telephone.Text);
                    comm.Parameters.AddWithValue("@alt", TextBox_Alternate_Telephone.Text);
                    comm.Parameters.AddWithValue("@email", TextBox_Email_Address.Text);
                    comm.Parameters.AddWithValue("@sales", userid);
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
            Response.Redirect("/Customers.aspx?Modify");
        }

        #endregion


        #region Grid Events

        protected void CustomersGridView_SelectedIndexChanged2(Object sender, EventArgs e)
        {
        }

        protected void CustomersGridView_SelectedIndexChanged(Object sender, EventArgs e)
        {
            string ind = GridView1.SelectedRow.Cells[9].Text;
            //selectedID = Int32.Parse(ind);
            Response.Redirect("/ModifyCustomer.aspx?" + ind + "&Info");
        }


        #endregion

    }
}
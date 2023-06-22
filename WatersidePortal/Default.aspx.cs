using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Owin;
using WatersidePortal.Models;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Collections;
using System.Configuration;
using System.Data.SqlClient;
using Microsoft.Ajax.Utilities;

namespace WatersidePortal
{
    class Customer
    {
        public string name;
        public string last;
        public string address;
        public string city;
        public string telephone;
        public string email;
        public string zip;
        public DateTime contractDate;
        public bool delinquent;
    }
    public partial class _Default : Page
    {
        public static int DelinquencyLength = 7;
        ArrayList prompts = new ArrayList();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // Set default name.
                Label_Name.Text = System.Web.HttpContext.Current.User.Identity.Name.ToString();
                Label1.Text = Label_Name.Text;

                try
                {
                    string userid = User.Identity.GetUserId();
                    if (!HttpContext.Current.User.Identity.IsAuthenticated)
                    {
                        // Allow the user to login.
                        Response.Redirect("\\Account\\Login.aspx");
                    }
                    else
                    {
                        ApplicationDbContext context = new ApplicationDbContext();
                        var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
                        var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));


                        /*if (UserManager.IsInRole(userid, "Admin"))
                        {
                            Response.Redirect("Admin\\Default.aspx");
                        }

                        else if (UserManager.IsInRole(userid, "Staff"))
                        {
                            Response.Redirect("Staff\\Default.aspx");
                        }*/


                    }
                    if (Global.hasPermission(User.Identity.GetUserId(), "ManageCustomers"))
                    {
                        //select all from reader of the projects if the salesperson is userid
                        //while (rdr)
                        //if rdr current date - Contract date > 20 days, then prompts = true
                        //prompts.add(Jerry Bee's Project Has Been Delinquent for (difference) Days.\nReason:
                    }

                    // TODO: PH, the entire logic for this needs to be revisited with Jason. What do we really want to show on the Dashboard landing page for Bid Proposals?
                    string cmdString = "SELECT * FROM Customers";
                    if (userid == null || userid.Length == 0)
                    {
                        userid = "Unknown";
                        cmdString = "SELECT * FROM Customers WHERE [Salesman] = @salesman";
                        Label_Name.Text = userid;
                        Label1.Text = userid;
                    }

                    string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        using (SqlCommand comm = new SqlCommand(cmdString, conn))
                        {
                            if (userid != "Unknown")
                                comm.Parameters.AddWithValue("@salesman", userid);

                            try
                            {
                                conn.Open();
                                using (SqlDataReader reader = comm.ExecuteReader())
                                {
                                    Customer cust = new Customer();
                                    while (reader.Read())
                                    {
                                        cust.name = String.Format("{0}", reader["FirstName"]);
                                        cust.last = String.Format("{0}", reader["LastName"]);
                                        cust.address = String.Format("{0}", reader["JobAddress"]);
                                        cust.city = String.Format("{0}", reader["JobCity"]);
                                        cust.zip = String.Format("{0}", reader["JobZip"]);
                                        cust.email = String.Format("{0}", reader["Email"]);
                                        cust.telephone = reader["Telephone"] != null ? String.Format("{0}", reader["Telephone"]) : string.Empty;

                                        if (reader["ContractDate"].ToString() != string.Empty)
                                        {
                                            cust.contractDate = reader["ContractDate"] != null ? DateTime.Parse(String.Format("{0}", reader["ContractDate"])) : DateTime.MinValue;
                                        }
                                        if (reader["ContractDate"].ToString() != string.Empty)
                                        {
                                            cust.contractDate = reader["ContractDate"] != null ? DateTime.Parse(String.Format("{0}", reader["ContractDate"])) : DateTime.MinValue;
                                        }
                                        cust.delinquent = (DateTime.Now - cust.contractDate).Days > DelinquencyLength;
                                    }
                                }
                            }
                            catch (SqlException err)
                            {

                            }
                        }
                    }
                }

                catch (HttpException q)
                {
                    Response.Redirect("\\Login.aspx");
                    return;
                }
            }
        }


        #region Private Page Methods

        private string getCustomerFullName(string customerId)
        {
            var cmdString = "Select FullName From [dbo].[Customers] Where CustomerID=@customerId";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@CustomerID", customerId);
                    try
                    {
                        conn.Open();
                        string customerFullName = (string)comm.ExecuteScalar();
                        return customerFullName;
                    }
                    catch (SqlException ex)
                    {
                        return string.Empty;
                    }
                }
            }
        }

        #endregion


    }
}
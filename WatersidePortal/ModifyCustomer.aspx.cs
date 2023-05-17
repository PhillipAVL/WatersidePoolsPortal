using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WatersidePortal
{
    public partial class ModifyCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }

            string cmdString = "SELECT [FirstName], [LastName], [CustomerID], [Address], [City], [State], [Telephone], [Alternate], [Email] FROM [Customers] WHERE [CustomerID] = @ID";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                name.Text = String.Format("{0} {1}'s Profile", reader["FirstName"], reader["LastName"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }

            cmdString = "SELECT [MessageText], [Date], [EmpModifying] FROM [CustomerHistory] WHERE [CustomerId] = @ID";
            List<Tuple<DateTime, string, string>> histories = new List<Tuple<DateTime, string, string>>();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                histories.Add(Tuple.Create(DateTime.Parse(reader["Date"].ToString()), reader["MessageText"].ToString(), reader["EmpModifying"].ToString()));
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }

            histories.Sort();
            histories.Reverse();

            foreach (var tup in histories)
            {
                addMessage(tup.Item2, tup.Item1, tup.Item3);
            }

            if (histories.Count == 0)
            {
                addMessageSelf("Customer Profile Created.");
                AddToHistory("Customer Profile Created.");
            }

            SqlDataSource2.SelectCommand = "SELECT * from [Warranties] where [CustomerID] = @ID ORDER BY [WarrantyID] ASC";
            SqlDataSource2.SelectParameters.Add("ID", ID);
            SqlDataSource2.DataBind();

            ContinueButton.Visible = false;
            cmdString = "select Count(ProjectID) as projCount from [dbo].[Projects] where CustomerID = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string pr = String.Format("{0}", reader["projCount"]);
                                if (pr.Length < 1)
                                {
                                    pr = "-1";
                                }
                                int cnt = Convert.ToInt32(pr);
                                if (cnt > 0)
                                    ContinueButton.Visible = true;
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            if (!IsPostBack)
            {
                RefreshFields();
            }
            SearchFiles();
        }

        protected void onChanged(object sender, EventArgs e)
        {
            if (New_Home.SelectedValue == "Yes")
                Home_Div.Visible = true;
            else
                Home_Div.Visible = false;

            if (Referral.SelectedValue == "Yes")
                Referral_Div.Visible = true;
            else
            {
                Referral_Amount.Text = "";
                Referral_Div.Visible = false;
            }

            if (Builder_Referral.SelectedValue == "Yes")
                Builder_Panel.Visible = true;
            else
                Builder_Panel.Visible = false;

            if (Permission_Letter.SelectedValue == "Yes")
                Letter_Button.Visible = true;
            else
                Letter_Button.Visible = false;

            if (Homeowner_Furnish.SelectedValue == "Yes")
                Survey_Panel.Visible = true;
            else
                Survey_Panel.Visible = false;

            if (Septic_Tank.SelectedValue == "Yes")
                Septic_Panel.Visible = true;
            else
                Septic_Panel.Visible = false;

            if (New_Home_Builder.SelectedValue == "Other")
                Other_New_Panel.Visible = true;
            else
                Other_New_Panel.Visible = false;

            if (Builder_Names.SelectedValue == "Other")
                Other_Builder_Panel.Visible = true;
            else
                Other_Builder_Panel.Visible = false;
        }

        protected void popup(object sender, EventArgs e)
        {
            Upload_Pop.Visible = !Upload_Pop.Visible;
        }

        protected void Upload(object sender, EventArgs e)
        {
            if (FileUpLoad1.FileBytes.Length > 0)
            {
                string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
                string ID = "1";
                if (arr.Length > 0 && arr[0].Split('?').Length > 1)
                {
                    ID = arr[0].Split('?')[1];
                }
                else
                {
                    return;
                }
                if (FileUpLoad1.FileName == null || FileUpLoad1.FileName.Length == 0 || Selected_File.SelectedValue == "Select" || Input_Date.Text == null || Input_Date.Text.Length == 0)
                {
                    return;
                }
                foreach (string loc in System.IO.Directory.GetFiles(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\"))
                {
                    if (loc.Split('`').Length < 2)
                    {
                        continue;
                    }

                    if (loc.Split('`')[1] == Selected_File.SelectedValue)
                    {
                        int largest = 0;
                        foreach (string loc2 in System.IO.Directory.GetFiles(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\"))
                        {
                            if (loc2.Split('`').Length < 2)
                            {
                                continue;
                            }

                            if (loc2.Split('`')[1].StartsWith(Selected_File.SelectedValue + "V"))
                            {
                                string ver = loc2.Split('`')[1].Remove(0, Selected_File.SelectedValue.Length + 1).Split('`')[0];
                                int version = Convert.ToInt32(ver);
                                if (version > largest)
                                {
                                    largest = version;
                                }
                            }
                        }
                        largest += 1;
                        File.Move(loc, loc.Substring(0, loc.LastIndexOf('.') - 1) + "V" + largest + "`." + loc.Split('.')[1]);
                    }
                }
                AddToHistory("Signed " + Selected_File + " Uploaded.");
                File.WriteAllBytes(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\" + FileUpLoad1.FileName.Split('.')[0].Replace("`", "") + "`" + Selected_File.SelectedValue + "`." + FileUpLoad1.FileName.Split('.')[1], FileUpLoad1.FileBytes);
                File.SetCreationTime(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\" + FileUpLoad1.FileName.Split('.')[0].Replace("`", "") + "`" + Selected_File.SelectedValue + "`." + FileUpLoad1.FileName.Split('.')[1], Convert.ToDateTime(Input_Date.Text));
            }
            Selected_File.SelectedValue = "Select";
            Upload_Pop.Visible = !Upload_Pop.Visible;
            SearchFiles();
        }
        protected void Continue(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }

            Response.Redirect("/CPriceBook?" + ID + "&Select");
        }

        protected void GenerateGenesis(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }
            AddToHistory("Genesis Bid Proposal Created.");

            string built = "";
            //built += "0`Unfinished`1`1`374``0`" + DateTime.Now.ToString() + "~"; // no surveys
            if (Surveys_Selection.SelectedValue == "Both") // No Surveys
            {
                built += "0`Finished`1`374``-400`0`" + DateTime.Now.ToString() + "~";
            }

            // Municipality Charges
            switch (Permit.SelectedValue)
            {
                case "CityAugustine":
                    built += "0`Finished`1`379``800`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Ormond":
                    built += "0`Finished`1`382``600`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "FlaglerCounty":
                    built += "0`Finished`1`375``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "FlaglerBeach":
                    built += "0`Finished`1`376``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "StAugustine":
                    // check if under review or not
                    break;
                case "John":
                    built += "0`Finished`1`380``1000`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Volusia":
                    built += "0`Finished`1`381``700`0`" + DateTime.Now.ToString() + "~";
                    break;
            }

            // New Home Construction
            if (New_Home.SelectedValue == "Yes")
            {
                built += "0`Finished`1`383``1500`0`" + DateTime.Now.ToString() + "~";
            }

            //ARB
            switch (arb.SelectedValue)
            {
                case "Other":
                    built += "0`Finished`1`384``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Grand":
                    built += "0`Finished`1`385``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "PalmCoast":
                    built += "0`Finished`1`388``800`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Plantation":
                    built += "0`Finished`1`394``700`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Ocean":
                    built += "0`Finished`1`393``900`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Dunes":
                    built += "0`Finished`1`391``900`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Shores":
                    built += "0`Finished`1`395``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Hidden":
                    built += "0`Finished`1`386``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Polo":
                    built += "0`Finished`1`389``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Island":
                    built += "0`Finished`1`392``2500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Tuscana":
                    built += "0`Finished`1`390``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "North":
                    built += "0`Finished`1`387``900`0`" + DateTime.Now.ToString() + "~";
                    break;
            }

            if (drop_distance.SelectedValue == "45")
            {
                built += "0`Finished`1`397``2500`0`" + DateTime.Now.ToString() + "~";
            }
            else if (drop_distance.SelectedValue == "60")
            {
                built += "0`Finished`1`398``3500`0`" + DateTime.Now.ToString() + "~";
            }

            built = built.Substring(0, built.Length - 1);

            int projectCount = 0;
            string cmdString = "select count(*) as amt from [dbo].[Projects] where [CustomerID] = @ID";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                projectCount = Convert.ToInt32(reader["amt"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            projectCount += 1;
            cmdString = "INSERT INTO Projects ([Items],[CustomerID],[ProjectType],[ProjectName],[ProjectDescription]) VALUES (@items, @id, @type, @name, @desc)";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@items", built);
                    comm.Parameters.AddWithValue("@id", ID);
                    comm.Parameters.AddWithValue("@type", "Genesis");
                    comm.Parameters.AddWithValue("@name", "Bid Proposal, Version #" + projectCount);
                    comm.Parameters.AddWithValue("@desc", bid_prop_desc.Text);

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
            int projID = 0;
            cmdString = "select Max([ProjectID]) as maxID from [dbo].[Projects] where [CustomerID] = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                projID = Convert.ToInt32(reader["maxID"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            cmdString = "UPDATE [dbo].[Customers] SET [CurrentProject] = @pID where CustomerID = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@pID", projID);
                    comm.Parameters.AddWithValue("@ID", ID);

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
            Response.Redirect("/CPriceBook?" + ID + "&Select");
        }
        protected void GenerateRenovation(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            string built = "";
            //built += "0`Unfinished`1`1`374``0`" + DateTime.Now.ToString() + "~"; // no surveys

            AddToHistory("Renovation Bid Proposal Created.");
            string cmdString = "INSERT INTO Projects ([Items],[CustomerID]) VALUES (@items, @id)";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@items", built);
                    comm.Parameters.AddWithValue("@id", arr[3]);

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
            int projID = 0;
            cmdString = "select Max([ProjectID]) as maxID from [dbo].[Projects] where [CustomerID] = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                projID = Convert.ToInt32(reader["maxID"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            cmdString = "UPDATE [dbo].[Customers] SET [CurrentProject] = @pID where ID = @CustomerID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@pID", projID);

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
            Response.Redirect("/CPriceBook?" + ID + "&Select");
        }

        protected void GenerateEZ(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }

            string built = "";
            //built += "0`Unfinished`1`1`374``0`" + DateTime.Now.ToString() + "~"; // no surveys
            if (Surveys_Selection.SelectedValue == "Both") // No Surveys
            {
                built += "0`Finished`1`374``-400`0`" + DateTime.Now.ToString() + "~";
            }

            AddToHistory("EZ-Flow Bid Proposal Created.");
            // Municipality Charges
            switch (Permit.SelectedValue)
            {
                case "CityAugustine":
                    built += "0`Finished`1`379``800`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Ormond":
                    built += "0`Finished`1`382``600`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "FlaglerCounty":
                    built += "0`Finished`1`375``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "FlaglerBeach":
                    built += "0`Finished`1`376``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "StAugustine":
                    // check if under review or not
                    break;
                case "John":
                    built += "0`Finished`1`380``1000`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Volusia":
                    built += "0`Finished`1`381``700`0`" + DateTime.Now.ToString() + "~";
                    break;
            }

            // New Home Construction
            if (New_Home.SelectedValue == "Yes")
            {
                built += "0`Finished`1`383``1500`0`" + DateTime.Now.ToString() + "~";
            }

            //ARB
            switch (arb.SelectedValue)
            {
                case "Other":
                    built += "0`Finished`1`384``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Grand":
                    built += "0`Finished`1`385``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "PalmCoast":
                    built += "0`Finished`1`388``800`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Plantation":
                    built += "0`Finished`1`394``700`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Ocean":
                    built += "0`Finished`1`393``900`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Dunes":
                    built += "0`Finished`1`391``900`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Shores":
                    built += "0`Finished`1`395``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Hidden":
                    built += "0`Finished`1`386``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Polo":
                    built += "0`Finished`1`389``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Island":
                    built += "0`Finished`1`392``2500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "Tuscana":
                    built += "0`Finished`1`390``500`0`" + DateTime.Now.ToString() + "~";
                    break;
                case "North":
                    built += "0`Finished`1`387``900`0`" + DateTime.Now.ToString() + "~";
                    break;
            }

            if (drop_distance.SelectedValue == "45")
            {
                built += "0`Finished`1`397``2500`0`" + DateTime.Now.ToString() + "~";
            }
            else if (drop_distance.SelectedValue == "60")
            {
                built += "0`Finished`1`398``3500`0`" + DateTime.Now.ToString() + "~";
            }
            built = built.Substring(0, built.Length - 1);

            int projectCount = 0;
            string cmdString = "select count(*) as amt from [dbo].[Projects] where [CustomerID] = @ID";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                projectCount = Convert.ToInt32(reader["amt"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            projectCount += 1;
            cmdString = "INSERT INTO Projects ([Items],[CustomerID],[ProjectType],[ProjectName],[ProjectDescription]) VALUES (@items, @id, @type, @name, @desc)";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@items", built);
                    comm.Parameters.AddWithValue("@id", ID);
                    comm.Parameters.AddWithValue("@type", "EZ-Flow");
                    comm.Parameters.AddWithValue("@name", "Bid Proposal, Version #" + projectCount);
                    comm.Parameters.AddWithValue("@desc", bid_prop_desc.Text);

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
            int projID = 0;
            cmdString = "select Max([ProjectID]) as maxID from [dbo].[Projects] where [CustomerID] = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                projID = Convert.ToInt32(reader["maxID"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            cmdString = "UPDATE [dbo].[Customers] SET [CurrentProject] = @pID where CustomerID = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@pID", projID);
                    comm.Parameters.AddWithValue("@ID", ID);

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
            Response.Redirect("/CPriceBook?" + ID + "&Select");
        }

        protected void Save(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string cmdString = "UPDATE Customers SET SurveySelection = @SurveyS, SepticSurvey = @SepticSurvey, ExistingSeptic = @ES, ExistingFence = @EF, HTFS = @htfs, APLR = @aplr, BuilderFee = @BF, NHSelection = @NHS, BuilderSelection = @BS, NHBuilder = @NHB, NHOther = @NHO, Builder = @build, BuilderOther = @bo, MinAccessF = @MAF, MinAccessI = @MAI, Referral = @ref, Distance = @dist, FirstName = @first, LastName = @last, Address = @add, City = @city, State = @state, ZipCode = @zip, Telephone = @tele, Alternate = @alt, Email = @email, AlternateEmail = @altemail, JobAddress = @JAdd, JobCity = @JCity, JobPermit = @JPermit, JobARB = @JARB, JobZip = @JZip, JobLot = @JLot, JobBlock = @JBlock, JobSection = @JSection, JobPlat = @JPlat, JobPage = @JPage, Notes = @Notes WHERE CustomerID = @ID";
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@first", TextBox_FirstName.Text);
                    comm.Parameters.AddWithValue("@last", TextBox_LastName.Text);
                    comm.Parameters.AddWithValue("@add", TextBox_Address.Text);
                    comm.Parameters.AddWithValue("@city", TextBox_City.Text);
                    comm.Parameters.AddWithValue("@state", DropDownListState.SelectedValue);
                    comm.Parameters.AddWithValue("@zip", TextBox_Zip.Text);
                    comm.Parameters.AddWithValue("@tele", TextBox_Telephone.Text);
                    comm.Parameters.AddWithValue("@alt", TextBox_Alternate_Telephone.Text);
                    comm.Parameters.AddWithValue("@email", TextBox_Email_Address.Text);
                    comm.Parameters.AddWithValue("@altemail", TextBox_Alternate_Email.Text);
                    comm.Parameters.AddWithValue("@JAdd", TextBox_Job_Address.Text);
                    comm.Parameters.AddWithValue("@JCity", TextBox_Job_City.Text);
                    comm.Parameters.AddWithValue("@JPermit", Permit.SelectedValue);
                    comm.Parameters.AddWithValue("@JARB", arb.SelectedValue);
                    comm.Parameters.AddWithValue("@JZip", TextBox_Job_Zip.Text);
                    comm.Parameters.AddWithValue("@JLot", TextBox_Lot.Text);
                    comm.Parameters.AddWithValue("@JBlock", TextBox_Block.Text);
                    comm.Parameters.AddWithValue("@JSection", TextBox_Section.Text);
                    comm.Parameters.AddWithValue("@JPlat", TextBox_Plat.Text);
                    comm.Parameters.AddWithValue("@JPage", TextBox_Pages.Text);
                    comm.Parameters.AddWithValue("@Notes", Notes.Text);
                    comm.Parameters.AddWithValue("@ID", ID);
                    comm.Parameters.AddWithValue("@MAF", Convert.ToInt32(Min_Access_F.Text));
                    comm.Parameters.AddWithValue("@MAI", Convert.ToInt32(Min_Access_I.Text));
                    comm.Parameters.AddWithValue("@dist", drop_distance.SelectedValue);
                    comm.Parameters.AddWithValue("@ref", Referral_Amount.Text.Replace("`", "") + "`" + Referral_Full.Text.Replace("`", "") + "`" + Referral_Address.Text.Replace("`", "") + "`" + Referral_City.Text.Replace("`", "") + "`" + Referral_State.SelectedValue + "`" + Referral_Zip.Text.Replace("`", ""));
                    comm.Parameters.AddWithValue("@NHB", New_Home_Builder.SelectedValue);
                    comm.Parameters.AddWithValue("@build", Builder_Names.SelectedValue);
                    comm.Parameters.AddWithValue("@NHO", Other_New_Builder.Text);
                    comm.Parameters.AddWithValue("@bo", Other_Builder.Text);
                    comm.Parameters.AddWithValue("@NHS", New_Home.SelectedValue);
                    comm.Parameters.AddWithValue("@BS", Builder_Referral.SelectedValue);
                    comm.Parameters.AddWithValue("@BF", Builder_Amount.Text);
                    comm.Parameters.AddWithValue("@aplr", Permission_Letter.SelectedValue);
                    comm.Parameters.AddWithValue("@htfs", Homeowner_Furnish.SelectedValue);
                    comm.Parameters.AddWithValue("@SurveyS", Surveys_Selection.SelectedValue);
                    comm.Parameters.AddWithValue("@EF", Existing_Fence.SelectedValue);
                    comm.Parameters.AddWithValue("@ES", Septic_Tank.SelectedValue);
                    comm.Parameters.AddWithValue("@SepticSurvey", Septic_Buttons.SelectedValue);
                    try
                    {
                        conn.Open();
                        System.Diagnostics.Debug.WriteLine(comm.ExecuteNonQuery());
                    }
                    catch (SqlException ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                }
            }
        }

        protected void Discard(object sender, EventArgs e)
        {
            RefreshFields();
        }

        /// <summary>
        /// Copy the fields from Customer Address to Jobsite Address.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void copy(object sender, EventArgs e)
        {
            TextBox_Job_Address.Text = TextBox_Address.Text;
            TextBox_Job_City.Text = TextBox_City.Text;
            TextBox_Job_Zip.Text = TextBox_Zip.Text;
        }

        void RefreshFields()
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }
            string cmdString = "SELECT [FullName] FROM [Builders]";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                New_Home_Builder.Items.Add(new ListItem(String.Format("{0}", reader["FullName"])));
                                Builder_Names.Items.Add(new ListItem(String.Format("{0}", reader["FullName"])));
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }

            cmdString = "SELECT * FROM [Customers] WHERE [CustomerID] = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                TextBox_FirstName.Text = String.Format("{0}", reader["FirstName"]);
                                TextBox_LastName.Text = String.Format("{0}", reader["LastName"]);
                                TextBox_Address.Text = String.Format("{0}", reader["Address"]);
                                TextBox_City.Text = String.Format("{0}", reader["City"]);
                                DropDownListState.SelectedValue = String.Format("{0}", reader["State"]);
                                TextBox_Alternate_Telephone.Text = String.Format("{0}", reader["Alternate"]);
                                TextBox_Email_Address.Text = String.Format("{0}", reader["Email"]);
                                TextBox_Telephone.Text = String.Format("{0}", reader["Telephone"]);
                                TextBox_Zip.Text = String.Format("{0}", reader["ZipCode"]);
                                TextBox_Job_Address.Text = String.Format("{0}", reader["JobAddress"]);
                                TextBox_Job_City.Text = String.Format("{0}", reader["JobCity"]);
                                Permit.SelectedValue = String.Format("{0}", reader["JobPermit"]);
                                arb.SelectedValue = String.Format("{0}", reader["JobARB"]);
                                TextBox_Job_Zip.Text = String.Format("{0}", reader["JobZip"]);
                                TextBox_Lot.Text = String.Format("{0}", reader["JobLot"]);
                                TextBox_Block.Text = String.Format("{0}", reader["JobBlock"]);
                                TextBox_Section.Text = String.Format("{0}", reader["JobSection"]);
                                TextBox_Plat.Text = String.Format("{0}", reader["JobPlat"]);
                                TextBox_Pages.Text = String.Format("{0}", reader["JobPage"]);
                                TextBox_Alternate_Email.Text = String.Format("{0}", reader["AlternateEmail"]);
                                Notes.Text = String.Format("{0}", reader["Notes"]);
                                Min_Access_F.Text = String.Format("{0}", reader["MinAccessF"]);
                                Min_Access_I.Text = String.Format("{0}", reader["MinAccessI"]);
                                drop_distance.SelectedValue = String.Format("{0}", reader["Distance"]);
                                Builder_Names.SelectedValue = String.Format("{0}", reader["Builder"]);
                                Other_Builder.Text = String.Format("{0}", reader["BuilderOther"]);
                                New_Home_Builder.SelectedValue = String.Format("{0}", reader["NHBuilder"]);
                                Other_New_Builder.Text = String.Format("{0}", reader["NHOther"]);
                                New_Home.SelectedValue = String.Format("{0}", reader["NHSelection"]);
                                if (New_Home.SelectedValue == "Yes")
                                {
                                    Home_Div.Visible = true;
                                }
                                Builder_Referral.SelectedValue = String.Format("{0}", reader["BuilderSelection"]);
                                if (Builder_Referral.SelectedValue == "Yes")
                                {
                                    Builder_Panel.Visible = true;
                                }
                                if (New_Home_Builder.SelectedValue == "Other")
                                    Other_New_Panel.Visible = true;
                                if (Builder_Names.SelectedValue == "Other")
                                    Other_Builder_Panel.Visible = true;
                                Builder_Amount.Text = String.Format("{0}", reader["BuilderFee"]);
                                Permission_Letter.SelectedValue = String.Format("{0}", reader["APLR"]);
                                if (Permission_Letter.SelectedValue == "Yes")
                                    Letter_Button.Visible = true;
                                Homeowner_Furnish.SelectedValue = String.Format("{0}", reader["HTFS"]);
                                if (Homeowner_Furnish.SelectedValue == "Yes")
                                    Survey_Panel.Visible = true;
                                Surveys_Selection.SelectedValue = String.Format("{0}", reader["SurveySelection"]);
                                Existing_Fence.SelectedValue = String.Format("{0}", reader["ExistingFence"]);
                                Septic_Tank.SelectedValue = String.Format("{0}", reader["ExistingSeptic"]);
                                if (Septic_Tank.SelectedValue == "Yes")
                                {
                                    Septic_Panel.Visible = true;
                                }
                                Septic_Buttons.SelectedValue = String.Format("{0}", reader["SepticSurvey"]);
                                string[] referralArr = String.Format("{0}", reader["Referral"]).Split('`');
                                if (referralArr.Length == 6)
                                {
                                    Referral_Amount.Text = referralArr[0];
                                    Referral_Full.Text = referralArr[1];
                                    Referral_Address.Text = referralArr[2];
                                    Referral_City.Text = referralArr[3];
                                    Referral_State.SelectedValue = referralArr[4];
                                    Referral_Zip.Text = referralArr[5];

                                    if (Referral_Amount.Text.Length > 0)
                                    {
                                        Referral.SelectedValue = "Yes";
                                        Referral_Div.Visible = true;
                                    }
                                    else
                                    {
                                        Referral.SelectedValue = "No";
                                        Referral_Div.Visible = false;
                                    }
                                }
                                string miles = String.Format("{0}", reader["Milestones"]);
                                string[] milestones = miles.Split(',');
                                for (int i = 0; i < milestones.Length; i++)
                                {
                                    if (milestones[i].Length > 0)
                                    {
                                        Milestone_List.Items[i].Selected = true;
                                        Milestone_List.Items[i].Text = milestones[i] + " - " + Milestone_List.Items[i].Text;
                                    }
                                }
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
        }

        protected void Exit(object sender, EventArgs e)
        {
            Response.Redirect("/Customers");
        }

        protected void tab(object sender, EventArgs e)
        {
        }

        protected void SearchFiles2(Object sender, EventArgs e)
        {
            SearchFiles();
        }

        protected void addNote(object sender, EventArgs e)
        {
            AddToHistory(historyNote.Text);
            Response.Redirect(Request.RawUrl);
        }
        protected void addMessageSelf(string message)
        {
            DateTime date = DateTime.Now;
            string emp = HttpContext.Current.User.Identity.Name != null && HttpContext.Current.User.Identity.Name.Length > 0 ? HttpContext.Current.User.Identity.Name : "Unknown";
            System.Web.UI.HtmlControls.HtmlGenericControl newdivs = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
            newdivs.Attributes.Add("class", "maindivs");
            newdivs.Attributes.Add("style", "border-style: solid; margin: 20px; min-height: 100px;");
            System.Web.UI.HtmlControls.HtmlGenericControl newlabel = new System.Web.UI.HtmlControls.HtmlGenericControl("label");
            newlabel.InnerText = emp + " - " + date.ToString("d", CultureInfo.GetCultureInfo("en-US"));
            newdivs.Controls.Add(newlabel);
            System.Web.UI.HtmlControls.HtmlGenericControl br = new System.Web.UI.HtmlControls.HtmlGenericControl("br");
            newdivs.Controls.Add(br);
            System.Web.UI.HtmlControls.HtmlGenericControl newmsg = new System.Web.UI.HtmlControls.HtmlGenericControl("label");
            newmsg.InnerText = message;
            newmsg.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
            newdivs.Controls.Add(newmsg);
            customer_history.Controls.Add(newdivs);
        }

        public int historyCounter = 0;

        protected void addMessage(string message, DateTime date, string emp)
        {
            System.Web.UI.HtmlControls.HtmlGenericControl newdivs = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");
            newdivs.Attributes.Add("class", "maindivs");
            newdivs.Attributes.Add("style", "border-style: solid; margin: 20px; min-height: 100px;");
            System.Web.UI.HtmlControls.HtmlGenericControl newlabel = new System.Web.UI.HtmlControls.HtmlGenericControl("label");
            newlabel.InnerText = emp + " - " + date.ToString("d", CultureInfo.GetCultureInfo("en-US"));
            newdivs.Controls.Add(newlabel);
            System.Web.UI.HtmlControls.HtmlGenericControl br = new System.Web.UI.HtmlControls.HtmlGenericControl("br");
            newdivs.Controls.Add(br);
            System.Web.UI.HtmlControls.HtmlGenericControl newmsg = new System.Web.UI.HtmlControls.HtmlGenericControl("label");
            newmsg.InnerText = message;
            newmsg.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
            newdivs.Controls.Add(newmsg);
            customer_history.Controls.Add(newdivs);
        }

        protected void AddToHistory(string message)
        {

            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString);
            //Replaced Parameters with Value
            string query = "INSERT INTO CustomerHistory (CustomerId, MessageText, Date, EmpModifying) VALUES(@CustomerId, @MessageText, @Date, @EmpModifying)";
            SqlCommand cmd = new SqlCommand(query, con);

            //Pass values to Parameters
            string emp = HttpContext.Current.User.Identity.Name != null && HttpContext.Current.User.Identity.Name.Length > 0 ? HttpContext.Current.User.Identity.Name : "Unknown";
            cmd.Parameters.AddWithValue("@CustomerId", ID);
            cmd.Parameters.AddWithValue("@MessageText", message);
            cmd.Parameters.AddWithValue("@Date", DateTime.Now);
            cmd.Parameters.AddWithValue("@EmpModifying", emp);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                Console.WriteLine("Records Inserted Successfully");
            }
            catch (SqlException e)
            {
                Console.WriteLine("Error Generated. Details: " + e.ToString());
            }
            finally
            {
                con.Close();
            }

        }


        protected void SearchFiles()
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }

            /*using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("alter table [Customers] add [Creation] varchar(255)"))
                {
                    command.Connection = connection;
                    command.ExecuteNonQuery();
                }
            }*/
            if (!Directory.Exists(HttpRuntime.AppDomainAppPath + "UserData"))
            {
                Directory.CreateDirectory(HttpRuntime.AppDomainAppPath + "UserData");
            }
            if (!Directory.Exists(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\"))
            {
                Directory.CreateDirectory(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\");
            }


            foreach (string loc in System.IO.Directory.GetFiles(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\"))
            {
                if (loc.Split('`').Length < 2)
                {
                    continue;
                }

                System.Drawing.Color green = System.Drawing.ColorTranslator.FromHtml("#4caf50");
                string fileName = loc.Split('\\')[loc.Split('\\').Length - 1];

                Label target = null;
                switch (loc.Split('`')[1])
                {
                    case "Signed Design":
                        target = label_signed;
                        if (loc.EndsWith(".pdf"))
                            check_signed.Visible = true;
                        break;

                    case "Contract":
                        target = label_contract;
                        if (loc.EndsWith(".pdf"))
                            check_contract.Visible = true;
                        break;

                    case "Customer Explanation":
                        target = label_explanation;
                        if (loc.EndsWith(".pdf"))
                            check_explanation.Visible = true;
                        break;

                    case "Access Permission Letter":
                        target = label_access;
                        if (loc.EndsWith(".pdf"))
                            check_access.Visible = true;
                        break;

                    case "Addendum Commissions":
                        target = label_addendumcomm;
                        if (loc.EndsWith(".pdf"))
                            check_addendum_comm.Visible = true;
                        break;

                    case "ARB Approval Letter":
                        target = label_arb;
                        if (loc.EndsWith(".pdf"))
                            check_arb.Visible = true;
                        break;

                    case "Contingency Release Letter":
                        target = label_contingency_release;
                        if (loc.EndsWith(".pdf"))
                            check_contingency.Visible = true;
                        break;

                    case "Easement Encroachment Form":
                        target = label_easement;
                        if (loc.EndsWith(".pdf"))
                            check_easement.Visible = true;
                        break;

                    case "Mosaic Tile Disclaimer":
                        target = label_mosaic;
                        if (loc.EndsWith(".pdf"))
                            check_mosaic.Visible = true;
                        break;

                    case "Project Breakdown":
                        target = label_project;
                        if (loc.EndsWith(".pdf"))
                            check_breakdown.Visible = true;
                        break;

                    case "Sub Copy Design":
                        target = label_sub;
                        if (loc.EndsWith(".pdf"))
                            check_sub.Visible = true;
                        break;

                    case "Revised Sub Copy":
                        target = label_sub;
                        if (loc.EndsWith(".pdf"))
                            check_revised.Visible = true;
                        break;

                    case "Survey With Pool":
                        target = label_surveypool;
                        if (loc.EndsWith(".pdf"))
                            check_survey_pool.Visible = true;
                        break;

                    case "Survey Without Pool":
                        target = label_survey;
                        if (loc.EndsWith(".pdf"))
                            check_survey.Visible = true;
                        break;

                    case "Tile Selection Sheet":
                        target = label_tiless;
                        if (loc.EndsWith(".pdf"))
                            check_tile.Visible = true;
                        break;

                    case "Total dynamic Head":
                        target = label_tdh;
                        if (loc.EndsWith(".pdf"))
                            check_tdh.Visible = true;
                        break;

                    case "Warranty Deed":
                        target = label_warranty;
                        if (loc.EndsWith(".pdf"))
                            check_warranty.Visible = true;
                        break;

                }
                if (target != null)
                {
                    target.Visible = true;
                    target.ForeColor = green;
                    target.Attributes.Add("onclick", "javascript:window.open('/UserData/" + ID + "/" + fileName + "')");
                }
            }
        }

        protected void packetPrint(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }

            if (!Directory.Exists(HttpRuntime.AppDomainAppPath + "UserData"))
            {
                Directory.CreateDirectory(HttpRuntime.AppDomainAppPath + "UserData");
            }
            if (!Directory.Exists(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\"))
            {
                Directory.CreateDirectory(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\");
            }
            List<string> pdfsLegal = new List<string>();
            List<string> pdfsLetter = new List<string>();
            List<string> pdfsSurvey = new List<string>();

            foreach (string loc in System.IO.Directory.GetFiles(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\"))
            {
                if (loc.Split('`').Length < 2 || !loc.EndsWith(".pdf"))
                {
                    string nme = loc;
                    Console.WriteLine(nme);
                    continue;
                }

                switch (loc.Split('`')[1])
                {
                    case "Signed Design":
                        if (check_signed.Checked)
                            pdfsLegal.Add(loc);
                        break;

                    case "Contract":
                        if (check_contract.Checked)
                            pdfsLegal.Add(loc);
                        break;

                    case "Customer Explanation":
                        if (check_explanation.Checked)
                            pdfsLegal.Add(loc);
                        break;

                    case "Access Permission Letter":
                        if (check_access.Checked)
                            pdfsLetter.Add(loc);
                        break;

                    case "Addendum Commissions":
                        if (check_addendum_comm.Checked)
                            pdfsLetter.Add(loc);
                        break;

                    case "ARB Approval Letter":
                        if (check_arb.Checked)
                            pdfsLetter.Add(loc);
                        break;

                    case "Contingency Release Letter":
                        if (check_contingency.Checked)
                            pdfsLetter.Add(loc);
                        break;

                    case "Easement Encroachment Form":
                        if (check_easement.Checked)
                            pdfsLetter.Add(loc);
                        break;

                    case "Mosaic Tile Disclaimer":
                        if (check_mosaic.Checked)
                            pdfsLetter.Add(loc);
                        break;

                    case "Project Breakdown":
                        if (check_breakdown.Checked)
                            pdfsLegal.Add(loc);
                        break;

                    case "Sub Copy Design":
                        if (check_sub.Checked)
                            pdfsLegal.Add(loc);
                        break;

                    case "Revised Sub Copy":
                        if (check_revised.Checked)
                            pdfsLegal.Add(loc);
                        break;

                    case "Survey With Pool":
                        if (check_survey_pool.Checked)
                            pdfsSurvey.Add(loc);
                        break;

                    case "Survey Without Pool":
                        if (check_survey.Checked)
                            pdfsSurvey.Add(loc);
                        break;

                    case "Tile Selection Sheet":
                        if (check_tile.Checked)
                            pdfsLegal.Add(loc);
                        break;

                    case "Total dynamic Head":
                        if (check_tdh.Checked)
                            pdfsLetter.Add(loc);
                        break;

                    case "Warranty Deed":
                        if (check_warranty.Checked)
                            pdfsLetter.Add(loc);
                        break;

                }
            }
            PdfDocument doc = MergeAllPDFsInDirectory(pdfsLegal.ToArray(), "Legal");
            if (doc != null && doc.PageCount > 0)
            {
                Response.Write("<script>");
                Response.Write("window.open('/UserData/" + ID + "/PacketLegal.pdf','_blank')");
                Response.Write("</script>");
            }
            doc = MergeAllPDFsInDirectory(pdfsLetter.ToArray(), "Letter");
            if (doc != null && doc.PageCount > 0)
            {
                Response.Write("<script>");
                Response.Write("window.open('/UserData/" + ID + "/PacketLetter.pdf','_blank')");
                Response.Write("</script>");
            }
            doc = MergeAllPDFsInDirectory(pdfsSurvey.ToArray(), "Survey");
            if (doc != null && doc.PageCount > 0)
            {
                Response.Write("<script>");
                Response.Write("window.open('/UserData/" + ID + "/PacketSurvey.pdf','_blank')");
                Response.Write("</script>");
            }
        }

        protected PdfDocument MergeAllPDFsInDirectory(string[] pdfs, string pdfType)
        {
            
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return null;
            }

            using (PdfDocument outPdf = new PdfDocument())
            {
                //crawl array
                foreach (string filePath in pdfs)
                {
                    //Merge said PDFs w/PDFSharp
                    using (PdfDocument current = PdfReader.Open(filePath, PdfDocumentOpenMode.Import))
                    {
                        for (int i = 0; i < current.PageCount; i++)
                        {
                            outPdf.AddPage(current.Pages[i]);
                        }
                    }
                }
                if (outPdf.PageCount > 0)
                {
                    outPdf.Save(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\Packet" + pdfType + ".pdf");
                }
                return (outPdf);
            }
        }


        protected void AddWarranty(object sender, EventArgs e)
        {
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }
            string cmdString = "INSERT INTO Warranties ([Company], [CustomerID], [ProductName], [ModelNumber], [PartNumber], [SerialNumber], [DateOfInstall], [FireUpDate], [WarrantyLength], [Installer]) VALUES (@company, @id, @product, @model, @part, @serial, @install, @fire, @length, @installer)";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@company", Company.Text);
                    comm.Parameters.AddWithValue("@id", ID);
                    comm.Parameters.AddWithValue("@product", ProductName.Text);
                    comm.Parameters.AddWithValue("@model", ModelNumber.Text);
                    comm.Parameters.AddWithValue("@part", PartNumber.Text);
                    comm.Parameters.AddWithValue("@serial", SerialNumber.Text);
                    comm.Parameters.AddWithValue("@install", DateOfInstall.Text);
                    comm.Parameters.AddWithValue("@fire", FireUpDate.Text);
                    comm.Parameters.AddWithValue("@length", WarrantyLength.Text);
                    comm.Parameters.AddWithValue("@installer", Installer.Text);
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
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void PrintAccess(object sender, EventArgs e)
        {
            Response.Write("<script>");
            Response.Write("window.open('/Documents/Access Permission.pdf','_blank')");
            Response.Write("</script>");
        }

        protected void Stone(object sender, EventArgs e)
        {
            String sDate = DateTime.Now.ToString();
            DateTime datevalue = (Convert.ToDateTime(sDate.ToString()));
            string date = datevalue.Date.ToString().Split(' ')[0];

            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            string ID = "1";
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                ID = arr[0].Split('?')[1];
            }
            else
            {
                return;
            }

            string miles = "";
            string cmdString = "SELECT * FROM [Customers] WHERE [CustomerID] = @ID";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                miles = String.Format("{0}", reader["Milestones"]);
                            }
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
            }
            string built = "";
            string[] milesArr = miles.Split(',');
            for (int i = 0; i < Milestone_List.Items.Count; i++)
            {
                bool bit = Milestone_List.Items[i].Selected ? true : false;
                if (bit && !Milestone_List.Items[i].Text.StartsWith(date))
                {
                    if (milesArr[i].Length == 0)
                    {
                        AddToHistory(Milestone_List.Items[i].Text + ".");
                    }
                    built += date;
                    Milestone_List.Items[i].Text = date + " - " + Milestone_List.Items[i].Text;
                }
                built += ",";
            }
            built = built.Remove(built.Length - 1, 1);
            cmdString = "UPDATE Customers SET Milestones = @milestones WHERE CustomerID = @ID";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand comm = new SqlCommand(cmdString, connection))
                {
                    comm.Parameters.AddWithValue("@milestones", built);
                    comm.Parameters.AddWithValue("@ID", ID);
                    try
                    {
                        System.Diagnostics.Debug.WriteLine(comm.ExecuteNonQuery());
                    }
                    catch (SqlException ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                }
            }
        }
    }
}
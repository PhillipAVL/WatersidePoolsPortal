using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WatersidePortal.Models;
using WatersidePortal.Base;
using System.Web.ModelBinding;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;
using iText.Layout.Properties;
using Microsoft.Ajax.Utilities;

namespace WatersidePortal
{
    public partial class ModifyCustomer : WebFormBase
    {
        public int historyCounter = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.Query.Length == 0)
                return;

            string customerId = string.Empty;
            string[] arr = HttpContext.Current.Request.Url.Query.Split('&');
            if (arr.Length > 0 && arr[0].Split('?').Length > 1)
            {
                customerId = arr[0].Split('?')[1];
                HttpContext.Current.Session["CurrentCustomerId"] = customerId;
            }
            CustomerName.Text = GetCustomerFullName(customerId);
            HttpContext.Current.Session["CurrentCustomerName"] = CustomerName.Text;


            // Customers Tab
            string cmdString = "SELECT [FirstName], [LastName], [CustomerID], [Address], [City], [State], [Telephone], [Alternate], [Email], [WaterfillType] FROM [Customers] WHERE [CustomerID] = @ID ORDER BY [ID]";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", customerId);
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

            // Get Customer History.
            cmdString = "SELECT [MessageText], [Date], [EmpModifying] FROM [CustomerHistory] WHERE [CustomerId] = @ID ORDER BY [Date] ASC";
            List<Tuple<DateTime, string, string>> histories = new List<Tuple<DateTime, string, string>>();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", customerId);
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

            // Select current project.
            int projID = -1;
            cmdString = "Select [CurrentProject] From [dbo].[Customers] Where [CustomerID] = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;

            // Get the Project Id
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", customerId);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string pr = String.Format("{0}", reader["CurrentProject"]);
                                if (pr.Length < 1)
                                {
                                    pr = "-1";
                                }
                                projID = Convert.ToInt32(pr);
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
            SqlDataSource2.SelectParameters.Add("ID", customerId);
            SqlDataSource2.DataBind();

            if (!IsPostBack)
            {
                // Get Projects for the selected Customer
                Project gProj = new Project();
                cmdString = "Select * From [dbo].[Projects] Where CustomerID=@ID ORDER BY [ProjectID]"; // AND ProjectID=@pID";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand(cmdString, conn))
                    {
                        comm.Parameters.AddWithValue("@ID", customerId);
                        //comm.Parameters.AddWithValue("@pID", projID);
                        try
                        {
                            conn.Open();

                            // TODO: PH: This is left here until I determine if it is needed for formatting.
                            //using (SqlDataReader reader = comm.ExecuteReader())
                            //{
                            //    while (reader.Read())
                            //    {
                            //        gProj.sItems = String.Format("{0}", reader["Items"]);
                            //        gProj.projectName = String.Format("{0}", reader["ProjectName"]);
                            //        gProj.projectDescription = String.Format("{0}", reader["ProjectDescription"]);
                            //        gProj.projectID = Convert.ToInt32(String.Format("{0}", reader["ProjectID"]));
                            //        //Project_Name.Text = gProj.projectName;
                            //        //Project_Desc.Text = gProj.projectDescription;
                            //        string[] len = String.Format("{0}", reader["Length"]).Split('`');
                            //        string[] wid = String.Format("{0}", reader["Width"]).Split('`');
                            //        //if (len.Length == 2)
                            //        //{
                            //        //    LF.Text = len[0];
                            //        //    LI.Text = len[1];
                            //        //}
                            //        //if (wid.Length == 2)
                            //        //{
                            //        //    WF.Text = wid[0];
                            //        //    WI.Text = wid[1];
                            //        //}
                            //        //if (LF.Text.Length == 0)
                            //        //    LF.Text = "0";
                            //        //if (LI.Text.Length == 0)
                            //        //    LI.Text = "0";
                            //        //if (WF.Text.Length == 0)
                            //        //    WF.Text = "0";
                            //        //if (WI.Text.Length == 0)
                            //        //    WI.Text = "0";
                            //        //if (String.Format("{0}", reader["ProjectType"]) == "Genesis")
                            //        //{
                            //        //    basePrice = 51000;
                            //        //    geninc.Visible = true;
                            //        //    ezinc.Visible = false;
                            //        //}
                            //        //else if (String.Format("{0}", reader["ProjectType"]) == "EZ-Flow")
                            //        //{
                            //        //    geninc.Visible = false;
                            //        //    ezinc.Visible = true;
                            //        //    basePrice = 54500;
                            //        //}
                            //    }

                            DataTable myTable = new DataTable();
                            myTable.Load(comm.ExecuteReader());

                            GridView_Items.DataSource = myTable;
                            GridView_Items.DataBind();

                            if (myTable.Rows.Count < 1)
                            {
                                btnRecall.Enabled = false;
                                btnRecall.CssClass = "btn btn-primary";

                                btnDuplicate.Enabled = false;
                                btnDuplicate.CssClass = "btn btn-primary";

                                btnSaveMaster.Enabled = false;
                                btnSaveMaster.CssClass = "btn btn-primary";
                            }
                        }
                        //}
                        catch (SqlException err)
                        {

                        }
                    }
                }

                RefreshFields();
            }
            SearchFiles();

            divSuccess.Visible = false;
            divFailure.Visible = false;

            //if (!requiredUserInformationComplete())
            //{
            //    string msg = "PLEASE NOTE" + Environment.NewLine + "There are required fields missing for the current selected user." + Environment.NewLine + "Please do not perform any other work until the following selections are corrected: " + Environment.NewLine;
            //    ModelState.AddModelError(string.Empty, msg);
            //    setUserInformationModelErrors();
            //}
        }


        #region Page Events

        protected void RecallBid(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.AbsoluteUri.Split('?').Length < 2)
            {
                return;
            }
            string[] arr = HttpContext.Current.Request.Url.AbsoluteUri.Split('?')[1].Split('&');
            string ID = "1";
            if (arr.Length > 1)
            {
                ID = arr[0];
            }
            else
            {
                return;
            }

            var projectId = string.Empty;
            for (int i = 0; i < GridView_Items.Rows.Count; i++)
            {
                CheckBox box = (CheckBox)GridView_Items.Rows[i].Cells[0].Controls[1];
                if (box.Checked)
                {
                    projectId = GridView_Items.Rows[i].Cells[1].Text;
                    break;
                }
            }
            Response.Redirect("/CPriceBook?" + ID + "&Shopping&" + projectId);

        }

        protected void DuplicateBid(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.AbsoluteUri.Split('?').Length < 2)
            {
                return;
            }
            string[] arr = HttpContext.Current.Request.Url.AbsoluteUri.Split('?')[1].Split('&');
            string ID = "1";
            if (arr.Length > 1)
            {
                ID = arr[0];
            }
            else
            {
                return;
            }

            for (int i = 0; i < GridView_Items.Rows.Count; i++)
            {
                CheckBox box = (CheckBox)GridView_Items.Rows[i].Cells[0].Controls[1];
                if (box.Checked)
                {
                    string projID = "";
                    string cmdString = "SELECT [ProjectID] from [Projects] where [CustomerID] = @ID ORDER BY [ProjectID] ASC";
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
                                    int j = 0;
                                    while (reader.Read())
                                    {
                                        if (i == j)
                                        {
                                            projID = String.Format("{0}", reader["ProjectID"]);
                                        }
                                        j++;
                                    }
                                }
                            }
                            catch (SqlException err)
                            {

                            }
                        }
                    }
                    cmdString = "insert into [Projects] (Items, CustomerID, Length, Width, ProjectName, ProjectDescription, ProjectType) select Items, CustomerID, Length, Width, ProjectName, ProjectDescription, ProjectType from [Projects] where ProjectID=@pID";
                    connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        using (SqlCommand comm = new SqlCommand(cmdString, conn))
                        {
                            comm.Parameters.AddWithValue("@pID", projID);
                            try
                            {
                                conn.Open();
                                using (SqlDataReader reader = comm.ExecuteReader())
                                {
                                }
                            }
                            catch (SqlException err)
                            {

                            }
                        }
                    }


                    cmdString = "select MAX(ProjectID) as maxID from [dbo].[Projects] where CustomerID = @ID";
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
                                        string pr = String.Format("{0}", reader["maxID"]);
                                        if (pr.Length < 1)
                                        {
                                            pr = "-1";
                                        }
                                        projID = pr;
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
                    Response.Redirect("/CPriceBook?" + ID + "&Shopping");
                    break;
                }
            }
        }

        protected void SaveMaster(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.AbsoluteUri.Split('?').Length < 2)
            {
                return;
            }
            string[] arr = HttpContext.Current.Request.Url.AbsoluteUri.Split('?')[1].Split('&');
            string ID = "1";
            if (arr.Length > 1)
            {
                ID = arr[0];
            }
            else
            {
                return;
            }

            for (int i = 0; i < GridView_Items.Rows.Count; i++)
            {
                CheckBox box = (CheckBox)GridView_Items.Rows[i].Cells[0].Controls[1];
                if (box.Checked)
                {
                    string projID = "";
                    string cmdString = "SELECT [ProjectID] from [Projects] where [CustomerID] = @ID ORDER BY [ProjectID] ASC";
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
                                    int j = 0;
                                    while (reader.Read())
                                    {
                                        if (i == j)
                                        {
                                            projID = String.Format("{0}", reader["ProjectID"]);
                                        }
                                        j++;
                                    }
                                }
                            }
                            catch (SqlException err)
                            {

                            }
                        }
                    }

                    cmdString = "insert into [MasterBids] (Items, CustomerID, Length, Width, ProjectName, ProjectDescription, ProjectType) select Items, CustomerID, Length, Width, ProjectName, ProjectDescription, ProjectType from [Projects] where ProjectID=@pID";
                    connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        using (SqlCommand comm = new SqlCommand(cmdString, conn))
                        {
                            comm.Parameters.AddWithValue("@pID", projID);
                            try
                            {
                                conn.Open();
                                using (SqlDataReader reader = comm.ExecuteReader())
                                {
                                }
                            }
                            catch (SqlException err)
                            {

                            }
                        }
                    }
                    break;
                }
            }
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

            // Get the builder names for the ddl.
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

            // TODO: Refactor this (and other methods) into private methods for better code quality.
            // Hydrate Customers form info from the reader.
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
                                //Other_New_Builder.Text = String.Format("{0}", reader["NHOther"]);
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
                                //if (New_Home_Builder.SelectedValue == "Other")
                                //    Other_New_Panel.Visible = true;
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
                                DropDownList2.SelectedValue = String.Format("{0}", reader["WaterfillType"]);

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

        /// <summary>
        /// Add a new Warranty Item.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
            
            // Validate the user entered info.
            if (!validateWarrantiesInformationInput())
            {
                divFailureMessage.InnerText = "Warranties Info is not complete!  Please make sure all Required fields have been filled.";
                divFailure.Visible = true;
                divFailure.Style.Add("background-color", "Red");
                divFailure.Style.Add("color", "White"); return;
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

        /// <summary>
        /// Display item associated fields when options are selected. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

            //if (New_Home_Builder.SelectedValue == "Other")
            //    Other_New_Panel.Visible = true;
            //else
            //    Other_New_Panel.Visible = false;

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

        /// <summary>
        /// Save the changes to user information.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

            // Validate the user entered info.
            if (!validateUserInformationInput())
            {
                divFailureMessage.InnerText = "User Info is not complete!  Please make sure all Required fields have been filled.";
                divFailure.Visible = true;
                divFailure.Style.Add("background-color", "Red");
                divFailure.Style.Add("color", "White"); return;
            }

            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string cmdString = "UPDATE Customers SET WaterfillType = @WaterfillType, SurveySelection = @SurveyS, SepticSurvey = @SepticSurvey, ExistingSeptic = @ES, ExistingFence = @EF, HTFS = @htfs, APLR = @aplr, BuilderFee = @BF, NHSelection = @NHS, BuilderSelection = @BS, NHBuilder = @NHB, NHOther = @NHO, Builder = @build, BuilderOther = @bo, MinAccessF = @MAF, MinAccessI = @MAI, Referral = @ref, Distance = @dist, FirstName = @first, LastName = @last, Address = @add, City = @city, State = @state, ZipCode = @zip, Telephone = @tele, Alternate = @alt, Email = @email, AlternateEmail = @altemail, JobAddress = @JAdd, JobCity = @JCity, JobPermit = @JPermit, JobARB = @JARB, JobZip = @JZip, JobLot = @JLot, JobBlock = @JBlock, JobSection = @JSection, JobPlat = @JPlat, JobPage = @JPage, Notes = @Notes WHERE CustomerID = @ID";
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
                    comm.Parameters.AddWithValue("@NHO", string.Empty); //Other_New_Builder.Text
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
                    comm.Parameters.AddWithValue("@WaterfillType", DropDownList2.SelectedValue);

                    try
                    {
                        conn.Open();
                        comm.ExecuteNonQuery();
                        divSuccessMessage.InnerText = "User Info Successfully Updated!";
                        divSuccess.Visible = true;
                    }
                    catch (SqlException ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                        divFailureMessage.InnerText = "User Info Update Failed";
                        divFailure.Visible = true;

                    }
                }
            }
        }

        protected void Discard(object sender, EventArgs e)
        {
            RefreshFields();
        }

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
            string[] arr = HttpContext.Current.Request.Url.AbsoluteUri.Split('?')[1].Split('&');
            string ID = "1";
            if (arr.Length > 1)
            {
                ID = arr[0];
            }
            else
            {
                return;
            }
            Response.Redirect("/CSubPriceBook.aspx?" + GridView_Items.SelectedRow.Cells[1].Text.Replace("#", "numpound").Replace("&", "andamp") + "&" + ID);
        }


        #endregion


        #region Generate Pool Types

        /// <summary>
        /// Generate a Bid Proposal (Project) for a Genesis Pool.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
            // Set inital item based on Pool Type.
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

            // Get the Project Id.
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

            // Insert a new Project.
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

            // Get the max Project Id.
            // TODO: PH: Is this the samne as what we just inserted above??
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

            // Update the Current Project Id.
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
            Response.Redirect("/CPriceBook?" + ID + "&Select&" + projID);
        }

        /// <summary>
        /// Generate a Bid Proposal (Project) for a EZ Flow Pool.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
            AddToHistory("EZ-Flow Bid Proposal Created.");

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
            // Set inital item based on Pool Type.
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

            // Get the Project Id.
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

            // Insert a new Project.
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

            // Get the max Project Id.
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

            // Update the Customers table with the ProjectID.
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
            Response.Redirect("/CPriceBook?" + ID + "&Select&" + projID);
        }

        /// <summary>
        /// Generate Pool Renovation
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

        #endregion


        #region Page Methods

        /// <summary>
        /// Validate that all user required information is properly entered.
        /// </summary>
        /// <returns></returns>
        protected bool validateUserInformationInput()
        {
            bool userInfoComplete = true;

            // CUSTOMER FIELDS.
            // Ensure entered user info is complete.
            if (TextBox_FirstName.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Customer Last Name.
            if (TextBox_LastName.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Customer Address.
            if (TextBox_Address.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Customer City.
            if (TextBox_City.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Customer State
            if (DropDownListState.SelectedValue == string.Empty || DropDownListState.SelectedValue == "Select")
            {
                userInfoComplete = false;
            }

            // Customer Zip Code.
            if (TextBox_Zip.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Customer Primary Phone
            if (TextBox_Telephone.Text.Contains("(") || TextBox_Telephone.Text.Contains(")"))
            {
                userInfoComplete = false;
            }

            //  Customer Email Address.
            if (TextBox_Email_Address.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // JOB SECTION
            // Job Address.
            if (TextBox_Job_Address.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Job City.
            if (TextBox_Job_City.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Permitting City/County.
            if (Permit.SelectedValue == string.Empty || Permit.SelectedValue == "Select")
            {
                userInfoComplete = false;
            }

            // Zip Code.
            if (TextBox_Job_Zip.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // ARB / HOA / Subdiv.
            if (arb.SelectedValue == string.Empty || arb.SelectedValue == "Select")
            {
                userInfoComplete = false;
            }

            // Minimum Access Space (Feet & Inches)
            if (Min_Access_F.Text == string.Empty)
            {
                userInfoComplete = false;
            }
            if (Min_Access_I.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Jobsite Distance From HQ (mins):
            if (drop_distance.SelectedValue == string.Empty || drop_distance.SelectedValue == "Select")
            {
                userInfoComplete = false;
            }

            // Referral To Be Paid and sub associated fields.
            if (Referral.Text == string.Empty)
            {
                userInfoComplete = false;
            }
            else if (Referral.Text == "Yes")
            {
                if (Referral_Amount.Text == string.Empty)
                {
                    userInfoComplete = false;
                }

                if (Referral_Full.Text == string.Empty)
                {
                    userInfoComplete = false;
                }
                if (Referral_Address.Text == string.Empty)
                {
                    userInfoComplete = false;
                }
                if (Referral_City.Text == string.Empty)
                {
                    userInfoComplete = false;
                }
                if (Referral_State.Text == string.Empty)
                {
                    userInfoComplete = false;
                }
                if (Referral_Zip.Text == string.Empty)
                {
                    userInfoComplete = false;
                }
            }

            // New Home Construction Project.
            if (New_Home.SelectedValue == string.Empty || New_Home.SelectedValue == "Select")
            {
                userInfoComplete = false;
            }
            else if (New_Home.Text == "Yes")
            {
                if (New_Home_Builder.Text == string.Empty || New_Home_Builder.SelectedValue == "Select")
                {
                    userInfoComplete = false;
                }
            }

            // Builder Referral Fee.
            if (Builder_Referral.Text == string.Empty)
            {
                userInfoComplete = false;
            }
            else if (Builder_Referral.Text == "Yes")
            {
                if (Builder_Names.SelectedValue == string.Empty || Builder_Names.SelectedValue == "Select")
                {
                    userInfoComplete = false;
                }
            }

            // Access Permission Letter Required.
            if (Permission_Letter.SelectedValue == string.Empty || Permission_Letter.SelectedValue == "Select")
            {
                userInfoComplete = false;
            }

            // Homeowner To Furnish Surveys.
            if (Homeowner_Furnish.Text == string.Empty)
            {
                userInfoComplete = false;
            }
            else if (Builder_Referral.Text == "Yes")
            {
                if (Surveys_Selection.SelectedValue == string.Empty || Surveys_Selection.SelectedValue == "Select")
                {
                    userInfoComplete = false;
                }
            }

            // Existing Fence
            if (Existing_Fence.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Existing Septic Tank.
            if (Septic_Tank.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            // Waterfill Type.
            if (DropDownList2.SelectedValue == string.Empty || DropDownList2.SelectedValue == "Select")
            {
                userInfoComplete = false;
            }

            return userInfoComplete;
        }

        /// <summary>
        /// Validate that all user required information is properly entered.
        /// </summary>
        /// <returns></returns>
        protected bool validateWarrantiesInformationInput()
        {
            bool userInfoComplete = true;

            if (Company.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            if (ProductName.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            if (ModelNumber.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            if (PartNumber.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            if (SerialNumber.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            if (DateOfInstall.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            if (FireUpDate.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            if (WarrantyLength.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            if (Installer.Text == string.Empty)
            {
                userInfoComplete = false;
            }

            return userInfoComplete;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="message"></param>
        /// <param name="date"></param>
        /// <param name="emp"></param>
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

        /// <summary>
        /// Add a new Customer Historical note.
        /// </summary>
        /// <param name="message"></param>
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

        #endregion

    }
}
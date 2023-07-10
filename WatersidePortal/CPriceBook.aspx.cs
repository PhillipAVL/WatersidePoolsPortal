using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Xceed.Words.NET;
using Paragraph = Xceed.Document.NET.Paragraph;
using WatersidePortal.Models;
using WatersidePortal.Base;

namespace WatersidePortal
{
    public partial class CPriceBook : WebFormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                string ID = "1";
                if (HttpContext.Current.Request.Url.AbsoluteUri.Split('?').Length < 2)
                {
                    return;
                }
                string[] arr = HttpContext.Current.Request.Url.AbsoluteUri.Split('?')[1].Split('&');
                if (arr.Length > 1)
                {
                    ID = arr[0];
                    CustomerId.Value = ID;
                }
                if (arr.Length > 2)
                {
                    CustomerId.Value = arr[0];
                    this.Session["CurrentProjectId"] = CustomerId.Value;

                    CustomerName.Value = GetCustomerFullName(ID);
                    CustomerFullName.Text = CustomerName.Value;
                    this.Session["CurrentCustomerName"] = CustomerName.Value;

                    ProjectId.Value = arr[2];
                    this.Session["CurrentProjectId"] = ProjectId.Value;
                }
            }

            if (!Page.IsPostBack)
            {
                // Get page vars from the query string.
                if (HttpContext.Current.Request.Url.AbsoluteUri.Split('?').Length < 2)
                    return;

                string[] queryParms = HttpContext.Current.Request.Url.AbsoluteUri.Split('?')[1].Split('&');
                if (Session["CurrentCustomerId"] == null)
                {
                    Session["CurrentCustomerId"] = CustomerId.Value;
                }
                else
                {
                    CustomerId.Value = queryParms[0];
                }

                if (Session["CurrentProjectId"] == null)
                {
                    Session["CurrentProjectId"] = queryParms[2];
                    ProjectId.Value = queryParms[2];
                }
                else if (queryParms.ElementAtOrDefault(2) != null)
                {
                    Session["CurrentProjectId"] = queryParms[2];
                    ProjectId.Value = Session["CurrentProjectId"].ToString();
                }
                else
                {
                    Session["CurrentProjectId"] = Session["CurrentProjectId"];
                    ProjectId.Value = Session["CurrentProjectId"].ToString();
                }

                CustomerName.Value = GetCustomerFullName(CustomerId.Value);
                this.Session["CurrentCustomerName"] = CustomerName.Value;

                // Get project detail.
                Models.Project gProj = new Models.Project();
                int basePrice = 54500;
                string cmdString = "Select * From [dbo].[Projects] Where CustomerID=@ID AND ProjectID=@ProjectId";
                string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand(cmdString, conn))
                    {
                        comm.Parameters.AddWithValue("@ID", CustomerId.Value);
                        comm.Parameters.AddWithValue("@ProjectID", ProjectId.Value);
                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = comm.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    gProj.sItems = String.Format("{0}", reader["Items"]);
                                    gProj.projectName = String.Format("{0}", reader["ProjectName"]);
                                    gProj.projectDescription = String.Format("{0}", reader["ProjectDescription"]);
                                    gProj.projectID = Convert.ToInt32(String.Format("{0}", reader["ProjectID"]));
                                    Project_Name.Text = gProj.projectName;
                                    Project_Desc.Text = gProj.projectDescription;
                                    string[] len = String.Format("{0}", reader["Length"]).Split('`');
                                    string[] wid = String.Format("{0}", reader["Width"]).Split('`');
                                    if (len.Length == 2)
                                    {
                                        LF.Text = len[0];
                                        LI.Text = len[1];
                                    }
                                    if (wid.Length == 2)
                                    {
                                        WF.Text = wid[0];
                                        WI.Text = wid[1];
                                    }
                                    if (LF.Text.Length == 0)
                                        LF.Text = "0";
                                    if (LI.Text.Length == 0)
                                        LI.Text = "0";
                                    if (WF.Text.Length == 0)
                                        WF.Text = "0";
                                    if (WI.Text.Length == 0)
                                        WI.Text = "0";
                                    if (String.Format("{0}", reader["ProjectType"]) == "Genesis")
                                    {
                                        basePrice = 51000;
                                        geninc.Visible = true;
                                        ezinc.Visible = false;
                                    }
                                    else if (String.Format("{0}", reader["ProjectType"]) == "EZ-Flow")
                                    {
                                        geninc.Visible = false;
                                        ezinc.Visible = true;
                                        basePrice = 54500;
                                    }
                                }
                            }
                        }
                        catch (SqlException err)
                        {

                        }
                    }
                }

                // Get the Project items.
                List<Item> items = new List<Item>();
                if (gProj.sItems != null && gProj?.sItems.Count() > 0)
                {
                    foreach (string str in gProj.sItems.Split('~'))
                    {
                        string[] sArr = str.Split('`');
                        if (sArr.Length < 5)
                        {
                            break;
                        }
                        Item item = new Item();
                        item.itemID = Convert.ToInt32(sArr[3]);
                        item.optional = sArr[0] == "0" ? false : true;
                        item.status = sArr[1];
                        item.quantity = Convert.ToInt32(sArr[2]);
                        item.description = sArr[4];
                        item.price = (float)Convert.ToDouble(sArr[5]);
                        item.overage = (float)Convert.ToDouble(sArr[6]);
                        item.lockedTime = DateTime.Parse(sArr[7]);

                        cmdString = "Select [Category], [Item], [Unit], [Description], [CustomerPrice] From PriceBook where ItemID=@ID";
                        connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(connString))
                        {
                            using (SqlCommand comm = new SqlCommand(cmdString, conn))
                            {
                                comm.Parameters.AddWithValue("@ID", Convert.ToInt32(sArr[3]));
                                try
                                {
                                    conn.Open();
                                    using (SqlDataReader reader = comm.ExecuteReader())
                                    {
                                        while (reader.Read())
                                        {
                                            item.item = String.Format("{0}", reader["Item"]);
                                            item.unit = String.Format("{0}", reader["Unit"]);
                                            string pric = String.Format("{0}", reader["CustomerPrice"]);
                                            item.currPrice = (float)Convert.ToDouble(pric);
                                            item.category = String.Format("{0}", reader["Category"]);
                                        }
                                    }
                                }
                                catch (SqlException err)
                                {

                                }
                            }
                        }

                        if (item.category.Equals("SPAS"))
                        {
                            SOP.Visible = true;
                            SOPLabel.Visible = true;
                        }

                        items.Add(item);
                    }
                }
                GridView_Items.Sort("Category", SortDirection.Ascending);


                // Build the Project Items Detail grid.
                DataTable dt = GridView1.DataSource as DataTable;
                DataTable dt2 = GridView2.DataSource as DataTable;
                if (dt == null)
                {
                    dt = new DataTable();
                    dt2 = new DataTable();
                    dt.Columns.Add("Status");
                    dt.Columns.Add("Item");
                    dt.Columns.Add("Price");
                    dt.Columns.Add("ItemID");
                    dt2.Columns.Add("Status");
                    dt2.Columns.Add("Item");
                    dt2.Columns.Add("Price");
                    dt2.Columns.Add("ItemID");
                }
                // If it's genesis or ez-flow
                DataRow dr2 = dt.NewRow();
                dr2["Status"] = "Finished";
                dr2["Item"] = ezinc.Visible ? "EZ-Flow Pool" : "Genesis Pool";
                dr2["Price"] = "$" + basePrice;
                dt.Rows.Add(dr2);
                foreach (Item item in items)
                {
                    if (!item.optional)
                    {
                        DataRow dr = dt.NewRow();
                        dr["Status"] = item.status;
                        dr["Item"] = item.item;
                        dr["Price"] = "$" + item.price;
                        dr["ItemID"] = item.itemID;
                        dt.Rows.Add(dr);
                    }
                    else
                    {
                        DataRow dr = dt2.NewRow();
                        dr["Status"] = item.status;
                        dr["Item"] = item.item;
                        dr["Price"] = "$" + item.price;
                        dr["ItemID"] = item.itemID;
                        dt2.Rows.Add(dr);
                    }
                }
                GridView1.DataSource = dt;
                GridView1.DataBind();
                GridView2.DataSource = dt2;
                GridView2.DataBind();

                /*if (GridView1.Rows.Count < items.Count)
                {
                    return;
                }*/
                float commission = 0;
                float commission2 = 0;
                float ovr = 0;
                float ovr2 = 0;
                float sub = basePrice;
                float subb2 = 0;
                float tot = basePrice;
                float tott2 = 0;
                float lift = basePrice;
                float liftt2 = 0;
                int selectCount = 1;
                int optCount = 0;

                GridView1.Rows[0].Cells[2].Text = "Finished";
                GridView1.Rows[0].Cells[3].Text = "1";
                GridView1.Rows[0].Cells[4].Text = ezinc.Visible ? "EZ-Flow Pool" : "Genesis Pool";
                GridView1.Rows[0].Cells[5].Text = "Base Pool Items";
                GridView1.Rows[0].Cells[6].Text = "Only One";
                GridView1.Rows[0].Cells[7].Text = "$" + basePrice;
                GridView1.Rows[0].Cells[9].Text = "-";
                GridView1.Rows[0].Cells[10].Text = "-";
                GridView1.Rows[0].Cells[11].Text = "$" + basePrice;

                for (int i = 0; i < items.Count; i++)
                {
                    float ov = items[i].overage / 2f;
                    if (items[i].overage < 0)
                    {
                        ov = items[i].overage;
                    }
                    if (!items[i].optional)
                    {
                        CheckBox check = (CheckBox)GridView1.Rows[selectCount].Cells[1].Controls[1];
                        check.Checked = items[i].optional;
                        GridView1.Rows[selectCount].Cells[2].Text = items[i].status;
                        TextBox quant = (TextBox)GridView1.Rows[selectCount].Cells[3].Controls[1];
                        quant.Text = items[i].quantity + "";
                        GridView1.Rows[selectCount].Cells[4].Text = items[i].item;
                        TextBox desc = (TextBox)GridView1.Rows[selectCount].Cells[5].Controls[1];
                        desc.Text = items[i].description;
                        GridView1.Rows[selectCount].Cells[6].Text = items[i].unit;
                        GridView1.Rows[selectCount].Cells[7].Text = "$" + items[i].price;
                        TextBox overage = (TextBox)GridView1.Rows[selectCount].Cells[8].Controls[1];
                        overage.Text = items[i].overage + "";
                        GridView1.Rows[selectCount].Cells[9].Text = 30 - (DateTime.Now - items[i].lockedTime).Days + " Days";
                        GridView1.Rows[selectCount].Cells[10].Text = "$" + (items[i].currPrice - items[i].price);
                        GridView1.Rows[selectCount].Cells[11].Text = "$" + (items[i].price * items[i].quantity + items[i].overage);
                        commission += ov + items[i].price * 0.05f;
                        ovr += items[i].overage;
                        sub += items[i].price * items[i].quantity;
                        tot += items[i].price * items[i].quantity + items[i].overage;
                        lift += items[i].currPrice * items[i].quantity + items[i].overage;
                        selectCount++;
                    }
                    else
                    {
                        CheckBox check = (CheckBox)GridView2.Rows[optCount].Cells[1].Controls[1];
                        check.Checked = items[i].optional;
                        GridView2.Rows[optCount].Cells[2].Text = items[i].status;
                        TextBox quant = (TextBox)GridView2.Rows[optCount].Cells[3].Controls[1];
                        quant.Text = items[i].quantity + "";
                        GridView2.Rows[optCount].Cells[4].Text = items[i].item;
                        TextBox desc = (TextBox)GridView2.Rows[optCount].Cells[5].Controls[1];
                        desc.Text = items[i].description;
                        GridView2.Rows[optCount].Cells[6].Text = items[i].unit;
                        GridView2.Rows[optCount].Cells[7].Text = "$" + items[i].price;
                        TextBox overage = (TextBox)GridView2.Rows[optCount].Cells[8].Controls[1];
                        overage.Text = items[i].overage + "";
                        GridView2.Rows[optCount].Cells[9].Text = 30 - (DateTime.Now - items[i].lockedTime).Days + " Days";
                        GridView2.Rows[optCount].Cells[10].Text = "$" + (items[i].currPrice - items[i].price);
                        GridView2.Rows[optCount].Cells[11].Text = "$" + (items[i].price * items[i].quantity + items[i].overage);
                        commission2 = 0;
                        ovr2 += items[i].overage;
                        subb2 += items[i].price * items[i].quantity;
                        tott2 += items[i].price * items[i].quantity + items[i].overage;
                        liftt2 += items[i].currPrice * items[i].quantity + items[i].overage;
                        optCount++;
                    }
                }
                subo1.Text = "" + String.Format("{0:0.00}", ovr);
                subo2.Text = "" + String.Format("{0:0.00}", ovr2);
                com1.Text = "" + String.Format("{0:0.00}", commission);
                sub1.Text = "" + String.Format("{0:0.00}", sub);
                sub2.Text = "" + String.Format("{0:0.00}", subb2);
                tot1.Text = "" + String.Format("{0:0.00}", tot + commission);
                if (tot < basePrice)
                {
                    tot1.Text = "" + String.Format("{0:0.00}", basePrice);
                }
                tot2.Text = "" + String.Format("{0:0.00}", tott2 + commission2);
                if (tott2 < basePrice)
                {
                    tot1.Text = "" + String.Format("{0:0.00}", basePrice);
                }
                lift1.Text = "" + String.Format("{0:0.00}", lift);
                lift2.Text = "" + String.Format("{0:0.00}", liftt2);
                grand.Text = "" + String.Format("{0:0.00}", tot + tott2 + commission);
                if (tot2.Text == "0.00")
                {
                    optional.Visible = false;
                }
                else
                {
                    optional.Visible = true;
                }

                try
                {
                    GridView1.Sort("Item", SortDirection.Ascending);
                }
                catch (Exception err) { }
                try
                {
                    GridView2.Sort("Item", SortDirection.Ascending);
                }
                catch (Exception err) { }
            }
        }


        #region Page Events

        protected void Save(object sender, EventArgs e)
        {
            Save();
        }

        private void Save()
        {
            //if (Project_Name_Box.Text.Length > 0)
            //{
            //    Project_Name.Text = Project_Name_Box.Text + ":";
            //    Project_Name_Box.Text = "";
            //}
            //if (Description_Box.Text.Length > 0)
            //{
            //    Project_Desc.Text = Description_Box.Text + ":";
            //    Description_Box.Text = "";
            //}


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

            // Getting the project ID
            int projID = -1;
            string cmdString = "Select [CurrentProject] From [dbo].[Customers] Where CustomerID=@ID";
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
            string itemstr = "";
            cmdString = "Select * From [dbo].[Projects] Where CustomerID=@ID AND ProjectID=@pID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    comm.Parameters.AddWithValue("@pID", projID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                itemstr = String.Format("{0}", reader["Items"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }

            List<Item> items = new List<Item>();
            foreach (string str in itemstr.Split('~'))
            {
                string[] sArr = str.Split('`');
                if (sArr.Length < 5)
                {
                    break;
                }
                Item item = new Item();
                item.itemID = Convert.ToInt32(sArr[3]);
                item.optional = sArr[0] == "0" ? false : true;
                item.status = sArr[1];
                item.quantity = Convert.ToInt32(sArr[2]);
                item.description = sArr[4];
                item.price = (float)Convert.ToDouble(sArr[5]);
                item.overage = (float)Convert.ToDouble(sArr[6]);
                item.lockedTime = DateTime.Parse(sArr[7]);

                cmdString = "Select [Item], [Unit], [Description], [CustomerPrice] From PriceBook where ItemID=@ID";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand(cmdString, conn))
                    {
                        comm.Parameters.AddWithValue("@ID", Convert.ToInt32(sArr[3]));
                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = comm.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    item.item = String.Format("{0}", reader["Item"]);
                                    item.unit = String.Format("{0}", reader["Unit"]);
                                    string pric = String.Format("{0}", reader["CustomerPrice"]);
                                    item.currPrice = (float)Convert.ToDouble(pric);
                                }
                            }
                        }
                        catch (SqlException err)
                        {

                        }
                    }
                }

                items.Add(item);
            }

            // Items
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                CheckBox box = (CheckBox)GridView1.Rows[i].Cells[1].Controls[1];
                TextBox quant = (TextBox)GridView1.Rows[i].Cells[3].Controls[1];
                TextBox desc = (TextBox)GridView1.Rows[i].Cells[5].Controls[1];
                TextBox overage = (TextBox)GridView1.Rows[i].Cells[8].Controls[1];
                string name = GridView1.Rows[i].Cells[4].Text;
                string price = GridView1.Rows[i].Cells[7].Text;
                string unit = GridView1.Rows[i].Cells[6].Text;
                for (int j = 0; j < items.Count; j++)
                {
                    Item item = items[j];
                    if (item.item == name && item.unit == unit && "$" + item.price == price)
                    {
                        items[j].optional = box.Checked;
                        items[j].quantity = Convert.ToInt32(quant.Text);
                        items[j].description = desc.Text;
                        items[j].overage = (float)Convert.ToDouble(overage.Text);
                    }
                }
            }
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                CheckBox box = (CheckBox)GridView2.Rows[i].Cells[1].Controls[1];
                TextBox quant = (TextBox)GridView2.Rows[i].Cells[3].Controls[1];
                TextBox desc = (TextBox)GridView2.Rows[i].Cells[5].Controls[1];
                TextBox overage = (TextBox)GridView2.Rows[i].Cells[8].Controls[1];
                string name = GridView2.Rows[i].Cells[4].Text;
                string price = GridView2.Rows[i].Cells[7].Text;
                string unit = GridView2.Rows[i].Cells[6].Text;
                for (int j = 0; j < items.Count; j++)
                {
                    Item item = items[j];
                    if (item.item == name && item.unit == unit && "$" + item.price == price)
                    {
                        items[j].optional = box.Checked;
                        items[j].quantity = Convert.ToInt32(quant.Text);
                        items[j].description = desc.Text;
                        items[j].overage = (float)Convert.ToDouble(overage.Text);
                    }
                }
            }

            string rebuilt = "";
            foreach (Item item in items)
            {
                rebuilt += item.optional ? "1`" : "0`";
                rebuilt += item.status + "`";
                rebuilt += item.quantity + "`";
                rebuilt += item.itemID + "`";
                rebuilt += item.description + "`";
                rebuilt += item.price + "`";
                rebuilt += item.overage + "`";
                rebuilt += item.lockedTime;
                rebuilt += "~";
            }
            rebuilt = rebuilt.Substring(0, rebuilt.Length - 1);

            // Overall save algo
            cmdString = "Update [dbo].[Projects] Set ProjectName = @name, ProjectDescription = @desc, Length = @length, Width = @width, Items = @items Where ProjectID = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@name", Project_Name.Text.Substring(0, Project_Name.Text.Length - 1));
                    comm.Parameters.AddWithValue("@desc", Project_Desc.Text.Substring(0, Project_Desc.Text.Length - 1));
                    comm.Parameters.AddWithValue("@ID", projID);
                    comm.Parameters.AddWithValue("@length", LF.Text + "`" + LI.Text);
                    comm.Parameters.AddWithValue("@width", WF.Text + "`" + WI.Text);
                    comm.Parameters.AddWithValue("@items", rebuilt);
                    try
                    {
                        conn.Open();
                        comm.ExecuteNonQuery();
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        /// <summary>
        /// Delete an item from the Bid Proposal.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Deleted(object sender, GridViewDeleteEventArgs e)
        {
            //string[] arr = HttpContext.Current.Request.Url.AbsoluteUri.Split('?')[1].Split('&');
            //if (arr.Length > 1)
            //{
            //    customerId = arr[0];
            //    //customerId = arr[1];
            //    projectId = arr[2];
            //}
            //else
            //{
            //    return;
            //}

            string customerId = HttpContext.Current.Session["CurrentCustomerId"].ToString();
            string projectId = HttpContext.Current.Session["CurrentProjectId"].ToString();
            CustomerName.Value = HttpContext.Current.Session["CurrentCustomerName"].ToString();

            // Get the current Project Items.
            string items = "";
            string cmdString = "Select * From [dbo].[Projects] Where CustomerID=@ID AND ProjectID=@pID";
            string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", customerId);
                    comm.Parameters.AddWithValue("@pID", projectId);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                items = String.Format("{0}", reader["Items"]);
                            }
                        }
                    }
                    catch (Exception er)
                    {

                    }
                }
            }

            // Remove the selected item to be deleted from the Items string.
            int itemToBeDeletedId = (int)(e.RowIndex) - 1;
            string[] itemsSplit = items.Split('~');
            string rebuilt = "";
            for (int i = 0; i < itemsSplit.Length; i++)
            {
                if (i == itemToBeDeletedId)
                    continue;
                rebuilt += itemsSplit[i] + "~";
            }

            // Update the Items field string.
            cmdString = "Update [dbo].[Projects] Set Items=@items Where ProjectID = @ID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@Items", rebuilt);
                    comm.Parameters.AddWithValue("@ID", projectId);
                    try
                    {
                        conn.Open();
                        comm.ExecuteNonQuery();
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }
            Response.Redirect(Request.Url.AbsoluteUri);
        }


        protected void GenerateContract(object sender, EventArgs e)
        {
            string first = "";
            string last = "";
            string address = "";
            string city = "";
            string state = "";
            string zip = "";
            string phone = "";
            string aphone = "";
            string email = "";
            string jAdd = "";
            string jCity = "";
            string jZip = "";
            string permit = "";
            string lot = "";
            string block = "";
            string section = "";
            string book = "";
            string pg = "";
            string sub = "";
            string association = "";
            string newhome = "";
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

            string fileName = HttpRuntime.AppDomainAppPath + "Documents\\Contract1.docx";

            var doc = DocX.Load(fileName);

            doc.ReplaceText(underscored("totprce", grand.Text.Length), grand.Text);
            double grandT = Convert.ToDouble(grand.Text);
            string pricePart = String.Format("{0:0.00}", grandT / 10 + "");
            doc.ReplaceText(underscored("totprcp", pricePart.Length), pricePart);
            pricePart = String.Format("{0:0.00}", grandT * 0.30 + "");
            doc.ReplaceText(underscored("totprce", pricePart.Length), pricePart);
            pricePart = String.Format("{0:0.00}", grandT * 0.25 + "");
            doc.ReplaceText(underscored("totprcs", pricePart.Length), pricePart);

            int projID = -1;
            string cmdString = "select * from [dbo].[Customers] where CustomerID = @ID";
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
                                string pr = String.Format("{0}", reader["CurrentProject"]);
                                if (pr.Length < 1)
                                {
                                    pr = "-1";
                                }
                                projID = Convert.ToInt32(pr);
                                first = String.Format("{0}", reader["FirstName"]);
                                last = String.Format("{0}", reader["LastName"]);
                                address = String.Format("{0}", reader["Address"]);
                                city = String.Format("{0}", reader["City"]);
                                state = String.Format("{0}", reader["State"]);
                                zip = String.Format("{0}", reader["ZipCode"]);
                                phone = String.Format("{0}", reader["Telephone"]);
                                aphone = String.Format("{0}", reader["Alternate"]);
                                email = String.Format("{0}", reader["Email"]);
                                jAdd = String.Format("{0}", reader["JobAddress"]);
                                jCity = String.Format("{0}", reader["JobCity"]);
                                jZip = String.Format("{0}", reader["JobZip"]);
                                permit = String.Format("{0}", reader["JobPermit"]);
                                lot = String.Format("{0}", reader["JobLot"]);
                                block = String.Format("{0}", reader["JobBlock"]);
                                section = String.Format("{0}", reader["JobSection"]);
                                book = String.Format("{0}", reader["JobPlat"]);
                                pg = String.Format("{0}", reader["JobPage"]);
                                sub = String.Format("{0}", reader["JobARB"]);
                                association = String.Format("{0}", reader["JobARB"]);

                                // new home construction
                                if (String.Format("{0}", reader["NHSelection"]) == "Yes")
                                {
                                    string bName = String.Format("{0}", reader["NHBuilder"]);
                                    if (bName == "Other")
                                    {
                                        bName = String.Format("{0}", reader["NHOther"]);
                                    }
                                    else if (bName == "Select")
                                    {
                                        bName = "";
                                    }
                                    string line = underscored("jBN", bName.Length);
                                    doc.ReplaceText(line, bName);
                                    doc.ReplaceText("jNHCY", "X");
                                    doc.ReplaceText("jNHCN", "_");
                                }
                                else if (String.Format("{0}", reader["NHSelection"]).Length == 0 || String.Format("{0}", reader["NHSelection"]) == "No")
                                {
                                    doc.ReplaceText("jBN", "");
                                    doc.ReplaceText("jNHCY", "_");
                                    doc.ReplaceText("jNHCN", "X");
                                }

                                // association
                                string arb = String.Format("{0}", reader["JobARB"]);
                                if (arb != "Select" && arb != "None")
                                {
                                    string line = underscored("jAN", arb.Length);
                                    doc.ReplaceText(line, arb);
                                    doc.ReplaceText("jAMY", "X");
                                    doc.ReplaceText("jAMN", "_");
                                }
                                else
                                {
                                    doc.ReplaceText("jAN", "");
                                    doc.ReplaceText("jAMY", "_");
                                    doc.ReplaceText("jAMN", "X");
                                }

                                // initial survey and final survey
                                if (String.Format("{0}", reader["HTFS"]) == "Yes")
                                {
                                    if (String.Format("{0}", reader["SurveySelection"]) == "Both")
                                    {
                                        doc.ReplaceText("isfsy", "X");
                                        doc.ReplaceText("isfsn", "_");
                                    }
                                    else
                                    {
                                        doc.ReplaceText("isfsy", "_");
                                        doc.ReplaceText("isfsn", "X");
                                    }
                                }
                                else
                                {
                                    doc.ReplaceText("isfsy", "_");
                                    doc.ReplaceText("isfsn", "X");
                                }
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }

            // Date
            doc.ReplaceText("Date1", DateTime.Now.Month.ToString());  // Finds a text area and replaces it
            doc.ReplaceText("Date2", DateTime.Now.Day.ToString());
            doc.ReplaceText("Date3", DateTime.Now.Year.ToString());

            string[] labels = { "BuyerName", "addressC", "cityC", "stateC", "zipC", "mphoneC", "aphoneC", "emailC", "jAdd", "jCity", "jState", "jZip", "jPermit", "jLot", "jBlock", "jSection", "jBook", "jPG", "jSub" };
            string[] strs = { first + "_" + last, address, city, state, zip, phone, aphone, email, jAdd, jCity, "FL", jZip, permit, lot, block, section, book, pg, sub };

            for (int i = 0; i < labels.Length; i++)
            {
                string line = underscored(labels[i], strs[i].Length);
                doc.ReplaceText(line, strs[i]);
            }

            int benches = 1;
            int benchL = 5;
            int benches2 = 1;
            int benchL2 = 5;
            int defSteps = 20;
            int pumpSpd = 1;
            int pumpHP = 1;
            string pumpMa = "Hayward";
            string pumpMo = "Tristar";
            string itemstring = "";
            int filterq = 1;
            string fDE = "";
            string fCartridge = "";
            string fSand = "";
            string fS1 = "";
            string fS2 = "";
            int ledq = 1;
            string ledw = "X";
            string ledc = "";
            int saltSystemTimer = 0;
            cmdString = "Select * From [dbo].[Projects] Where CustomerID=@ID AND ProjectID=@pID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    comm.Parameters.AddWithValue("@pID", projID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                // pool selection ctrl + f to find this
                                if (String.Format("{0}", reader["ProjectType"]) == "Genesis")
                                {
                                    doc.ReplaceText("ezFlowSel", "_");
                                    doc.ReplaceText("genesisSel", "X");
                                    doc.ReplaceText("cpeh", "X");
                                    doc.ReplaceText("cpep", "_");
                                    doc.ReplaceText("MDGD", "X");
                                    doc.ReplaceText("MDGR", "_");
                                    doc.ReplaceText("swbs", "X");
                                    doc.ReplaceText("swbp", "_");
                                    doc.ReplaceText("EFlJn", "X");
                                    doc.ReplaceText("EFlJy", "_");
                                    doc.ReplaceText("EFlJq", "_");
                                    benchL = 4;
                                    benchL2 = 4;
                                    defSteps = 15;
                                    fS1 = "120";
                                    fCartridge = "X";
                                }
                                else if (String.Format("{0}", reader["ProjectType"]) == "EZ-Flow")
                                {
                                    doc.ReplaceText("MDGD", "_");
                                    doc.ReplaceText("MDGR", "X");
                                    doc.ReplaceText("ezFlowSel", "X");
                                    doc.ReplaceText("genesisSel", "_");
                                    doc.ReplaceText("srss8", "X");
                                    doc.ReplaceText("cpep", "X");
                                    doc.ReplaceText("cpeh", "_");
                                    doc.ReplaceText("swbs", "_");
                                    doc.ReplaceText("swbp", "X");
                                    doc.ReplaceText("EFlJn", "_");
                                    doc.ReplaceText("EFlJy", "X");
                                    doc.ReplaceText("EFlJq", "4");
                                    doc.ReplaceText("AChis", "X");
                                    doc.ReplaceText("AChil", "_");
                                    saltSystemTimer = 1;
                                    pumpSpd = 2;
                                    pumpHP = 3;
                                    pumpMo = "Super 2";
                                    fS1 = "4820";
                                    fDE = "X";
                                    ledq = 2;
                                    ledw = "";
                                    ledc = "X";
                                }

                                // pool dimensions
                                string length = String.Format("{0}", reader["Length"]).Replace("`", "'") + "\"";
                                if (length.Length == 2)
                                    length = "15'";

                                string width = String.Format("{0}", reader["Width"]).Replace("`", "'") + "\"";
                                if (width.Length == 2)
                                    width = "20'";

                                length = length.Replace("'0\"", "");
                                width = width.Replace("'0\"", "");
                                doc.ReplaceText(underscored("pDimsL", length.Length), length);
                                doc.ReplaceText(underscored("pDimsW", width.Length), width);

                                // pool perimeter
                                int ft = Convert.ToInt32(length.Split('\'')[0]) + Convert.ToInt32(width.Split('\'')[0]);
                                int inches = 0;
                                if (length.Split('"').Length > 1)
                                {
                                    inches += Convert.ToInt32(length.Split('\'')[1].Split('"')[0]);
                                }
                                if (width.Split('"').Length > 1)
                                {
                                    inches += Convert.ToInt32(width.Split('\'')[1].Split('"')[0]);
                                }

                                ft *= 2;
                                inches *= 2;
                                ft += (int)(inches / 12);

                                doc.ReplaceText(underscored("pLF", ft.ToString().Length), ft.ToString());

                                // pool area
                                float len = Convert.ToInt32(length.Split('\'')[0]);
                                float wid = Convert.ToInt32(width.Split('\'')[0]);
                                if (length.Split('"').Length > 1)
                                {
                                    len += Convert.ToInt32(length.Split('\'')[1].Split('"')[0]) / 12f;
                                }
                                if (width.Split('"').Length > 1)
                                {
                                    wid += Convert.ToInt32(width.Split('\'')[1].Split('"')[0]) / 12f;
                                }

                                int ar = (int)(len * wid);

                                doc.ReplaceText(underscored("WSASF", ar.ToString().Length), ar.ToString());

                                // Items
                                itemstring = String.Format("{0}", reader["Items"]);
                            }
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
            }


            List<Item> items = new List<Item>();
            List<string> categories = new List<string>();
            foreach (string str in itemstring.Split('~'))
            {
                string[] sArr = str.Split('`');
                if (sArr.Length < 5)
                {
                    break;
                }
                Item item = new Item();
                item.optional = sArr[0] == "0" ? false : true;
                item.status = sArr[1];
                item.quantity = Convert.ToInt32(sArr[2]);
                item.description = sArr[4];
                item.price = (float)Convert.ToDouble(sArr[5]);
                item.overage = (float)Convert.ToDouble(sArr[6]);
                item.lockedTime = DateTime.Parse(sArr[7]);

                cmdString = "Select * From PriceBook where ItemID=@ID";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand(cmdString, conn))
                    {
                        comm.Parameters.AddWithValue("@ID", Convert.ToInt32(sArr[3]));
                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = comm.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    item.item = String.Format("{0}", reader["Item"]);
                                    item.unit = String.Format("{0}", reader["Unit"]);
                                    string pric = String.Format("{0}", reader["CustomerPrice"]);
                                    item.currPrice = (float)Convert.ToDouble(pric);
                                    item.category = String.Format("{0}", reader["Category"]);
                                    item.subcategory = String.Format("{0}", reader["Subcategory"]);
                                    item.subsubcategory = String.Format("{0}", reader["Subsubcategory"]);
                                    if (!categories.Contains(item.category))
                                        categories.Add(item.category);
                                }
                            }
                        }
                        catch (SqlException err)
                        {

                        }
                    }
                }

                items.Add(item);
            }

            int solarPanels = 0;
            string depth1 = "";
            string depth2 = "";
            string depth3 = "";
            int rails = 0;
            int eyes = 3;
            int actuators = 0;
            int remoteLength = 0;
            int spillways = 0;
            int spilllength = 0;
            int spajets = 0;
            foreach (Item item in items)
            {
                // depths
                if (item.category.StartsWith("DEPTHS"))
                {
                    if (item.item.Contains("Deep End"))
                    {
                        depth3 = item.item.Split(' ')[0];
                    }
                    else if (item.item.Contains("Deep Shallow End"))
                    {
                        depth1 = item.item.Split(' ')[1];
                    }
                    else if (item.item.Contains("Sport"))
                    {
                        depth2 = "5'";
                    }
                }

                // access wall / fence
                else if (item.category.StartsWith("FENCES"))
                {
                    if (item.item.Contains("HIGH"))
                    {
                        doc.ReplaceText("fncny", "X");
                        doc.ReplaceText("fncnn", "X");
                        doc.ReplaceText(underscored("fncnl", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    if (item.item.Contains("Remove") || item.item.Contains("Re-Install"))
                    {
                        doc.ReplaceText("awfwp", "X");
                        doc.ReplaceText("awfwt_____", "Fence");
                        doc.ReplaceText("awfn", "_");
                    }
                    else if (item.subcategory.StartsWith("Vinyl"))
                    {
                        doc.ReplaceText("fncny", "X");
                        doc.ReplaceText("fncnn", "X");
                        doc.ReplaceText("fncntv", "X");
                        if (item.item.Contains("HIGH"))
                        {
                            string height = item.item.Split(' ')[0];
                            doc.ReplaceText("fncnhv__", "X");
                        }
                        if (item.item.Contains("Gate"))
                        {
                            doc.ReplaceText(underscored("fncnqv", item.quantity.ToString().Length), item.quantity.ToString());
                            if (item.item.Contains("4"))
                                doc.ReplaceText("fncnsv_", "4");
                            if (item.item.Contains("5"))
                                doc.ReplaceText("fncnsv_", "5");
                            if (item.item.Contains("8"))
                                doc.ReplaceText("fncnsv_", "8");
                        }
                        string color = "White";
                        if (item.subcategory.Contains("Tan"))
                        {
                            color = "Tan";
                        }
                        doc.ReplaceText(underscored("fncnc", color.Length), color);
                    }
                    else if (item.subcategory.StartsWith("Wood"))
                    {
                        doc.ReplaceText("fncny", "X");
                        doc.ReplaceText("fncnn", "X");
                        doc.ReplaceText("fncntw", "X");
                        if (item.item.Contains("HIGH"))
                        {
                            string height = item.item.Split(' ')[0];
                            doc.ReplaceText("fncnhw__", "X");
                        }
                        if (item.item.Contains("Gate"))
                        {
                            doc.ReplaceText(underscored("fncnqw", item.quantity.ToString().Length), item.quantity.ToString());
                            if (item.item.Contains("4"))
                                doc.ReplaceText("fncnsw_", "4");
                            if (item.item.Contains("5"))
                                doc.ReplaceText("fncnsw_", "5");
                            if (item.item.Contains("8"))
                                doc.ReplaceText("fncnsw_", "8");
                        }
                    }
                    else if (item.subcategory.StartsWith("Aluminum"))
                    {
                        doc.ReplaceText("fncny", "X");
                        doc.ReplaceText("fncnn", "X");
                        doc.ReplaceText("fncnta", "X");
                        if (item.item.Contains("HIGH"))
                        {
                            string height = item.item.Split(' ')[0];
                            doc.ReplaceText("fncnha__", "X");
                        }
                        if (item.item.Contains("Gate"))
                        {
                            doc.ReplaceText(underscored("fncnqa", item.quantity.ToString().Length), item.quantity.ToString());
                            if (item.item.Contains("4"))
                                doc.ReplaceText("fncnsa_", "4");
                            if (item.item.Contains("5"))
                                doc.ReplaceText("fncnsa_", "5");
                            if (item.item.Contains("8"))
                                doc.ReplaceText("fncnsa_", "8");
                        }
                    }
                    else if (item.subcategory.StartsWith("Chain"))
                    {
                        doc.ReplaceText("fncny", "X");
                        doc.ReplaceText("fncnn", "X");
                        doc.ReplaceText("fncntc", "X");
                        if (item.item.Contains("HIGH"))
                        {
                            string height = item.item.Split(' ')[0];
                            doc.ReplaceText("fncnhc__", "X");
                        }
                        if (item.item.Contains("Gate"))
                        {
                            doc.ReplaceText(underscored("fncnqc", item.quantity.ToString().Length), item.quantity.ToString());
                            if (item.item.Contains("4"))
                                doc.ReplaceText("fncnsc_", "4");
                            if (item.item.Contains("5"))
                                doc.ReplaceText("fncnsc_", "5");
                            if (item.item.Contains("8"))
                                doc.ReplaceText("fncnsc_", "8");
                        }
                    }
                }

                // demolition
                else if (item.category.StartsWith("DEMOLITION"))
                {
                    if (item.item.Contains("Shrubs"))
                    {
                        doc.ReplaceText("shrby", "X");
                        doc.ReplaceText("shrbn", "_");
                        doc.ReplaceText(underscored("shrbq", item.quantity.ToString().Length), item.quantity + "");
                    }
                    else if (item.item.Contains("Screen"))
                    {
                        doc.ReplaceText("escrny", "X");
                        doc.ReplaceText("escrnn", "_");
                        doc.ReplaceText(underscored("escrnq", item.quantity.ToString().Length), item.quantity + "");
                    }
                    else if (item.item.Contains("Roof"))
                    {
                        doc.ReplaceText("roofy", "X");
                        doc.ReplaceText("roofn", "_");
                        doc.ReplaceText(underscored("roofq", item.quantity.ToString().Length), item.quantity + "");
                    }
                    else if (item.item.Contains("Concrete"))
                    {
                        doc.ReplaceText("concy", "X");
                        doc.ReplaceText("concn", "_");
                        doc.ReplaceText(underscored("concq", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else if (item.item.Contains("Pavers"))
                    {
                        doc.ReplaceText("lspy", "X");
                        doc.ReplaceText("lspn", "_");
                        doc.ReplaceText(underscored("lspq", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else if (item.item.Contains("Paver Bricks"))
                    {
                        doc.ReplaceText("pavsy", "X");
                        doc.ReplaceText("pavsn", "_");
                        doc.ReplaceText(underscored("pavsq", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else if (item.item.Contains("Wall"))
                    {
                        doc.ReplaceText("wby", "X");
                        doc.ReplaceText("wbn", "_");
                        doc.ReplaceText(underscored("wbq", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else
                    {
                        doc.ReplaceText("omdy", "X");
                        doc.ReplaceText("omdn", "_");
                        doc.ReplaceText(underscored("omdq", item.quantity.ToString().Length), item.quantity.ToString());
                        doc.ReplaceText(underscored("omdt", item.item.Split('(')[0].Length), item.item.Split('(')[0]);
                    }
                }

                // stumps
                else if (item.category.StartsWith("STUMP REMOVAL"))
                {
                    doc.ReplaceText("stury", "X");
                    doc.ReplaceText("sturn", "_");
                    doc.ReplaceText(underscored("sturq", item.quantity.ToString().Length), item.quantity.ToString());
                    doc.ReplaceText(underscored("sturs", item.item.Split(' ')[0].Replace("If", "Extra Large").Length), item.item.Split(' ')[0].Replace("If", "Extra Large"));
                }

                // engineered steel reinforcement
                else if (item.category.StartsWith("PILING POOLS"))
                {
                    if (item.item.Contains("6\""))
                    {
                        doc.ReplaceText("esr6", "X");
                    }
                }
                else if (item.category.StartsWith("DECKING"))
                {
                    if (item.item.Contains("12\" o.c."))
                    {
                        doc.ReplaceText("esr12", "X");
                    }
                    if (item.item.Contains("Color Band"))
                    {
                        if (item.item.EndsWith("Only"))
                        {
                            doc.ReplaceText("clbnp", "X");
                        }
                        else
                        {
                            doc.ReplaceText("clbns", "X");
                        }
                        doc.ReplaceText("clbnp", "_");
                        doc.ReplaceText("clbns", "_");
                        doc.ReplaceText("clbny", "X");
                        doc.ReplaceText("clbnn", "_");
                    }
                    else if (item.item.StartsWith("Paint ONLY"))
                    {
                        doc.ReplaceText("edky", "X");
                    }
                    else if (item.item.StartsWith("Existing"))
                    {
                        if (item.item.Contains("Crack Repair"))
                        {
                            doc.ReplaceText("edkc", "X");
                            doc.ReplaceText(underscored("edkl", item.quantity.ToString().Length), item.quantity.ToString());
                        }
                        else if (item.item.Contains("Paint"))
                        {
                            doc.ReplaceText("edkt", "X");
                        }
                        doc.ReplaceText("edkt", "_");
                        doc.ReplaceText("edkc", "_");
                        doc.ReplaceText("edkl", "");
                        doc.ReplaceText("edky", "X");
                        doc.ReplaceText("edkn", "_");
                        doc.ReplaceText("edkh", "_");
                        doc.ReplaceText("edkk", "_");
                        doc.ReplaceText("edkv", "_");
                        doc.ReplaceText("edks", "_");
                        doc.ReplaceText("edki", "_");
                        doc.ReplaceText("edke", "_");
                    }
                    else
                    {
                        if (item.item.Equals("Broom Finish Concrete"))
                        {
                            doc.ReplaceText("nwdkb", "X");
                        }
                        else if (item.item.Contains("Thick"))
                        {
                            doc.ReplaceText("nwdkt", "X");
                        }
                        else if (item.subcategory.Equals("TRAVERTINE"))
                        {
                            doc.ReplaceText("nwdkp", "X");
                        }
                        else if (item.subcategory.Equals("PAVER"))
                        {
                            if (item.item.StartsWith("Cement-Set"))
                            {
                                doc.ReplaceText("nwdkc", "X");
                            }
                            else
                            {
                                doc.ReplaceText("nwdkv", "X");
                            }
                        }
                        else if (item.item.Contains("cantilever edge"))
                        {
                            doc.ReplaceText("nwdko", "X");
                        }
                        doc.ReplaceText("nwdko", "_");
                        doc.ReplaceText("nwdkc", "_");
                        doc.ReplaceText("nwdkv", "_");
                        doc.ReplaceText("nwdkp", "_");
                        doc.ReplaceText("nwdkt", "_");
                        doc.ReplaceText("nwdkb", "_");
                    }
                }
                else if (item.category.StartsWith("SHORING"))
                {
                    doc.ReplaceText("wwshrw", "X");
                    doc.ReplaceText(underscored("wwshrlf", item.quantity.ToString().Length), item.quantity.ToString());
                }
                else if (item.category.StartsWith("PLANTERS"))
                {
                    if (item.item.StartsWith("Flush"))
                    {
                        doc.ReplaceText("plntf", "X");
                    }
                    else
                    {
                        doc.ReplaceText("plntp", "X");
                    }
                    doc.ReplaceText("plntq", item.quantity.ToString());
                    doc.ReplaceText("plnty", "X");
                    doc.ReplaceText("plntn", "_");
                }

                else if (item.category.StartsWith("BOND BEAMS"))
                {
                    if (item.item.Contains("12"))
                    {
                        doc.ReplaceText("srss12", "X");
                    }
                }

                else if (item.category.StartsWith("STEPS"))
                {
                    if (item.item.Contains("Steps over"))
                    {
                        int num = defSteps + item.quantity;
                        doc.ReplaceText(underscored("sescf", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else if (item.item.Contains("4th"))
                    {
                        int num = 3 + item.quantity;
                        doc.ReplaceText(underscored("sescq", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else if (item.item.Contains("Step-Shelf"))
                    {
                        doc.ReplaceText("sstsy", "X");
                        doc.ReplaceText("sstsn", "_");
                    }
                }

                else if (item.category.StartsWith("POOL UNDERAGE"))
                {
                    if (item.item.Contains("Color Light"))
                    {
                        ledq--;
                    }
                    if (item.item.Contains("Steps"))
                    {
                        int num = defSteps - item.quantity;
                        if (num > 0)
                            doc.ReplaceText(underscored("sescf", item.quantity.ToString().Length), item.quantity.ToString());
                        else
                        {
                            doc.ReplaceText("seby", "_");
                            doc.ReplaceText("sebn", "X");
                        }
                    }
                    if (item.item.Contains("Swim-out"))
                    {
                        int num = benchL2 - item.quantity;
                        if (num > 0)
                            benchL2 -= item.quantity;
                        else
                        {
                            doc.ReplaceText("swoq", "");
                            doc.ReplaceText("swo1", "");
                            doc.ReplaceText("swo2", "");
                            doc.ReplaceText("swol", "");
                            doc.ReplaceText("swoy", "_");
                            doc.ReplaceText("swon", "X");
                        }
                    }
                }

                else if (item.category.StartsWith("BENCHES"))
                {
                    if (item.item.Contains("Shallow end Bench"))
                    {
                        benches++;
                        benchL += item.quantity;
                    }
                    if (item.item.Contains("Additional Shallow"))
                    {
                        benches += item.quantity;
                    }
                    if (item.item.StartsWith("Swim-out"))
                    {
                        benches2++;
                        benchL2 += item.quantity;
                    }
                    if (item.item.Contains("Additional Swim-Out"))
                    {
                        benches2 += item.quantity;
                    }
                }

                else if (item.category.StartsWith("LADDERS"))
                {
                    doc.ReplaceText("swoq", "");
                    doc.ReplaceText("swo1", "");
                    doc.ReplaceText("swo2", "");
                    doc.ReplaceText("swol", "X");
                }

                else if (item.category.StartsWith("HAND RAILS"))
                {
                    rails += item.quantity;
                    doc.ReplaceText("hndry", "X");
                    doc.ReplaceText("hndrn", "_");
                    if (item.item.Contains("Figure"))
                    {
                        doc.ReplaceText("hndrf", "X");
                    }
                    else if (item.item.Contains("Contemporary"))
                    {
                        doc.ReplaceText("hndrc", "X");
                    }
                    else if (item.item.Contains("Step"))
                    {
                        doc.ReplaceText("hndrd", "X");
                    }
                }

                else if (item.category.StartsWith("PLUMBING LINES"))
                {
                    if (item.item.Contains("Over 30' Long"))
                    {
                        doc.ReplaceText("petbi", 30 + item.quantity + "");
                    }
                    if (item.item.Contains("Additional Skimmer"))
                    {
                        doc.ReplaceText("swbq", (item.quantity + 1) + "");
                    }
                }

                else if (item.category.StartsWith("PUMPS"))
                {
                    if (item.item.Contains("Upgrade"))
                    {
                        if (item.item.Contains("VS"))
                        {
                            pumpSpd = 3;
                        }
                        if (item.item.Contains("1.5"))
                        {
                            pumpHP = 3;
                            pumpMa = "Hayward";
                            pumpMo = "Super 2";
                        }
                        else if (item.item.Contains("900 VS"))
                        {
                            pumpHP = 4;
                            pumpMa = "Tristar";
                            pumpMo = "900 VS";
                        }
                        else if (item.item.Contains("950 VS"))
                        {
                            pumpHP = 6;
                            pumpMa = "Tristar";
                            pumpMo = "950 VS";
                        }
                    }
                    else if (item.item.Contains("Additional"))
                    {
                        doc.ReplaceText("addpumpy", "X");
                        doc.ReplaceText("addpumpn", "_");
                        string hp = "3/4";
                        if (item.item.Contains("Tristar"))
                        {
                            doc.ReplaceText("addpumpm_______", "Tristar");
                            if (item.item.Contains("900"))
                            {
                                hp = "1.85";
                                doc.ReplaceText("addpumps", "_");
                                doc.ReplaceText("addpump2", "_");
                                doc.ReplaceText("addpumpv", "X");
                            }
                            else if (item.item.Contains("950"))
                            {
                                hp = "2.5";
                                doc.ReplaceText("addpumps", "_");
                                doc.ReplaceText("addpump2", "_");
                                doc.ReplaceText("addpumpv", "X");
                            }
                            else
                            {
                                doc.ReplaceText("addpumps", "X");
                                doc.ReplaceText("addpump2", "_");
                                doc.ReplaceText("addpumpv", "_");
                            }
                        }
                        else
                        {
                            doc.ReplaceText("addpumpm_______", "Hayward");
                            hp = "1.5";
                            doc.ReplaceText("addpumps", "_");
                            doc.ReplaceText("addpump2", "X");
                            doc.ReplaceText("addpumpv", "_");
                        }
                        doc.ReplaceText("addpumph___", hp);
                    }
                }

                else if (item.category.StartsWith("FILTERS"))
                {
                    if (item.item.Contains("175"))
                    {
                        fCartridge = "X";
                        fDE = "";
                        fSand = "";
                        fS1 = "175";
                    }
                    else if (item.item.Contains("To 3620"))
                    {
                        fCartridge = "";
                        fDE = "X";
                        fSand = "";
                        fS1 = "3620";
                    }
                    else if (item.item.Contains("To 4820"))
                    {
                        fCartridge = "";
                        fDE = "X";
                        fSand = "";
                        fS1 = "4820";
                    }
                    else if (item.item.Contains("To 6020"))
                    {
                        fCartridge = "";
                        fDE = "X";
                        fSand = "";
                        fS1 = "6020";
                    }
                    else if (item.item.Contains("To 7220"))
                    {
                        fCartridge = "";
                        fDE = "X";
                        fSand = "";
                        fS1 = "7220";
                    }
                    else if (item.item.Contains("Sand"))
                    {
                        fCartridge = "";
                        fDE = "";
                        fSand = "X";
                        fS1 = "";
                    }

                    if (item.item.Contains("ADDITIONAL"))
                    {
                        filterq++;
                        fS2 = item.item.Split(' ')[0];
                    }
                }

                else if (item.category.Contains("LIGHTING"))
                {
                    if (item.item.Contains("Upgrade"))
                    {
                        ledw = "";
                        ledc = "X";
                    }
                    else
                    {
                        ledq++;
                        if (item.item.Contains("Color"))
                        {
                            ledw = "";
                            ledc = "X";
                        }
                    }
                }


                else if (item.category.Contains("HEATERS"))
                {
                    doc.ReplaceText("htry", "X");
                    doc.ReplaceText("htrn", "_");
                    if (item.subcategory.StartsWith("GAS"))
                    {
                        doc.ReplaceText("htrgl", "X");
                        doc.ReplaceText("htrgn", "_");
                        doc.ReplaceText("htrgg", "X");
                        doc.ReplaceText(underscored("htrgm", 7), "Hayward");
                        if (item.item.Contains("H400"))
                        {
                            doc.ReplaceText(underscored("htrgb", 7), "400,000");
                        }
                        else
                        {
                            doc.ReplaceText(underscored("htrgb", 7), "250,000");
                        }
                        doc.ReplaceText("htrem", "_");
                        doc.ReplaceText("htree", "_");
                        doc.ReplaceText("htreb", "_");
                        doc.ReplaceText("htrel", "_");
                        doc.ReplaceText("htrsm", "_");
                        doc.ReplaceText("htrss", "_");
                        doc.ReplaceText("htrsp", "_");
                        doc.ReplaceText("htrst", "_");
                    }
                    else if (item.subcategory.StartsWith("ELECTRIC"))
                    {
                        doc.ReplaceText(underscored("htrem", item.subsubcategory.Length), item.subsubcategory);
                        doc.ReplaceText("htree", "X");
                        string selectedbtu = "";
                        string[] strss = { "145", "120", "150", "225", "166", "115", "135", "110", "140", "125" };
                        foreach (string str in strss)
                        {
                            if (item.item.Contains(str))
                            {
                                selectedbtu = str;
                                doc.ReplaceText("htreb___", str);
                                break;
                            }
                        }
                        if (item.subsubcategory.StartsWith("HAYWARD"))
                        {
                            if (item.item.Contains("LOW"))
                            {
                                string str = selectedbtu + "K LA";
                                doc.ReplaceText(underscored("htrel", str.Length), str);
                            }
                            else
                            {
                                string str = selectedbtu + "K";
                                doc.ReplaceText(underscored("htrel", str.Length), str);
                            }
                        }
                        else if (item.item.StartsWith("T"))
                        {
                            string str = "T" + selectedbtu;
                            doc.ReplaceText(underscored("htrel", str.Length), str);
                        }
                        else
                        {
                            string str = "SQ " + selectedbtu;
                            if (item.item.Length > 6 && item.item[6] == 'R')
                            {
                                str += "R";
                            }
                            doc.ReplaceText(underscored("htrel", str.Length), str);
                        }
                        doc.ReplaceText("htrgl", "_");
                        doc.ReplaceText("htrgn", "_");
                        doc.ReplaceText("htrgg", "_");
                        doc.ReplaceText("htrgm", "_");
                        doc.ReplaceText("htrgb", "_");
                        doc.ReplaceText("htrsm", "_");
                        doc.ReplaceText("htrss", "_");
                        doc.ReplaceText("htrsp", "_");
                        doc.ReplaceText("htrst", "_");
                    }
                    else if (item.subcategory.StartsWith("SOLAR"))
                    {
                        doc.ReplaceText("htrsm", "_");
                        doc.ReplaceText("htrss", "X");
                        doc.ReplaceText("htrst", "_");
                        doc.ReplaceText("htrgl", "_");
                        doc.ReplaceText("htrgn", "_");
                        doc.ReplaceText("htrgg", "_");
                        doc.ReplaceText("htrgm", "_");
                        doc.ReplaceText("htrgb", "_");
                        doc.ReplaceText("htrem", "_");
                        doc.ReplaceText("htree", "_");
                        doc.ReplaceText("htreb", "_");
                        doc.ReplaceText("htrel", "_");
                    }
                }
                else if (item.category.StartsWith("VACUUM"))
                {
                    doc.ReplaceText("apcp", "X");
                    doc.ReplaceText("apcy", "X");
                    doc.ReplaceText("apcn", "_");
                    if (item.item.Contains("360"))
                    {
                        doc.ReplaceText(underscored("apcm", 11), "Polaris 360");
                    }
                    if (item.item.Contains("280"))
                    {
                        doc.ReplaceText(underscored("apcm", 11), "Polaris 280");
                    }
                }
                else if (item.category.StartsWith("AUTOMATION"))
                {

                    if (item.item.Contains("Rainbow"))
                    {
                        doc.ReplaceText("AChis", "_");
                        doc.ReplaceText("AChil", "X");
                        doc.ReplaceText("AChin", "_");
                        doc.ReplaceText("AChiy", "X");
                    }
                    else if (item.item.StartsWith("Upgrade"))
                    {
                        doc.ReplaceText("AChis", "X");
                        doc.ReplaceText("AChil", "_");
                        doc.ReplaceText("AChin", "_");
                        doc.ReplaceText("AChiy", "X");
                        if (item.item.Contains("To Pool Pilot"))
                        {
                            doc.ReplaceText("sltsys", "_");
                            doc.ReplaceText("sltsya", "_");
                            doc.ReplaceText("sltsyp", "_");
                            doc.ReplaceText("sltsym", "_");
                            doc.ReplaceText(underscored("sltsyo", 10), "Pool Pilot");
                        }
                        else if (item.item.Contains("To Chlor Sync"))
                        {
                            doc.ReplaceText("sltsys", "_");
                            doc.ReplaceText("sltsya", "_");
                            doc.ReplaceText("sltsyp", "_");
                            doc.ReplaceText("sltsym", "_");
                            doc.ReplaceText(underscored("sltsyo", 10), "Chlor Sync");
                        }
                        if (item.item.Contains("Actuators"))
                        {
                            actuators += 2;
                        }
                        if (item.item.Contains("Wireless"))
                        {
                            doc.ReplaceText("AuCoL", "_");
                            doc.ReplaceText("AuCoW", "_");
                            doc.ReplaceText("AuCoC", "X");
                            doc.ReplaceText("AuCoY", "X");
                            doc.ReplaceText("AuCoN", "_");
                        }
                        else if (item.item.Contains("Wired"))
                        {
                            doc.ReplaceText("AuCoL", "_");
                            doc.ReplaceText("AuCoW", "X");
                            doc.ReplaceText("AuCoC", "_");
                            doc.ReplaceText("AuCoY", "X");
                            doc.ReplaceText("AuCoN", "_");
                        }
                        else
                        {
                            doc.ReplaceText("AuCoL", "X");
                            doc.ReplaceText("AuCoW", "_");
                            doc.ReplaceText("AuCoC", "_");
                            doc.ReplaceText("AuCoY", "X");
                            doc.ReplaceText("AuCoN", "_");
                        }
                        if (item.item.Contains("Table"))
                        {
                            doc.ReplaceText("wcopc", "_");
                            doc.ReplaceText("wcopa", "_");
                            doc.ReplaceText("wcopt", "X");
                            doc.ReplaceText("wcopp", "_");
                            doc.ReplaceText("wcopo", "_");
                        }
                        else if (item.item.Contains("Aqua Connect"))
                        {
                            doc.ReplaceText("wcopc", "_");
                            doc.ReplaceText("wcopa", "X");
                            doc.ReplaceText("wcopt", "_");
                            doc.ReplaceText("wcopp", "_");
                            doc.ReplaceText("wcopo", "_");
                        }
                        else if (item.item.Contains("Aqua Pod"))
                        {
                            doc.ReplaceText("wcopc", "_");
                            doc.ReplaceText("wcopa", "_");
                            doc.ReplaceText("wcopt", "_");
                            doc.ReplaceText("wcopp", "X");
                            doc.ReplaceText("wcopo", "_");
                        }
                    }
                    if (item.item.Contains("Wireless"))
                    {
                        doc.ReplaceText("AuCoL", "_");
                        doc.ReplaceText("AuCoW", "_");
                        doc.ReplaceText("AuCoC", "X");
                        doc.ReplaceText("AuCoY", "X");
                        doc.ReplaceText("AuCoN", "_");
                    }
                    else if (item.item.Contains("Wired"))
                    {
                        doc.ReplaceText("AuCoL", "_");
                        doc.ReplaceText("AuCoW", "X");
                        doc.ReplaceText("AuCoC", "_");
                        doc.ReplaceText("AuCoY", "X");
                        doc.ReplaceText("AuCoN", "_");
                    }
                    if (item.item.Contains("Omni Logic"))
                    {
                        doc.ReplaceText("wcopc", "_");
                        doc.ReplaceText("wcopa", "_");
                        doc.ReplaceText("wcopt", "_");
                        doc.ReplaceText("wcopp", "_");
                        doc.ReplaceText("wcopo", "X");
                    }
                    if (item.item.StartsWith("Pool Sync"))
                    {
                        doc.ReplaceText("wcopc", "X");
                        doc.ReplaceText("wcopa", "_");
                        doc.ReplaceText("wcopt", "_");
                        doc.ReplaceText("wcopp", "_");
                        doc.ReplaceText("wcopo", "_");
                    }
                    if (item.item.StartsWith("Sense"))
                    {
                        doc.ReplaceText("schasd", "X");
                        doc.ReplaceText("schasu", "_");
                        doc.ReplaceText("schaso", "_");
                        doc.ReplaceText("schasb", "_");
                        doc.ReplaceText("schasy", "X");
                        doc.ReplaceText("schasn", "_");
                    }
                    else if (item.item.StartsWith("UV S"))
                    {
                        doc.ReplaceText("schasd", "_");
                        doc.ReplaceText("schasu", "X");
                        doc.ReplaceText("schaso", "_");
                        doc.ReplaceText("schasb", "_");
                        doc.ReplaceText("schasy", "X");
                        doc.ReplaceText("schasn", "_");
                    }
                    else if (item.item.StartsWith("Ozone"))
                    {
                        doc.ReplaceText("schasd", "_");
                        doc.ReplaceText("schasu", "_");
                        doc.ReplaceText("schaso", "X");
                        doc.ReplaceText("schasb", "_");
                        doc.ReplaceText("schasy", "X");
                        doc.ReplaceText("schasn", "_");
                    }
                    else if (item.item.StartsWith("UV /"))
                    {
                        doc.ReplaceText("schasd", "_");
                        doc.ReplaceText("schasu", "_");
                        doc.ReplaceText("schaso", "_");
                        doc.ReplaceText("schasb", "X");
                        doc.ReplaceText("schasy", "X");
                        doc.ReplaceText("schasn", "_");
                    }
                }
                else if (item.category.StartsWith("ELECTRICAL"))
                {
                    if (item.item.StartsWith("Remote Location Hook"))
                    {
                        remoteLength += item.quantity;
                    }
                }
                else if (item.category.StartsWith("FOOTERS"))
                {
                    if (item.item.Contains("Wide"))
                    {
                        if (item.item.Contains("10"))
                        {
                            doc.ReplaceText("ftrw10", "X");
                        }
                        else if (item.item.Contains("12\" Wide"))
                        {
                            doc.ReplaceText("ftrw12", "X");
                        }
                        else if (item.item.Contains("2'"))
                        {
                            doc.ReplaceText("ftrw2", "X");
                        }
                        else if (item.item.Contains("3'"))
                        {
                            doc.ReplaceText("ftrw3", "X");
                        }
                        doc.ReplaceText("ftrw10", "_");
                        doc.ReplaceText("ftrw12", "_");
                        doc.ReplaceText("ftrw2", "_");
                        doc.ReplaceText("ftrw3", "_");
                    }
                    else if (item.item.StartsWith("Extended"))
                    {
                        if (item.item.Contains("12"))
                        {
                            doc.ReplaceText("ftrwh___", "_12");
                        }
                        else if (item.item.Contains("13"))
                        {
                            doc.ReplaceText("ftrwh_____", "13-18");
                        }
                        else if (item.item.Contains("19"))
                        {
                            doc.ReplaceText("ftrwh_____", "19-24");
                        }
                        doc.ReplaceText("ftrwe", "X");
                    }
                }
                else if (item.category.StartsWith("COPING"))
                {
                    if (item.item.Equals("Concrete Coping Band with Paver Deck"))
                    {
                        doc.ReplaceText("cbcin", "_");
                        doc.ReplaceText("cbciy", "X");
                    }
                    else
                    {
                        if (item.item.StartsWith("Artistic Paver"))
                        {
                            doc.ReplaceText("CpngA", "X");
                            doc.ReplaceText(underscored("CpngI", item.quantity.ToString().Length), item.quantity.ToString());
                        }
                        else if (item.item.Contains("Natural Rock"))
                        {
                            doc.ReplaceText("CpngN", "X");
                        }
                        else if (item.item.Contains("Paver"))
                        {
                            doc.ReplaceText("CpngB", "X");
                        }
                        else if (item.item.Contains("Bullnose Brick"))
                        {
                            doc.ReplaceText("CpngT", "X");
                            doc.ReplaceText(underscored("CpngS", item.quantity.ToString().Length), item.quantity.ToString());
                        }
                        doc.ReplaceText("CpngC", "_");
                        doc.ReplaceText("CpngB", "_");
                        doc.ReplaceText("CpngT", "_");
                        doc.ReplaceText("CpngS", "");
                        doc.ReplaceText("CpngA", "_");
                        doc.ReplaceText("CpngI", "");
                        doc.ReplaceText("CpngN", "_");
                    }
                }
                else if (item.category.StartsWith("DECO DRAIN"))
                {
                    if (item.item.Contains("Drain") && !item.item.Contains("ONLY"))
                    {
                        if (item.item.StartsWith("2"))
                            doc.ReplaceText("ssdd2", "X");
                        else if (item.item.StartsWith("3"))
                            doc.ReplaceText("ssdd3", "X");
                        else if (item.item.StartsWith("4"))
                            doc.ReplaceText("ssdd4", "X");
                        else if (item.item.StartsWith("French"))
                            doc.ReplaceText("ssddc______", "French");
                        else if (item.item.StartsWith("Shower"))
                            doc.ReplaceText("ssddc______", "Shower");

                        doc.ReplaceText("ssdd1", "_");
                    }
                }
                else if (item.category.StartsWith("STEP RISERS"))
                {
                    if (item.item.Contains("Tiled"))
                    {
                        doc.ReplaceText("strpt", "X");
                    }
                    else if (item.item.Contains("Paver"))
                    {
                        doc.ReplaceText("strpp", "X");
                    }
                    else if (item.item.Contains("Travertine"))
                    {
                        doc.ReplaceText("strpa", "X");
                    }
                    else if (item.item.Contains("Paint"))
                    {
                        doc.ReplaceText("strpb", "X");
                    }
                    else if (item.item.Contains("Stairwell"))
                    {
                        doc.ReplaceText(underscored("strpo", 15), "Stairwell Steps");
                    }
                    doc.ReplaceText("strpy", "X");
                    doc.ReplaceText("strpn", "_");
                }
                else if (item.category.StartsWith("ELEVATIONS"))
                {
                    if (item.item.StartsWith("6"))
                    {
                        doc.ReplaceText("epwh6", "X");
                        doc.ReplaceText("epwhy", "X");
                        doc.ReplaceText("epwhn", "_");
                    }
                    else if (item.item.StartsWith("12"))
                    {
                        doc.ReplaceText("epwh2", "X");
                        doc.ReplaceText("epwhy", "X");
                        doc.ReplaceText("epwhn", "_");
                    }
                    else if (item.item.StartsWith("18"))
                    {
                        doc.ReplaceText("epwh8", "X");
                        doc.ReplaceText("epwhy", "X");
                        doc.ReplaceText("epwhn", "_");
                    }
                    else if (item.item.StartsWith("24"))
                    {
                        doc.ReplaceText("epwh4", "X");
                        doc.ReplaceText("epwhy", "X");
                        doc.ReplaceText("epwhn", "_");
                    }

                }
                else if (item.category.StartsWith("HAND HOLDS"))
                {
                    doc.ReplaceText("epwhh", "X");
                    doc.ReplaceText("epwhy", "X");
                    doc.ReplaceText("epwhn", "_");
                    doc.ReplaceText(underscored("epwhq", item.quantity.ToString().Length), item.quantity.ToString());
                }
                else if (item.category.StartsWith("SCREEN ENCLOSURE"))
                {
                    if (item.item.Contains("Mansard"))
                    {
                        doc.ReplaceText("scencm", "X");
                        doc.ReplaceText("scencq_", item.quantity.ToString());
                        doc.ReplaceText("scency", "X");
                        doc.ReplaceText("scencn", "_");
                    }
                    else if (item.item.Contains("Dome"))
                    {
                        doc.ReplaceText("scencd", "X");
                        doc.ReplaceText("scencq_", item.quantity.ToString());
                        doc.ReplaceText("scency", "X");
                        doc.ReplaceText("scencn", "_");
                    }
                    else if (item.item.Contains("Picture"))
                    {
                        doc.ReplaceText("scencp", "X");
                        doc.ReplaceText("scencq_", item.quantity.ToString());
                        doc.ReplaceText("scency", "X");
                        doc.ReplaceText("scencn", "_");
                    }
                    else if (item.item.Contains("18 / 14"))
                    {
                        doc.ReplaceText("scenc8", "X");
                        doc.ReplaceText("scencs", "X");
                        doc.ReplaceText("scenco", "_");
                    }
                    else if (item.item.Contains("20/20"))
                    {
                        doc.ReplaceText("scenc2", "X");
                        doc.ReplaceText("scencs", "X");
                        doc.ReplaceText("scenco", "_");
                    }
                    else if (item.item.Contains("16\" High"))
                    {
                        doc.ReplaceText("scenck", "X");
                        doc.ReplaceText("scencz__", "16");
                        doc.ReplaceText("scencs", "X");
                        doc.ReplaceText("scenco", "_");
                    }
                    else if (item.item.Contains("24\" High"))
                    {
                        doc.ReplaceText("scenck", "X");
                        doc.ReplaceText("scencz__", "24");
                        doc.ReplaceText("scencs", "X");
                        doc.ReplaceText("scenco", "_");
                    }
                }
                else if (item.category.StartsWith("DOGGY DOORS"))
                {
                    doc.ReplaceText("scencg", "X");
                    if (item.item.StartsWith("Medium"))
                    {
                        doc.ReplaceText("scenci___", "M");
                    }
                    if (item.item.StartsWith("Large"))
                    {
                        doc.ReplaceText("scenci_", "L");
                    }
                    if (item.item.StartsWith("X-Large"))
                    {
                        doc.ReplaceText("scenci__", "XL");
                    }
                }
                else if (item.category.StartsWith("ELITE ROOF"))
                {
                    if (item.item.StartsWith("3"))
                    {
                        doc.ReplaceText(underscored("eltrss", item.quantity.ToString().Length), item.quantity.ToString());
                        doc.ReplaceText("eltrsy", "X");
                        doc.ReplaceText("eltrsn", "_");
                    }
                    else if (item.item.Contains("No"))
                    {
                        doc.ReplaceText("eltrsf", "X");
                        doc.ReplaceText("eltrsy", "X");
                        doc.ReplaceText("eltrsn", "_");
                    }
                    else
                    {
                        doc.ReplaceText("eltrsb", "_");
                        doc.ReplaceText("eltrsy", "X");
                        doc.ReplaceText("eltrsn", "_");
                    }
                }
                else if (item.category.StartsWith("ALARMS"))
                {
                    if (item.item.Equals("Alarm"))
                    {
                        doc.ReplaceText("rqbrw", "X");
                        doc.ReplaceText(underscored("rqbrq", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else if (item.item.Contains("Pool Side"))
                    {
                        doc.ReplaceText("rqbrp", "X");
                        doc.ReplaceText(underscored("rqbrt", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else if (item.item.Equals("Baby Fence"))
                    {
                        doc.ReplaceText("rqbrb", "X");
                        doc.ReplaceText(underscored("rqbrl", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                    else if (item.item.Contains("Self"))
                    {
                        doc.ReplaceText("rqbrs", "X");
                        doc.ReplaceText(underscored("rqbry", item.quantity.ToString().Length), item.quantity.ToString());
                    }
                }
                else if (item.category.StartsWith("WALLS"))
                {
                    if (item.item.Contains("Retaining"))
                    {
                        doc.ReplaceText("blkwl", "X");
                        doc.ReplaceText("blkwy", "X");
                        doc.ReplaceText("blkwn", "_");
                    }
                    else if (item.item.Contains("Stucco Only"))
                    {
                        doc.ReplaceText("blkwt", "X");
                        doc.ReplaceText("blkwy", "X");
                        doc.ReplaceText("blkwn", "_");
                    }
                    else if (item.item.Contains("Paint Only"))
                    {
                        doc.ReplaceText("blkwp", "X");
                        doc.ReplaceText("blkwy", "X");
                        doc.ReplaceText("blkwn", "_");
                    }
                    else if (item.item.Contains("Stucco and Paint"))
                    {
                        doc.ReplaceText("blkwb", "X");
                        doc.ReplaceText("blkwy", "X");
                        doc.ReplaceText("blkwn", "_");
                    }
                }
                else if (item.category.StartsWith("TILE"))
                {
                    if (item.item.Contains("Lap Lane"))
                        doc.ReplaceText("bndwlu", "X");
                    if (item.item.Contains("Natural Stone"))
                        doc.ReplaceText("bndwln", "X");

                    if (item.item.Contains("Lined"))
                    {
                        doc.ReplaceText("inrtil", "X");
                        doc.ReplaceText("inrtiy", "X");
                        doc.ReplaceText("inrtin", "_");
                    }
                    else if (item.item.Contains("Steps and Benches"))
                    {
                        doc.ReplaceText("inrtib", "X");
                        doc.ReplaceText("inrtiy", "X");
                        doc.ReplaceText("inrtin", "_");
                    }
                    else if (item.item.Contains("Cap Tile"))
                    {
                        doc.ReplaceText("inrtic", "X");
                        doc.ReplaceText("inrtiy", "X");
                        doc.ReplaceText("inrtin", "_");
                    }
                }
                else if (item.category.StartsWith("WATERFALLS"))
                {
                    if (item.item.Equals("(1) Deck Jet Fountain with Valve"))
                    {
                        doc.ReplaceText("WFdjx", "X");
                        doc.ReplaceText("WFdjq", item.quantity.ToString());
                    }
                    else if (item.item.Equals("(2) Deck Jet Fountains with Valve"))
                    {
                        doc.ReplaceText("WFdjx", "X");
                        doc.ReplaceText("WFdjq", (item.quantity * 2).ToString());
                    }
                    else if (item.item.Equals("Bubbler Fountain with Valve"))
                    {
                        doc.ReplaceText("WFbb", "X");
                        doc.ReplaceText("WFbq", item.quantity.ToString());
                    }
                    else if (item.item.Equals("LED Lighted Bubbler Fountain with Valve"))
                    {
                        doc.ReplaceText("WFlbb", "X");
                        doc.ReplaceText("WFlbq", item.quantity.ToString());
                    }
                    else if (item.item.Contains("LED Sheer Waterfall"))
                    {
                        doc.ReplaceText("WFlss", "X");
                        doc.ReplaceText("WFlsz", item.item.Split('\'')[0]);
                        doc.ReplaceText("WFlsq", item.quantity.ToString());
                    }
                    else if (item.item.Contains("Sheer Waterfall"))
                    {
                        doc.ReplaceText("WFss", "X");
                        doc.ReplaceText("WFsz", item.item.Split('\'')[0]);
                        doc.ReplaceText("WFsq", item.quantity.ToString());
                    }
                    else if (item.item.Contains("ARC"))
                    {

                        doc.ReplaceText("WFsas", "X");
                        doc.ReplaceText("WFsaz", item.item.Split('\'')[0]);
                        doc.ReplaceText("WFsaq", item.quantity.ToString());
                    }
                    else if (item.item.Contains("Laminar"))
                    {
                        doc.ReplaceText("WFlas", "X");
                        doc.ReplaceText("WFlaq", item.quantity.ToString());
                    }
                    else if (item.subcategory.StartsWith("ROCKS"))
                    {
                        doc.ReplaceText("WFrs", "X");
                        doc.ReplaceText("WFrh", item.item.Split('\'')[0]);
                        doc.ReplaceText("WFrq", item.quantity.ToString());
                    }
                    else if (item.subcategory.StartsWith("ACCENT"))
                    {
                        doc.ReplaceText("WFas", "X");
                        doc.ReplaceText("WFad", item.item.Split('"')[0]);
                        doc.ReplaceText("WFaq", item.quantity.ToString());
                    }
                    else if (item.subcategory.StartsWith("FIRE BOWLS"))
                    {
                        doc.ReplaceText("WFfs", "X");
                        doc.ReplaceText("WFfq", item.quantity.ToString());
                    }
                    else if (item.subcategory.StartsWith("WATER BOWLS"))
                    {
                        doc.ReplaceText("WFws", "X");
                        doc.ReplaceText("WFwq", item.quantity.ToString());
                    }
                    else if (item.subcategory.StartsWith("FIRE / WATER"))
                    {
                        doc.ReplaceText("WFfws", "X");
                        doc.ReplaceText("WFfwq", item.quantity.ToString());
                    }
                    else if (item.subcategory.StartsWith("LED LIGHTED WATER"))
                    {
                        doc.ReplaceText("WFlwb", "X");
                        doc.ReplaceText("WFlwq", item.quantity.ToString());
                    }
                    doc.ReplaceText("WFOFy", "X");
                    doc.ReplaceText("WFOFn", "_");
                }
                else if (item.category.Equals("SPAS"))
                {
                    if (item.subcategory.StartsWith("EZ"))
                    {
                        doc.ReplaceText("TFmr", "X");
                        spajets = 6;
                        doc.ReplaceText("TFLc", "X");
                    }
                    else if (item.subcategory.StartsWith("GEN"))
                    {
                        doc.ReplaceText("TFmd", "X");
                        spajets = 4;
                        doc.ReplaceText("TFLw", "X");
                    }
                    doc.ReplaceText("TFmy", "X");
                    doc.ReplaceText("TFmn", "_");
                    if (item.item.Contains("19 P.F."))
                    {
                        doc.ReplaceText("TFss__", "30");
                        doc.ReplaceText("TFip__", "19");
                        doc.ReplaceText("TFdr6", "X");
                    }
                    else if (item.item.Contains("22 P.F."))
                    {
                        doc.ReplaceText("TFip__", "22");
                        doc.ReplaceText("TFss__", "38");
                        doc.ReplaceText("TFdr7", "X");
                    }
                    else if (item.item.Contains("24 P.F."))
                    {
                        doc.ReplaceText("TFip__", "24");
                        doc.ReplaceText("TFss__", "36");
                        doc.ReplaceText("TFsq6", "X");
                    }
                    else if (item.item.Contains("26 P.F."))
                    {
                        doc.ReplaceText("TFip__", "26");
                        doc.ReplaceText("TFss__", "50");
                        doc.ReplaceText("TFdr8", "X");
                    }
                    else if (item.item.Contains("28 P.F."))
                    {
                        doc.ReplaceText("TFip__", "28");
                        doc.ReplaceText("TFss__", "49");
                        doc.ReplaceText("TFsq7", "X");
                    }
                    else if (item.item.Contains("32 P.F."))
                    {
                        doc.ReplaceText("TFip__", "32");
                        doc.ReplaceText("TFss__", "64");
                        doc.ReplaceText("TFsq8", "X");
                    }
                    else if (item.item.StartsWith("Raise Spa"))
                    {
                        string amt = (item.quantity * 2).ToString();
                        doc.ReplaceText(underscored("TFsee", amt.Length), amt);
                        doc.ReplaceText("TFsey", "X");
                        doc.ReplaceText("TFsen", "_");
                    }
                    else if (item.item.StartsWith("2nd"))
                    {
                        spillways = 2;
                    }
                    else if (item.item.Contains("OVER"))
                    {
                        spilllength = 2 + item.quantity;
                    }
                    else if (item.item.Contains("SEAMED"))
                    {
                        doc.ReplaceText("SWys", "X");
                    }
                    else if (item.item.Contains("Glass"))
                    {
                        doc.ReplaceText("TFgb", "X");
                        doc.ReplaceText("TFgy", "X");
                        doc.ReplaceText("TFgn", "_");
                    }
                    else if (item.item.StartsWith("Extra Jets"))
                    {
                        spajets += item.quantity;
                    }

                    doc.ReplaceText("SWyg", "X");
                    doc.ReplaceText("SWyy", "X");
                    doc.ReplaceText("SWyn", "_");
                    doc.ReplaceText("TFsy", "X");
                    doc.ReplaceText("TFsn", "_");
                    doc.ReplaceText("TFJf", "X");
                    doc.ReplaceText("TFJy", "X");
                    doc.ReplaceText("TFJn", "_");
                    doc.ReplaceText("TFAb", "X");
                    doc.ReplaceText("TFA1", "X");
                    doc.ReplaceText("TFAy", "X");
                    doc.ReplaceText("TFAn", "_");
                    doc.ReplaceText("TFLq", "1");
                    doc.ReplaceText("TFLy", "X");
                    doc.ReplaceText("TFLn", "_");
                    if (spillways == 0)
                    {
                        spillways = 1;
                    }
                    if (spilllength == 0)
                    {
                        spilllength = 2;
                    }
                }

                if (item.item.Contains("Slab Only"))
                {
                    doc.ReplaceText("cpef", "X");
                }
                else if (item.item.Contains("Colored Eyeball") || item.item.Contains("Additional Return"))
                {
                    eyes += item.quantity;
                }
                else if (item.item.Contains("Auto Fill"))
                {
                    doc.ReplaceText("afulcn", "_");
                    doc.ReplaceText("afulcy", "X");
                }
                else if (item.item.Contains("Auto Drain"))
                {
                    doc.ReplaceText("adlrfn", "_");
                    doc.ReplaceText("adlrfy", "X");
                }
                else if (item.item.Contains("2-Speed Time"))
                {
                    saltSystemTimer = 0;
                }
                else if (item.item.Contains("To Aqua-Rite"))
                {
                    saltSystemTimer = 1;
                }
                else if (item.item.Contains("To Pro Plus"))
                {
                    saltSystemTimer = 2;
                }
                else if (item.item.Contains("To Omni Logic"))
                {
                    saltSystemTimer = 3;
                }
                else if (item.item.Contains("Actuator Valves"))
                {
                    actuators++;
                }
                else if (item.item.Equals("Elevated Equipment Rack"))
                {
                    doc.ReplaceText("EqRar", "_");
                    doc.ReplaceText("EqRad", "__");
                    doc.ReplaceText("EqRae", "X");
                    doc.ReplaceText("EqRay", "X");
                    doc.ReplaceText("EqRan", "_");
                }
                if (item.item.StartsWith("Pre-Wire"))
                {
                    if (item.item.Contains("(No "))
                    {
                        doc.ReplaceText("fhpe", "X");
                        doc.ReplaceText("fhps", "_");
                    }
                    else
                    {
                        doc.ReplaceText("fhpe", "_");
                        doc.ReplaceText("fhps", "X");
                    }
                    doc.ReplaceText("fhpy", "X");
                    doc.ReplaceText("fhpn", "_");
                }

            }
            if (depth1.Length == 0)
                depth1 = "3'";
            if (depth3.Length == 0)
                depth3 = "5'";
            if (solarPanels > 0)
                doc.ReplaceText("htrsp", solarPanels.ToString());
            else
                doc.ReplaceText("htrsp", "_");

            if (saltSystemTimer == 0)
                doc.ReplaceText("sltsys", "X");
            else if (saltSystemTimer == 1)
                doc.ReplaceText("sltsya", "X");
            else if (saltSystemTimer == 2)
                doc.ReplaceText("sltsyp", "X");
            else if (saltSystemTimer == 3)
                doc.ReplaceText("sltsym", "X");
            if (actuators > 0)
                doc.ReplaceText("AuCoQ", actuators + "");

            if (remoteLength > 0)
            {
                doc.ReplaceText("EqRar", "X");
                doc.ReplaceText("EqRad", remoteLength.ToString());
                doc.ReplaceText("EqRae", "_");
                doc.ReplaceText("EqRay", "X");
                doc.ReplaceText("EqRan", "_");
            }

            if (spillways > 0)
                doc.ReplaceText("SWyq", spillways.ToString());
            else
                doc.ReplaceText("SWyq", "_");
            if (spilllength > 0)
                doc.ReplaceText("SWyl", spilllength.ToString());
            else
                doc.ReplaceText("SWyl", "_");


            if (spajets > 0)
                doc.ReplaceText("TFJs", spajets.ToString());
            else
                doc.ReplaceText("TFJs", "");

            doc.ReplaceText("TFLq", "_");
            doc.ReplaceText("TFLw", "_");
            doc.ReplaceText("TFLc", "_");
            doc.ReplaceText("TFLy", "_");
            doc.ReplaceText("TFLn", "X");
            doc.ReplaceText("TFAb", "_");
            doc.ReplaceText("TFA1", "_");
            doc.ReplaceText("TFAy", "_");
            doc.ReplaceText("TFAn", "X");
            doc.ReplaceText("TFJf", "_");
            doc.ReplaceText("TFJy", "_");
            doc.ReplaceText("TFJn", "X");
            doc.ReplaceText("TFmy", "_");
            doc.ReplaceText("TFmn", "X");
            doc.ReplaceText("TFmd", "_");
            doc.ReplaceText("TFmr", "_");
            doc.ReplaceText("TFgb", "_");
            doc.ReplaceText("TFgy", "X");
            doc.ReplaceText("TFgn", "_");
            doc.ReplaceText("SWys", "_");
            doc.ReplaceText("SWyg", "_");
            doc.ReplaceText("SWyy", "_");
            doc.ReplaceText("SWyn", "_");
            doc.ReplaceText("TFsee", "");
            doc.ReplaceText("TFsey", "_");
            doc.ReplaceText("TFsen", "X");
            doc.ReplaceText("TFsq6", "_");
            doc.ReplaceText("TFsq7", "_");
            doc.ReplaceText("TFsq8", "_");
            doc.ReplaceText("TFdr6", "_");
            doc.ReplaceText("TFdr7", "_");
            doc.ReplaceText("TFdr8", "_");
            doc.ReplaceText("TFip", "");
            doc.ReplaceText(SOP != null && SOP.Text.Length > 0 ? underscored("TFop", SOP.Text.Length) : "TFop", SOP != null && SOP.Text.Length > 0 ? SOP.Text : "");
            doc.ReplaceText("TFss", "");
            doc.ReplaceText("TFsy", "_");
            doc.ReplaceText("TFsn", "X");
            doc.ReplaceText("WFlwb", "_");
            doc.ReplaceText("WFlwq", "_");
            doc.ReplaceText("WFfws", "_");
            doc.ReplaceText("WFfwq", "_");
            doc.ReplaceText("WFws", "_");
            doc.ReplaceText("WFwq", "_");
            doc.ReplaceText("WFfs", "_");
            doc.ReplaceText("WFfq", "_");
            doc.ReplaceText("WFas", "_");
            doc.ReplaceText("WFad", "_");
            doc.ReplaceText("WFaq", "_");
            doc.ReplaceText("WFrs", "_");
            doc.ReplaceText("WFrh", "_");
            doc.ReplaceText("WFrq", "_");
            doc.ReplaceText("WFlas", "_");
            doc.ReplaceText("WFlaq", "_");
            doc.ReplaceText("WFsas", "_");
            doc.ReplaceText("WFsaz", "_");
            doc.ReplaceText("WFsaq", "_");
            doc.ReplaceText("WFlss", "_");
            doc.ReplaceText("WFlsz", "_");
            doc.ReplaceText("WFlsq", "_");
            doc.ReplaceText("WFss", "_");
            doc.ReplaceText("WFsz", "_");
            doc.ReplaceText("WFsq", "_");
            doc.ReplaceText("WFlbb", "_");
            doc.ReplaceText("WFlbq", "_");
            doc.ReplaceText("WFbb", "_");
            doc.ReplaceText("WFbq", "_");
            doc.ReplaceText("WFdjx", "_");
            doc.ReplaceText("WFdjq", "_");
            doc.ReplaceText("WFOFy", "_");
            doc.ReplaceText("WFOFn", "X");
            doc.ReplaceText("stprt", "_");
            doc.ReplaceText("stprp", "_");
            doc.ReplaceText("stpra", "_");
            doc.ReplaceText("inrtil", "_");
            doc.ReplaceText("inrtib", "_");
            doc.ReplaceText("inrtic", "_");
            doc.ReplaceText("inrtiy", "_");
            doc.ReplaceText("inrtin", "X");
            doc.ReplaceText("bndwls", "X");
            doc.ReplaceText("bndwlu", "_");
            doc.ReplaceText("bndwln", "_");
            doc.ReplaceText("blkwls", "_");
            doc.ReplaceText("blkwlb", "_");
            doc.ReplaceText("blkwlp", "_");
            doc.ReplaceText("blkwlt", "_");
            doc.ReplaceText("blkwly", "_");
            doc.ReplaceText("blkwln", "X");
            doc.ReplaceText("rqbrw", "_");
            doc.ReplaceText("rqbrq", "");
            doc.ReplaceText("rqbrp", "_");
            doc.ReplaceText("rqbrt", "");
            doc.ReplaceText("rqbrb", "_");
            doc.ReplaceText("rqbrl", "");
            doc.ReplaceText("rqbrs", "_");
            doc.ReplaceText("rqbry", "");
            doc.ReplaceText("fncnqv", "");
            doc.ReplaceText("fncnqw", "");
            doc.ReplaceText("fncnqa", "");
            doc.ReplaceText("fncnqc", "");
            doc.ReplaceText("fncnl", "");
            doc.ReplaceText("fncncv", "");
            doc.ReplaceText("fncncw", "");
            doc.ReplaceText("fncnca", "");
            doc.ReplaceText("fncncc", "");
            doc.ReplaceText("fncntv", "_");
            doc.ReplaceText("fncntw", "_");
            doc.ReplaceText("fncnta", "_");
            doc.ReplaceText("fncntc", "_");
            doc.ReplaceText("fncnhv", "_");
            doc.ReplaceText("fncnhw", "_");
            doc.ReplaceText("fncnha", "_");
            doc.ReplaceText("fncnhc", "_");
            doc.ReplaceText("fncngv", "");
            doc.ReplaceText("fncngw", "");
            doc.ReplaceText("fncnga", "");
            doc.ReplaceText("fncngc", "");
            doc.ReplaceText("fncnsv", "");
            doc.ReplaceText("fncnsw", "");
            doc.ReplaceText("fncnsa", "");
            doc.ReplaceText("fncnsc", "");
            doc.ReplaceText("fncnc", "");
            doc.ReplaceText("fncny", "_");
            doc.ReplaceText("fncnn", "X");
            doc.ReplaceText("eltrss", "_");
            doc.ReplaceText("eltrsf", "_");
            doc.ReplaceText("eltrsb", "_");
            doc.ReplaceText("eltrsy", "_");
            doc.ReplaceText("eltrsn", "X");
            doc.ReplaceText("scencm", "_");
            doc.ReplaceText("scencd", "_");
            doc.ReplaceText("scencq", "");
            doc.ReplaceText("scencp", "_");
            doc.ReplaceText("scency", "_");
            doc.ReplaceText("scencn", "X");
            doc.ReplaceText("scenc8", "_");
            doc.ReplaceText("scenc2", "_");
            doc.ReplaceText("scencs", "_");
            doc.ReplaceText("scenco", "X");
            doc.ReplaceText("scenck", "_");
            doc.ReplaceText("scencz", "");
            doc.ReplaceText("scencg", "_");
            doc.ReplaceText("scenci", "");
            doc.ReplaceText("epwh6", "_");
            doc.ReplaceText("epwh2", "_");
            doc.ReplaceText("epwh8", "_");
            doc.ReplaceText("epwh4", "_");
            doc.ReplaceText("epwhy", "_");
            doc.ReplaceText("epwhn", "X");
            doc.ReplaceText("epwhh", "_");
            doc.ReplaceText("epwhq", "_");
            doc.ReplaceText("plntf", "_");
            doc.ReplaceText("plntp", "_");
            doc.ReplaceText("plntq", "");
            doc.ReplaceText("plnty", "_");
            doc.ReplaceText("plntn", "X");
            doc.ReplaceText("strpo", "");
            doc.ReplaceText("strpb", "_");
            doc.ReplaceText("strpa", "_");
            doc.ReplaceText("strpp", "_");
            doc.ReplaceText("strpt", "_");
            doc.ReplaceText("strpy", "_");
            doc.ReplaceText("strpn", "X");
            doc.ReplaceText("ssdd1", "X");
            doc.ReplaceText("ssdd2", "_");
            doc.ReplaceText("ssdd3", "_");
            doc.ReplaceText("ssdd4", "_");
            doc.ReplaceText("ssddc", "_");
            doc.ReplaceText("clbnp", "_");
            doc.ReplaceText("clbns", "_");
            doc.ReplaceText("clbny", "_");
            doc.ReplaceText("clbnn", "X");
            doc.ReplaceText("edki", "_");
            doc.ReplaceText("edke", "_");
            doc.ReplaceText("edkt", "_");
            doc.ReplaceText("edkc", "_");
            doc.ReplaceText("edkl", "");
            doc.ReplaceText("edky", "_");
            doc.ReplaceText("edkn", "X");
            doc.ReplaceText("edkh", "_");
            doc.ReplaceText("edkk", "_");
            doc.ReplaceText("edkv", "_");
            doc.ReplaceText("edks", "_");
            doc.ReplaceText("edky", "_");
            doc.ReplaceText("nwdko", "X");
            doc.ReplaceText("nwdkc", "_");
            doc.ReplaceText("nwdkv", "_");
            doc.ReplaceText("nwdkp", "_");
            doc.ReplaceText("nwdkt", "_");
            doc.ReplaceText("nwdkb", "_");
            doc.ReplaceText("cbcin", "X");
            doc.ReplaceText("cbciy", "_");
            doc.ReplaceText("CpngC", "X");
            doc.ReplaceText("CpngB", "_");
            doc.ReplaceText("CpngT", "_");
            doc.ReplaceText("CpngS", "");
            doc.ReplaceText("CpngA", "_");
            doc.ReplaceText("CpngI", "");
            doc.ReplaceText("CpngN", "_");
            doc.ReplaceText("ftrw8", "X");
            doc.ReplaceText("ftrw12", "_");
            doc.ReplaceText("ftrw2", "_");
            doc.ReplaceText("ftrw3", "_");
            doc.ReplaceText("ftrwe", "_");
            doc.ReplaceText("ftrwh", "");

            doc.ReplaceText("EqRar", "_");
            doc.ReplaceText("EqRad", "__");
            doc.ReplaceText("EqRae", "_");
            doc.ReplaceText("EqRay", "_");
            doc.ReplaceText("EqRan", "X");
            doc.ReplaceText("fhpe", "_");
            doc.ReplaceText("fhps", "_");
            doc.ReplaceText("fhpy", "_");
            doc.ReplaceText("fhpn", "X");
            doc.ReplaceText("schasd", "_");
            doc.ReplaceText("schasu", "_");
            doc.ReplaceText("schaso", "_");
            doc.ReplaceText("schasb", "_");
            doc.ReplaceText("schasy", "_");
            doc.ReplaceText("schasn", "X");
            doc.ReplaceText("wcopc", "_");
            doc.ReplaceText("wcopa", "_");
            doc.ReplaceText("wcopt", "_");
            doc.ReplaceText("wcopp", "_");
            doc.ReplaceText("wcopo", "_");
            doc.ReplaceText("AuCoL", "_");
            doc.ReplaceText("AuCoW", "_");
            doc.ReplaceText("AuCoC", "_");
            doc.ReplaceText("AuCoQ", "_");
            doc.ReplaceText("AuCoY", "_");
            doc.ReplaceText("AuCoN", "X");
            doc.ReplaceText("sltsys", "_");
            doc.ReplaceText("sltsya", "_");
            doc.ReplaceText("sltsyp", "_");
            doc.ReplaceText("sltsym", "_");
            doc.ReplaceText("sltsyo", "_");
            doc.ReplaceText("AChin", "X");
            doc.ReplaceText("AChiy", "_");
            doc.ReplaceText("AChis", "_");
            doc.ReplaceText("AChil", "_");
            doc.ReplaceText("sturn", "X");
            doc.ReplaceText("stury", "_");
            doc.ReplaceText("sturq", "");
            doc.ReplaceText("sturs", "");
            doc.ReplaceText("adlrfn", "X");
            doc.ReplaceText("adlrfy", "_");
            doc.ReplaceText("afulcn", "X");
            doc.ReplaceText("afulcy", "_");
            doc.ReplaceText("rleiq", eyes + "");
            doc.ReplaceText("rleiw", "X");
            doc.ReplaceText("rleib", "_");
            doc.ReplaceText("rleig", "_");

            doc.ReplaceText("apcp", "_");
            doc.ReplaceText("apcm", "");
            doc.ReplaceText("apcy", "_");
            doc.ReplaceText("apcn", "X");

            doc.ReplaceText("swbq", "1");
            doc.ReplaceText("htrsm", "");
            doc.ReplaceText("htrss", "_");
            doc.ReplaceText("htrst", "_");
            doc.ReplaceText("htrgl", "_");
            doc.ReplaceText("htrgn", "_");
            doc.ReplaceText("htrgg", "_");
            doc.ReplaceText("htrgm", "");
            doc.ReplaceText("htrgb", "");
            doc.ReplaceText("htrem", "");
            doc.ReplaceText("htree", "_");
            doc.ReplaceText("htreb", "");
            doc.ReplaceText("htrel", "");

            doc.ReplaceText("pmhls" + pumpSpd, "X");
            for (int i = 1; i <= 3; i++)
            {
                if (pumpSpd != i)
                {
                    doc.ReplaceText("pmhls" + i, "_");
                }
            }
            doc.ReplaceText("pmhlh" + pumpHP, "X");
            for (int i = 1; i <= 9; i++)
            {
                if (pumpHP != i)
                {
                    doc.ReplaceText("pmhlh" + i, "_");
                }
            }
            if (ledq > 0)
            {
                doc.ReplaceText("ledq", ledq + "");
                doc.ReplaceText("ledw", ledw);
                doc.ReplaceText("ledc", ledc);
                doc.ReplaceText("ledy", "X");
                doc.ReplaceText("ledn", "_");
            }
            else
            {
                doc.ReplaceText("ledq", "");
                doc.ReplaceText("ledw", "");
                doc.ReplaceText("ledc", "");
                doc.ReplaceText("ledy", "_");
                doc.ReplaceText("ledn", "X");
            }
            doc.ReplaceText("htry", "_");
            doc.ReplaceText("htrn", "X");

            doc.ReplaceText("filtq", filterq + "");
            doc.ReplaceText("filtd", fDE);
            doc.ReplaceText("filtc", fCartridge);
            doc.ReplaceText("filts", fSand);
            doc.ReplaceText("filt1", fS1);
            doc.ReplaceText("filt2", fS2);

            doc.ReplaceText("addpumpy", "_");
            doc.ReplaceText("addpumpn", "X");
            doc.ReplaceText("addpumpm", "");
            doc.ReplaceText("addpumph", "");
            doc.ReplaceText("addpumps", "_");
            doc.ReplaceText("addpump2", "_");
            doc.ReplaceText("addpumpv", "_");

            doc.ReplaceText("swol", "");
            doc.ReplaceText("lspy", "_");
            doc.ReplaceText("lspn", "X");
            doc.ReplaceText("lspq", "");

            doc.ReplaceText(underscored("pmhlma", pumpMa.Length), pumpMa);
            doc.ReplaceText(underscored("pmhlmo", pumpMo.Length), pumpMo);


            doc.ReplaceText("petbi", 30 + "");
            if (rails > 0)
                doc.ReplaceText("hndrqp", rails.ToString());
            else
                doc.ReplaceText("hndrqp", "_");
            doc.ReplaceText("hndrp", "_");
            doc.ReplaceText("hndrd", "_");
            doc.ReplaceText("hndrc", "_");
            doc.ReplaceText("hndrf", "_");
            doc.ReplaceText("hndrn", "X");
            doc.ReplaceText("hndry", "_");

            doc.ReplaceText("cpef", "_");

            doc.ReplaceText(underscored("dep1", depth1.Length), depth1);
            doc.ReplaceText(underscored("dep2", depth2.Length), depth2);
            doc.ReplaceText(underscored("dep3", depth3.Length), depth3);

            doc.ReplaceText(underscored("sebq", benches.ToString().Length), benches.ToString());
            doc.ReplaceText(underscored("seb1f", benchL.ToString().Length), benchL.ToString());
            if (benches > 1)
            {
                doc.ReplaceText(underscored("seb2f", benchL.ToString().Length), benchL.ToString());
            }
            else
            {
                doc.ReplaceText("seb2f", "");
            }

            doc.ReplaceText(underscored("swoq", benches2.ToString().Length), benches2.ToString());
            doc.ReplaceText(underscored("swo1", benchL2.ToString().Length), benchL2.ToString());
            if (benches2 > 1)
            {
                doc.ReplaceText(underscored("swo2", benchL2.ToString().Length), benchL2.ToString());
            }
            else
            {
                doc.ReplaceText("swo2", "");
            }

            doc.ReplaceText("seby", "X");
            doc.ReplaceText("sebn", "_");

            doc.ReplaceText("swoy", "X");
            doc.ReplaceText("swon", "_");

            doc.ReplaceText("sstsy", "_");
            doc.ReplaceText("sstsn", "X");

            doc.ReplaceText("awfwp", "_");
            doc.ReplaceText("awfwt", "");
            doc.ReplaceText("awfn", "X");

            doc.ReplaceText("shrby", "_");
            doc.ReplaceText("shrbn", "X");
            doc.ReplaceText("shrbq", "");

            doc.ReplaceText("escrny", "_");
            doc.ReplaceText("escrnn", "X");
            doc.ReplaceText("escrnq", "");

            doc.ReplaceText("roofy", "_");
            doc.ReplaceText("roofn", "X");
            doc.ReplaceText("roofq", "X");

            doc.ReplaceText("concy", "_");
            doc.ReplaceText("concn", "X");
            doc.ReplaceText("concq", "");

            doc.ReplaceText("pavsy", "_");
            doc.ReplaceText("pavsn", "X");
            doc.ReplaceText("pavsq", "");

            doc.ReplaceText("wby", "_");
            doc.ReplaceText("wbn", "X");
            doc.ReplaceText("wbq", "");

            doc.ReplaceText("omdy", "_");
            doc.ReplaceText("omdn", "X");
            doc.ReplaceText("omdq", "");
            doc.ReplaceText("omdt", "");

            doc.ReplaceText("esr6", "_");
            doc.ReplaceText("esr12", "_");
            doc.ReplaceText("wwshrw", "_");
            doc.ReplaceText("wwshrlf", "");
            doc.ReplaceText("srss8", "_");
            doc.ReplaceText("srss12", "_");
            doc.ReplaceText("sescf__", "20");
            doc.ReplaceText("sescq_", "3");

            // screen enclosure
            if (categories.Contains("SCREEN ENCLOSURE (Single Story ONLY)"))
            {
                doc.ReplaceText("seppy", "X");
                doc.ReplaceText("seppn", "_");
            }
            else
            {
                doc.ReplaceText("seppy", "_");
                doc.ReplaceText("seppn", "X");
            }


            if (!System.IO.Directory.Exists(HttpRuntime.AppDomainAppPath + "UserData"))
            {
                System.IO.Directory.CreateDirectory(HttpRuntime.AppDomainAppPath + "UserData");
            }
            if (!System.IO.Directory.Exists(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\"))
            {
                System.IO.Directory.CreateDirectory(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\");
            }
            AddToHistory("Contract Generated.");
            doc.SaveAs(HttpRuntime.AppDomainAppPath + "UserData\\" + ID + "\\Contract.docx");
            Save();

            Response.Redirect("/UserData/" + ID + "/Contract.docx");
        }

        protected void GenerateBid(object sender, EventArgs e)
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

            string fileName = HttpRuntime.AppDomainAppPath + "Documents\\Genesis Bid.docx";

            var doc = DocX.Load(fileName);
            // adjust lines
            //doc.Lists[3].Items[0].Text.Replace("Palm Coast", );

            /*
            Paragraph para = doc.Lists[0].Items[1].InsertParagraphAfterSelf(doc.Lists[0].Items[1]);  // Adds a new bullet point below
            para.ReplaceText(para.Text, "Testing");  // Replaces the text of the bullet point

            doc.Lists[0].Items.Add(para);*/

            int projID = -1;
            string cmdString = "Select [CurrentProject] From [dbo].[Customers] Where CustomerID=@ID";
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
            string itemstring = "";
            cmdString = "Select * From [dbo].[Projects] Where CustomerID=@ID AND ProjectID=@pID";
            connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand(cmdString, conn))
                {
                    comm.Parameters.AddWithValue("@ID", ID);
                    comm.Parameters.AddWithValue("@pID", projID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = comm.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                itemstring = String.Format("{0}", reader["Items"]);
                            }
                        }
                    }
                    catch (SqlException err)
                    {

                    }
                }
            }

            List<Item> items = new List<Item>();
            foreach (string str in itemstring.Split('~'))
            {
                string[] sArr = str.Split('`');
                if (sArr.Length < 5)
                {
                    break;
                }
                Item item = new Item();
                item.optional = sArr[0] == "0" ? false : true;
                item.status = sArr[1];
                item.quantity = Convert.ToInt32(sArr[2]);
                item.description = sArr[4];
                try
                {
                    item.price = (float)Convert.ToDouble(sArr[5]);
                    item.overage = (float)Convert.ToDouble(sArr[6]);
                }
                catch
                {
                    item.price = 999999f;
                    item.overage = 999999f;
                }
                item.lockedTime = DateTime.Parse(sArr[7]);

                cmdString = "Select * From PriceBook where ItemID=@ID";
                connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand comm = new SqlCommand(cmdString, conn))
                    {
                        comm.Parameters.AddWithValue("@ID", Convert.ToInt32(sArr[3]));
                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = comm.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    item.item = String.Format("{0}", reader["Item"]);
                                    item.unit = String.Format("{0}", reader["Unit"]);
                                    string pric = String.Format("{0}", reader["CustomerPrice"]);
                                    item.currPrice = (float)Convert.ToDouble(pric);
                                    item.category = String.Format("{0}", reader["Category"]);
                                    item.subcategory = String.Format("{0}", reader["Subcategory"]);
                                    item.subsubcategory = String.Format("{0}", reader["Subsubcategory"]);
                                }
                            }
                        }
                        catch (SqlException err)
                        {

                        }
                    }
                }

                items.Add(item);
            }
            foreach (Item item in items)
            {
                if (item.description != null && item.description.Length > 0)
                {
                    item.description = item.description.Replace("[x]", item.quantity + "");
                    Paragraph para = doc.Lists[0].Items[52].InsertParagraphAfterSelf(doc.Lists[0].Items[52]);
                    para.ReplaceText(para.Text, item.description);
                }
            }
            AddToHistory("Bid Proposal Finalized.");
            doc.SaveAs(HttpRuntime.AppDomainAppPath + "Documents\\Genesis Bid1.docx");
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

            //for (int i = 0; i < GridView3.Rows.Count; i++)
            //{
            //    CheckBox box = (CheckBox)GridView3.Rows[i].Cells[0].Controls[1];
            //    if (box.Checked)
            //    {
            //        string projID = "";
            //        string cmdString = "SELECT [ProjectID] from [Projects] where [CustomerID] = @ID ORDER BY [ProjectID] ASC";
            //        string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            //        using (SqlConnection conn = new SqlConnection(connString))
            //        {
            //            using (SqlCommand comm = new SqlCommand(cmdString, conn))
            //            {
            //                comm.Parameters.AddWithValue("@ID", ID);
            //                try
            //                {
            //                    conn.Open();
            //                    using (SqlDataReader reader = comm.ExecuteReader())
            //                    {
            //                        int j = 0;
            //                        while (reader.Read())
            //                        {
            //                            if (i == j)
            //                            {
            //                                projID = String.Format("{0}", reader["ProjectID"]);
            //                            }
            //                            j++;
            //                        }
            //                    }
            //                }
            //                catch (SqlException err)
            //                {

            //                }
            //            }
            //        }
            //        cmdString = "insert into [Projects] (Items, CustomerID, Length, Width, ProjectName, ProjectDescription, ProjectType) select Items, CustomerID, Length, Width, ProjectName, ProjectDescription, ProjectType from [Projects] where ProjectID=@pID";
            //        connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            //        using (SqlConnection conn = new SqlConnection(connString))
            //        {
            //            using (SqlCommand comm = new SqlCommand(cmdString, conn))
            //            {
            //                comm.Parameters.AddWithValue("@pID", projID);
            //                try
            //                {
            //                    conn.Open();
            //                    using (SqlDataReader reader = comm.ExecuteReader())
            //                    {
            //                    }
            //                }
            //                catch (SqlException err)
            //                {

            //                }
            //            }
            //        }


            //        cmdString = "select MAX(ProjectID) as maxID from [dbo].[Projects] where CustomerID = @ID";
            //        connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            //        using (SqlConnection conn = new SqlConnection(connString))
            //        {
            //            using (SqlCommand comm = new SqlCommand(cmdString, conn))
            //            {
            //                comm.Parameters.AddWithValue("@ID", ID);
            //                try
            //                {
            //                    conn.Open();
            //                    using (SqlDataReader reader = comm.ExecuteReader())
            //                    {
            //                        while (reader.Read())
            //                        {
            //                            string pr = String.Format("{0}", reader["maxID"]);
            //                            if (pr.Length < 1)
            //                            {
            //                                pr = "-1";
            //                            }
            //                            projID = pr;
            //                        }
            //                    }
            //                }
            //                catch (SqlException err)
            //                {

            //                }
            //            }
            //        }

            //        cmdString = "UPDATE [dbo].[Customers] SET [CurrentProject] = @pID where CustomerID = @ID";
            //        connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            //        using (SqlConnection conn = new SqlConnection(connString))
            //        {
            //            using (SqlCommand comm = new SqlCommand())
            //            {
            //                comm.Connection = conn;
            //                comm.CommandText = cmdString;
            //                comm.Parameters.AddWithValue("@pID", projID);
            //                comm.Parameters.AddWithValue("@ID", ID);

            //                try
            //                {
            //                    conn.Open();
            //                    comm.ExecuteNonQuery();
            //                }
            //                catch (SqlException f)
            //                {
            //                    System.Diagnostics.Debug.WriteLine(f.Message);
            //                }
            //            }
            //        }
            //        Response.Redirect("/CPriceBook?" + ID + "&Shopping");
            //        break;
            //    }
            //}
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

            //for (int i = 0; i < GridView3.Rows.Count; i++)
            //{
            //    CheckBox box = (CheckBox)GridView3.Rows[i].Cells[0].Controls[1];
            //    if (box.Checked)
            //    {
            //        string projID = "";
            //        string cmdString = "SELECT [ProjectID] from [Projects] where [CustomerID] = @ID ORDER BY [ProjectID] ASC";
            //        string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            //        using (SqlConnection conn = new SqlConnection(connString))
            //        {
            //            using (SqlCommand comm = new SqlCommand(cmdString, conn))
            //            {
            //                comm.Parameters.AddWithValue("@ID", ID);
            //                try
            //                {
            //                    conn.Open();
            //                    using (SqlDataReader reader = comm.ExecuteReader())
            //                    {
            //                        int j = 0;
            //                        while (reader.Read())
            //                        {
            //                            if (i == j)
            //                            {
            //                                projID = String.Format("{0}", reader["ProjectID"]);
            //                            }
            //                            j++;
            //                        }
            //                    }
            //                }
            //                catch (SqlException err)
            //                {

            //                }
            //            }
            //        }

            //        cmdString = "insert into [MasterBids] (Items, CustomerID, Length, Width, ProjectName, ProjectDescription, ProjectType) select Items, CustomerID, Length, Width, ProjectName, ProjectDescription, ProjectType from [Projects] where ProjectID=@pID";
            //        connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
            //        using (SqlConnection conn = new SqlConnection(connString))
            //        {
            //            using (SqlCommand comm = new SqlCommand(cmdString, conn))
            //            {
            //                comm.Parameters.AddWithValue("@pID", projID);
            //                try
            //                {
            //                    conn.Open();
            //                    using (SqlDataReader reader = comm.ExecuteReader())
            //                    {
            //                    }
            //                }
            //                catch (SqlException err)
            //                {

            //                }
            //            }
            //        }
            //        break;
            //    }
            //}
        }


        #endregion


        #region Items Grid Events

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

        protected void GridView_Items_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void GridView_Items_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("testing");
        }


        #endregion


        #region Page Methods

        private string underscored(string str, int num)
        {
            for (int i = 0; i < num; i++)
            {
                str += "_";
            }
            return str;
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


        #endregion

    }
}
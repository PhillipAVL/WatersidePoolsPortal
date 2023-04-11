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
using Xceed.Words.NET;

namespace WatersidePortal
{
    public partial class FinalizedShopping : System.Web.UI.Page
    {
        private class Project
        {
            public string sItems;
            public int projectID;
            public int lengthF;
            public int lengthI;
            public int widthF;
            public int widthI;
            public string projectName;
            public string projectDescription;
            public Item items;
        }

        private class Item
        {
            public bool optional;
            public string item;
            public string unit;
            public string status;
            public int quantity;
            public int itemID;
            public string description;
            public float price;
            public float overage;
            public DateTime lockedTime;
            public float currPrice;
            public string category;
            public string subcategory;
            public string subsubcategory;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Url.AbsoluteUri.Split('?').Length < 2)
            {
                return;
            }
            string ID = HttpContext.Current.Request.Url.AbsoluteUri.Split('?')[1];

            if (!Page.IsPostBack)
            {
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
                cmdString = "SELECT [Items], [ProjectID], [ProjectType], [ProjectName], [ProjectDescription] from [Projects] where [CustomerID] = @ID ORDER BY [ProjectID] ASC";
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
                                int i = 0;
                                while (reader.Read())
                                {
                                    string its = String.Format("{0}", reader["Items"]);
                                    if (its.Split('~').Length == 0 || its.Split('~')[0].Split('`').Length < 7)
                                    {
                                        i++;
                                        continue;
                                    }
                                    DateTime oldest = DateTime.Parse(its.Split('~')[0].Split('`')[7]);
                                    DateTime newest = DateTime.Parse(its.Split('~')[0].Split('`')[7]);
                                    foreach (string s in its.Split('~'))
                                    {
                                        if (s.Split('`').Length < 7)
                                        {
                                            continue;
                                        }
                                        DateTime curr = DateTime.Parse(s.Split('`')[7]);
                                        if (oldest.CompareTo(curr) < 0)
                                        {
                                            oldest = curr;
                                        }
                                        else if (newest.CompareTo(curr) > 0)
                                        {
                                            newest = curr;
                                        }
                                    }
                                    i++;
                                }
                            }
                        }
                        catch (SqlException err)
                        {

                        }
                    }
                }
                Project gProj = new Project();
                int basePrice = 54500;
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
                                    gProj.sItems = String.Format("{0}", reader["Items"]);
                                    gProj.projectName = String.Format("{0}", reader["ProjectName"]);
                                    gProj.projectDescription = String.Format("{0}", reader["ProjectDescription"]);
                                    gProj.projectID = Convert.ToInt32(String.Format("{0}", reader["ProjectID"]));
                                    Project_Name.Text = gProj.projectName + ":";
                                    string[] len = String.Format("{0}", reader["Length"]).Split('`');
                                    string[] wid = String.Format("{0}", reader["Width"]).Split('`');
                                    if (String.Format("{0}", reader["ProjectType"]) == "Genesis")
                                    {
                                        basePrice = 51000;
                                    }
                                    else if (String.Format("{0}", reader["ProjectType"]) == "EZ-Flow")
                                    {
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

                if (gProj == null || gProj.sItems == null)
                {

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
                                        projID = Convert.ToInt32(pr);
                                    }
                                }
                            }
                            catch (SqlException err)
                            {

                            }
                        }
                    }


                    gProj = new Project();
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
                                        gProj.sItems = String.Format("{0}", reader["Items"]);
                                        gProj.projectName = String.Format("{0}", reader["ProjectName"]);
                                        gProj.projectDescription = String.Format("{0}", reader["ProjectDescription"]);
                                        gProj.projectID = Convert.ToInt32(String.Format("{0}", reader["ProjectID"]));
                                        Project_Name.Text = gProj.projectName + ":";
                                        string[] len = String.Format("{0}", reader["Length"]).Split('`');
                                        string[] wid = String.Format("{0}", reader["Width"]).Split('`');
                                        if (String.Format("{0}", reader["ProjectType"]) == "Genesis")
                                        {
                                            basePrice = 51000;
                                        }
                                        else if (String.Format("{0}", reader["ProjectType"]) == "EZ-Flow")
                                        {
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
                }
                List<Item> items = new List<Item>();
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

                    cmdString = "Select [Item], [Unit], [Description], [CustomerPrice], [Category] From PriceBook where ItemID=@ID";
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
                                        item.category = String.Format("{0}", reader["Category"]);
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

                DataTable dt = GridView1.DataSource as DataTable;
                if (dt == null)
                {
                    dt = new DataTable();
                    dt.Columns.Add("Category");
                    dt.Columns.Add("Quantity");
                    dt.Columns.Add("Item Name");
                    dt.Columns.Add("Description");
                    dt.Columns.Add("Price");
                    dt.Columns.Add("Overage / Underage");
                    dt.Columns.Add("Unit");
                    dt.Columns.Add("Subtotal");
                }
                // If it's genesis or ez-flow
                DataRow dr2 = dt.NewRow();
                dr2["Category"] = "General";
                dr2["Quantity"] = "1";
                dr2["Item Name"] = basePrice == 54500 ? "EZ-Flow Pool" : "Genesis Pool";
                dr2["Description"] = "Base Pool Items";
                dr2["Price"] = "$" + basePrice;
                dr2["Overage / Underage"] = "-";
                dr2["Unit"] = "Only One";
                dr2["Subtotal"] = "$" + basePrice;
                dt.Rows.Add(dr2);
                foreach (Item item in items)
                {
                    DataRow dr = dt.NewRow();
                    dr["Category"] = item.category;
                    dr["Quantity"] = item.quantity;
                    dr["Item Name"] = item.item;
                    dr["Description"] = item.description;
                    dr["Price"] = "$" + item.price;
                    dr["Overage / Underage"] = item.overage;
                    dr["Unit"] = item.unit;
                    dr["Subtotal"] = "$" + (item.price * item.quantity + item.overage);
                    dt.Rows.Add(dr);
                }
                GridView1.DataSource = dt;
                GridView1.DataBind();

                /*if (GridView1.Rows.Count < items.Count)
                {
                    return;
                }*/
                float commission = 0;
                float ovr = 0;
                float sub = basePrice;
                float tot = basePrice;
                float lift = basePrice;
                int selectCount = 1;




                GridView1.Rows[0].Cells[0].Text = "General";
                GridView1.Rows[0].Cells[1].Text = "1";
                GridView1.Rows[0].Cells[2].Text = basePrice == 54500 ? "EZ-Flow Pool" : "Genesis Pool";
                GridView1.Rows[0].Cells[3].Text = "Base Pool Items";
                GridView1.Rows[0].Cells[4].Text = "$" + basePrice;
                GridView1.Rows[0].Cells[5].Text = "-";
                GridView1.Rows[0].Cells[6].Text = "Only One";
                GridView1.Rows[0].Cells[7].Text = "$" + basePrice;





                for (int i = 0; i < items.Count; i++)
                {
                    float ov = items[i].overage / 2f;
                    if (items[i].overage < 0)
                    {
                        ov = items[i].overage;
                    }
                    GridView1.Rows[selectCount].Cells[0].Text = items[i].category;
                    GridView1.Rows[selectCount].Cells[1].Text = items[i].quantity + "";
                    GridView1.Rows[selectCount].Cells[2].Text = items[i].item;
                    GridView1.Rows[selectCount].Cells[3].Text = items[i].description;
                    GridView1.Rows[selectCount].Cells[4].Text = "$" + items[i].price;
                    GridView1.Rows[selectCount].Cells[5].Text = items[i].overage + "";
                    GridView1.Rows[selectCount].Cells[6].Text = items[i].unit + "";
                    GridView1.Rows[selectCount].Cells[7].Text = "$" + (items[i].price * items[i].quantity + items[i].overage);
                    if (!items[i].optional)
                    {
                        commission += ov + items[i].price * 0.05f;
                    }
                    ovr += items[i].overage;
                    sub += items[i].price * items[i].quantity;
                    tot += items[i].price * items[i].quantity + items[i].overage;
                    lift += items[i].currPrice * items[i].quantity + items[i].overage;
                    selectCount++;
                }
                OverageText.Text = "Overage / Underage: $" + String.Format("{0:0.00}", ovr);
                CommissionText.Text = "Commission: $" + String.Format("{0:0.00}", commission);
                if (tot < basePrice)
                {
                    tot = basePrice;
                }
                TotalText.Text = "Total: $" + String.Format("{0:0.00}", tot + commission);
                try
                {
                    GridView1.Sort("Category", SortDirection.Ascending);
                }
                catch (Exception err) { }
            }
        }

        protected void GridView_Items_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }
        protected void GridView_Items_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("testing");
        }

        protected void GenerateBid(object sender, EventArgs e)
        {
        }

        protected void GenerateContract(object sender, EventArgs e)
        {
        }

        protected void Save(object sender, EventArgs e)
        {
        }
        protected void Deleted(object sender, GridViewDeleteEventArgs e)
        {
        }

        protected void Selected(object sender, EventArgs e)
        {
        }
    }
}
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
    public partial class PriceBook : System.Web.UI.Page
    {
        public static bool doneOnce = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView_Items.Sort("Category", SortDirection.Ascending);
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
            Response.Redirect("/SubPriceBook.aspx?" + GridView_Items.SelectedRow.Cells[1].Text.Replace("#", "numpound").Replace("&", "andamp"));
        }
        protected void UploadDesc() // DO NOT REUSE, this is code to upload everything from a csv file to the pricebook
        {
            if (doneOnce)
                return;
            using (TextFieldParser parser = new TextFieldParser(@"C:\Users\Kevin\Desktop\RTS\Waterside\downloads\All Items.csv"))
            {
                int counter = 0;
                parser.TextFieldType = FieldType.Delimited;
                parser.SetDelimiters(",");
                while (!parser.EndOfData)
                {
                    //Processing row
                    string[] fields = parser.ReadFields();
                    if (!doneOnce)
                    {
                        doneOnce = true;
                        continue;
                    }

                    string connString = SqlDataSource1.ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        string cmdString = "UPDATE [PriceBook] SET Description=@Desc, Contract=@Cont WHERE UPPER(Category) like UPPER(@cat) AND UPPER(Subcategory) like UPPER(@sub) AND UPPER(Subsubcategory) like UPPER(@subsub) AND (UPPER(Item) like UPPER(@name) OR UPPER(Item) like UPPER(@name2))";
                        using (SqlCommand comm = new SqlCommand(cmdString, conn))
                        {
                            comm.Parameters.AddWithValue("@cat", fields[0] + "%");
                            comm.Parameters.AddWithValue("@sub", fields[1] + "%");
                            comm.Parameters.AddWithValue("@subsub", fields[2] + "%");
                            comm.Parameters.AddWithValue("@name", fields[3].Substring(0, fields[3].Length / 2) + "%");
                            comm.Parameters.AddWithValue("@name2", "%" + fields[3].Substring(fields[3].Length / 2 - 1, fields[3].Length / 2));
                            comm.Parameters.AddWithValue("@desc", fields[4]);
                            comm.Parameters.AddWithValue("@cont", fields[5]);
                            try
                            {
                                conn.Open();
                                comm.ExecuteNonQuery();
                                counter++;
                                System.Diagnostics.Debug.WriteLine(fields[3]);
                            }
                            catch (SqlException ex)
                            {
                                System.Diagnostics.Debug.WriteLine(ex.Message);
                            }
                        }
                    }
                }
                System.Diagnostics.Debug.WriteLine("Changes: " + counter);
            }
        }

        protected void Upload() // DO NOT REUSE, this is code to upload everything from a csv file to the pricebook
        {
            if (doneOnce)
                return;
            using (TextFieldParser parser = new TextFieldParser(@"C:\Users\Kevin\Desktop\RTS\Waterside\downloads\Combo price book DATA.csv"))
            {
                parser.TextFieldType = FieldType.Delimited;
                parser.SetDelimiters(",");
                while (!parser.EndOfData)
                {
                    //Processing row
                    string[] fields = parser.ReadFields();
                    if (!doneOnce || fields[3] == null || fields[3].Length == 0)
                    {
                        doneOnce = true;
                        continue;
                    }

                    string connString = SqlDataSource1.ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        string cmdString = "INSERT INTO [PriceBook] ([Category], [Subcategory], [Subsubcategory], [Item], [CustomerPrice], [Unit], [Additional]) VALUES (@cat, @sub, @subsub, @item, @price, @unit, @add)";
                        using (SqlCommand comm = new SqlCommand(cmdString, conn))
                        {
                            comm.Parameters.AddWithValue("@cat", fields[0]);
                            comm.Parameters.AddWithValue("@sub", fields[1]);
                            comm.Parameters.AddWithValue("@subsub", fields[2]);
                            comm.Parameters.AddWithValue("@item", fields[3]);
                            comm.Parameters.AddWithValue("@price", fields[4]);
                            comm.Parameters.AddWithValue("@unit", fields[5]);
                            comm.Parameters.AddWithValue("@add", fields[6]);
                            try
                            {
                                conn.Open();
                                comm.ExecuteNonQuery();
                                System.Diagnostics.Debug.WriteLine(fields[3]);
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
    }
}
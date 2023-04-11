using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WatersidePortal
{
    public partial class ArchivedCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.SelectedIndexChanged += CustomersGridView_SelectedIndexChanged;
            GridView1.SelectedIndexChanging += CustomersGridView_SelectedIndexChanged2;
            GridView1.Columns[3].Visible = false;
        }

        protected void CustomersGridView_SelectedIndexChanged2(Object sender, EventArgs e)
        {
            Console.WriteLine("sfdfdgs");
        }

        protected void CustomersGridView_SelectedIndexChanged(Object sender, EventArgs e)
        {
            Console.WriteLine("asdadf");
            string ind = GridView1.SelectedRow.Cells[3].Text;
            //selectedID = Int32.Parse(ind);
            Response.Redirect("/ModifyCustomer.aspx?" + ind + "&Info");
        }
    }
}
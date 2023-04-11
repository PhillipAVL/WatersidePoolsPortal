using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WatersidePortal.Staff
{
    public partial class Estimate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             
            if(!Page.IsPostBack)
            {
                int total = 31500;
                foreach (GridViewRow row in GridView1.Rows)

                {
                    Label ItemTotal = (Label)row.FindControl("ItemTotal");

                    //quant
                    int first = Convert.ToInt32(row.Cells[2].Text);
                    //cost
                    int second = Convert.ToInt32(row.Cells[4].Text);

                    total = (first * second)+ total;

                    ItemTotal.Text = (first * second).ToString();
                    //row.Cells[1].Text;

                }

                Label_TotalPrice.Text = total.ToString();
            }

        }
    }
}
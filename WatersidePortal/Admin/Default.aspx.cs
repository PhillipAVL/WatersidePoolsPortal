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


namespace WatersidePortal
{
    public partial class DefaultAdmin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                Label_Name.Text = System.Web.HttpContext.Current.User.Identity.Name.ToString();
            }
        }

        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
  }
}
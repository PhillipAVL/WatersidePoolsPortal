using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlackFlib1.Shared.Sections
{
    public partial class Header : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current != null && System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                CustomerDisplayName.Text = System.Web.HttpContext.Current.User.Identity.Name;
            }
            else
            {
                CustomerDisplayName.Text = "User Not Found";
            }
        }

        /// <summary>
        /// Log the user out and clear up the session and auth..
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
    }
}
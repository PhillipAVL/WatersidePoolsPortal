using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WatersidePortal.Staff
{
    public partial class ModifyEstimates : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label_Username.Text = User.Identity.Name;
        }
    }
}
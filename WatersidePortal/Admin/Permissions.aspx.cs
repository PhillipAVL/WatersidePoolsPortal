using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WatersidePortal.Models;

namespace WatersidePortal.Admin
{
    public partial class Permissions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button_LockAccount_Click(object sender, EventArgs e)
        {
            var lockoutEndDate = DateTime.MaxValue;
            ApplicationDbContext context = new ApplicationDbContext();
            var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
            UserManager.SetLockoutEndDateAsync(DropDownList_Users.SelectedValue, new DateTimeOffset(lockoutEndDate));

        }

        protected void Button_UnlockAccount_Click(object sender, EventArgs e)
        {
            var lockoutEndDate = DateTime.Now;
            ApplicationDbContext context = new ApplicationDbContext();
            var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
            UserManager.SetLockoutEndDateAsync(DropDownList_Users.SelectedValue, new DateTimeOffset(lockoutEndDate));
        }
    }
}
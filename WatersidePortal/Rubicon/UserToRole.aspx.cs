using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using WatersidePortal.Models;

namespace WatersidePortal.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ddlRole.Items.Add("Staff");
                ddlRole.Items.Add("Admin");

                ApplicationDbContext context = new ApplicationDbContext();

                var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
                var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
                foreach(IdentityUser user in context.Users.ToList())
                {
                    ddlUser.Items.Add(user.Email.ToString());
                    ddlUserID.Items.Add(user.Id.ToString());
                }

                // creating Creating Client role    
                if (!roleManager.RoleExists("Admin"))
                {
                    var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                    role.Name = "Admin";
                    roleManager.Create(role);

                }

                // creating Creating Company role    
                if (!roleManager.RoleExists("Staff"))
                {
                    var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole();
                    role.Name = "Staff";
                    roleManager.Create(role);

                }
            }
        }

        protected void btnRoleAssign_Click(object sender, EventArgs e)
        {
            ApplicationDbContext context = new ApplicationDbContext();

            var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));


            

            string roleName = ddlRole.SelectedItem.Text;
            string userName = ddlUserID.SelectedItem.Text;

            UserManager.AddToRole(userName, roleName);
        }
    }
}
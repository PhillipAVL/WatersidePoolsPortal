using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using WatersidePortal.Models;

namespace WatersidePortal.Admin
{
    public partial class AddRole : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DisplayRolesInGrid();
                ApplicationDbContext context = new ApplicationDbContext();

                var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
                var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));

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
        private void DisplayRolesInGrid()
        {
            var context = new ApplicationDbContext();

            grdRoleList.DataSource = context.Roles.ToArray();
            grdRoleList.DataBind();
        }
        protected void btnCreateRole_Click(object sender, EventArgs e)
        {

            /*
            string newRoleName = txtRoleName.Text.Trim();

            if (!Roles.RoleExists(newRoleName))
            {
                Roles.CreateRole(newRoleName);
                DisplayRolesInGrid();
            }
            txtRoleName.Text = string.Empty;*/

        }
        protected void grdRoleList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label RoleNameLabel = grdRoleList.Rows[e.RowIndex].FindControl("RoleNameLabel") as Label;
            Roles.DeleteRole(RoleNameLabel.Text, false);
            DisplayRolesInGrid();
        }
    }
}
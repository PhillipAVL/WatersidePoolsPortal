using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using WatersidePortal.Models;

namespace WatersidePortal.Account
{
    public partial class ResetPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            divSuccess.Visible = false;
        }

        protected string StatusMessage
        {
            get;
            private set;
        }

        protected async void Reset_Click(object sender, EventArgs e)
        {
            try
            {
                ApplicationDbContext context = new ApplicationDbContext();
                UserStore<ApplicationUser> store = new UserStore<ApplicationUser>(context);
                UserManager<ApplicationUser> UserManager = new UserManager<ApplicationUser>(store);
                String hashedNewPassword = UserManager.PasswordHasher.HashPassword(Password.Text);
                ApplicationUser cUser = await store.FindByIdAsync(DropDownList_Users.SelectedValue);
                await store.SetPasswordHashAsync(cUser, hashedNewPassword);
                await store.UpdateAsync(cUser);

                divSuccessMessage.InnerText = "Password Reset!";
                divSuccess.Visible = true;

            }

            catch
            {
                divSuccessMessage.InnerText = "Password Reset has failed!";
                divSuccess.Visible = true;
            }
        }
    }
}
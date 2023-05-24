using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Org.BouncyCastle.Asn1;
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
    public partial class RemoveStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            divSuccess.Visible = false;

            //ApplicationDbContext context = new ApplicationDbContext();
            //var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));

            //bool userLocked = false;
            //string userStatus = string.Empty;
            //try
            //{
            //    var user = UserManager.FindById(User.Identity.GetUserId());
            //    userLocked = UserManager.IsLockedOut(user.Id);
            //    userStatus = userLocked == true ? "Locked" : "Unlocked";
            //    lblUserLocked.Text = "User is currently " + userStatus;
            //}
            //catch (Exception ex)
            //{
            //    if (ex.Message == "UserId not found.")
            //    {
            //        lblUserLocked.Text = "The user cannot be found.";
            //    }
            //    else
            //    {
            //        lblUserLocked.Text = "An error has ocurred while trying to find the current user.";
            //    }
            //}
        }

        /// <summary>
        /// Lock the user account.
        /// Set the columns in LockoutEndDateUtc in table AspNetUsers = Max date
        ///  - This Locks the user account
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_LockAccount_Click(object sender, EventArgs e)
        {
            var lockoutEndDate = DateTime.MaxValue.AddDays(-1);
            ApplicationDbContext context = new ApplicationDbContext();
            var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
            UserManager.SetLockoutEndDateAsync(DropDownList_Users.SelectedValue, new DateTimeOffset(lockoutEndDate));

            divSuccessMessage.InnerText = "User Account Locked";
            divSuccess.Visible = true;
        }

        /// <summary>
        /// Unlock the user account.
        /// SSet the columns in LockoutEndDateUtc in table AspNetUsers = Now
        ///  - This Unlocks the user account
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_UnlockAccount_Click(object sender, EventArgs e)
        {
            var lockoutEndDate = DateTime.Now;
            ApplicationDbContext context = new ApplicationDbContext();
            var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
            UserManager.SetLockoutEndDateAsync(DropDownList_Users.SelectedValue, lockoutEndDate);

            divSuccessMessage.InnerText = "User Account Unlocked";
            divSuccess.Visible = true;
        }
    }
}
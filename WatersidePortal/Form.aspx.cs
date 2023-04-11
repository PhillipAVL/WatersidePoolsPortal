using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WatersidePortal
{
    public partial class Form : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (string loc in System.IO.Directory.GetFiles(HttpRuntime.AppDomainAppPath + "Documents"))
            {
                if (!loc.ToLower().EndsWith(".pdf"))
                {
                    continue;
                }
                
                HyperLink hyp = new HyperLink();
                hyp.NavigateUrl = "~/Documents/" + loc.Split('\\')[loc.Split('\\').Length - 1];
                hyp.Text = loc.Split('\\')[loc.Split('\\').Length - 1].Remove(loc.Split('\\')[loc.Split('\\').Length - 1].Length - 4, 4);
                Page.Controls.Add(hyp);

                container.Controls.Add(hyp);

                container.Controls.Add(new LiteralControl("<br />"));
                container.Controls.Add(new LiteralControl("<br />"));
            }
            container.Controls.RemoveAt(container.Controls.Count - 1);
            container.Controls.RemoveAt(container.Controls.Count - 1);
        }
    }
}
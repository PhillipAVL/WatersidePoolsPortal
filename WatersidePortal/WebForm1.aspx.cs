using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WatersidePortal
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            SqlDataSource_MyMessages.SelectParameters["username"].DefaultValue = User.Identity.Name;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //get user
            Label_User.Text = HttpContext.Current.User.Identity.Name;

        }

        protected void Button_SendMessage_Click(object sender, EventArgs e)
        {
            string msender = "Unknown";
            if (System.Web.Security.Membership.GetUser() != null && System.Web.Security.Membership.GetUser().UserName != null && System.Web.Security.Membership.GetUser().UserName.Length > 0)
            {
                msender = System.Web.Security.Membership.GetUser().UserName;
            }
            //insert into Messages Table
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO [dbo].[Messages] (SenderId, RecipientId, MessageText, Date, IsVisible, IsRead) VALUES (@Sender, @Recipient, @Message, @Date, @Visible, @Read)");
                //cmd.CommandType = CommandType.Text;
                cmd.Connection = connection;
                cmd.Parameters.AddWithValue("@Sender", msender);
                cmd.Parameters.AddWithValue("@Recipient", Recipient.Text);
                cmd.Parameters.AddWithValue("@Message", TextBox_Message.Text);
                cmd.Parameters.AddWithValue("@Date", DateTime.Now);
                cmd.Parameters.AddWithValue("@Visible", "1");
                cmd.Parameters.AddWithValue("@Read", "0");

                cmd.ExecuteNonQuery();
                connection.Close();
            }
            TextBox_Message.Text = "";
        }
        protected void Button_ReadMessage_Click(object sender, EventArgs e)
        {
        }

        protected PdfDocument MergeAllPDFsInDirectory(string directory)
        {
            //Get the PDFs in directory, stick in array
            string[] filePaths = Directory.GetFiles(directory, "*.pdf", SearchOption.AllDirectories);

            using (PdfDocument outPdf = new PdfDocument())
            {
                //crawl array
                foreach (string filePath in filePaths)
                {
                    //Merge said PDFs w/PDFSharp
                    using (PdfDocument current = PdfReader.Open(filePath, PdfDocumentOpenMode.Import))
                    {
                        for (int i = 0; i < current.PageCount; i++)
                        {
                            outPdf.AddPage(current.Pages[i]);
                        }
                    }
                }

                return (outPdf);
            }
        }




    }
}
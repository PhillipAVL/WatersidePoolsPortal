using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace WatersidePortal.Staff
{
    public partial class Comission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {


        }

        protected void SwitchViews()
        {
            Panel_Commission.Visible = false;
            Panel_Results.Visible = true;
        }

        protected void Button_Calculate_Click(object sender, EventArgs e)
        {


            SwitchViews();

            //TextBox_Homeowner.Text;
            TextBox_BeforeCommTotal.Text =  (Convert.ToDouble(TextBox_BreakdownTotal.Text) / Convert.ToDouble(TextBox_CommissionPercent.Text)).ToString("0.00");
            TextBox_TotalComission.Text = (Convert.ToDouble(TextBox_BeforeCommTotal.Text) / Convert.ToDouble(TextBox_CommissionPercent.Text)).ToString("0.00");
            Convert.ToDouble(TextBox_ContractPrice.Text);
            TextBox_OverageCommission.Text = (Convert.ToDouble(TextBox_Overage.Text) / Convert.ToDouble(TextBox_SplitAmount.Text)).ToString("0.00");
            TextBox_ReducedCommission.Text = (Convert.ToDouble(TextBox_TotalComission.Text) - Convert.ToDouble(TextBox_Discount.Text)).ToString("0.00");
            TextBox_FinalTotal.Text = (Convert.ToDouble(TextBox_ReducedCommission.Text) + Convert.ToDouble(TextBox_OverageCommission.Text)).ToString("0.00");
            //TextBox_Salesman.Text;

            string oldFile = "https://watersidepoolsportal.azurewebsites.net/Forms/Commission_Breakdown.pdf";
            //string newFile = "newFile.pdf";

            // open the reader
            PdfReader reader = new PdfReader(oldFile);
            Rectangle size = reader.GetPageSizeWithRotation(1);
            Document document = new Document(size);
            
            //var pdfDoc = new Document(PageSize.LETTER.Rotate());

            PdfWriter pdfWriter = PdfWriter.GetInstance(document, Response.OutputStream);

            document.Open();
            // the pdf content
            PdfContentByte cb = pdfWriter.DirectContent;

            // select the font properties
            BaseFont bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            //cb.SetColorFill(BaseColor.DARK_GRAY);
            cb.SetFontAndSize(bf, 18);

            // write the text in the pdf content

            cb.BeginText();
            string text3 = TextBox_Homeowner.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text3, 300, 595, 0);
            cb.EndText();

            cb.BeginText();
            string text4 = TextBox_BreakdownTotal.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text4, 300, 555, 0);
            cb.EndText();

            cb.BeginText();
            string text5 = TextBox_ContractPrice.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text5, 300, 529, 0);
            cb.EndText();

            cb.BeginText();
            string text6 = TextBox_Overage.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text6, 300, 503, 0);
            cb.EndText();

            cb.BeginText();
            string text7 = TextBox_Discount.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text7, 300, 477, 0);
            cb.EndText();

            cb.BeginText();
            string text8 = TextBox_ContractPrice.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text8, 290, 430, 0);
            cb.EndText();

            cb.BeginText();
            string text9 = TextBox_CommissionPercent.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text9, 385, 430, 0);
            cb.EndText();

            cb.BeginText();
            string text10 = TextBox_CommissionPercent.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text10, 385, 380, 0);
            cb.EndText();

            cb.BeginText();
            string text11 = TextBox_BeforeCommTotal.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text11, 500, 430, 0);
            cb.EndText();

            cb.BeginText();
            string text12 = TextBox_BeforeCommTotal.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text12, 290, 380, 0);
            cb.EndText();

            cb.BeginText();
            string text13 = TextBox_TotalComission.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text13, 500, 380, 0);
            cb.EndText();

            cb.BeginText();
            string text14 = TextBox_OverageCommission.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text14, 290, 330, 0);
            cb.EndText();

            cb.BeginText();
            string text15 = TextBox_SplitAmount.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text15, 385, 330, 0);
            cb.EndText();

            cb.BeginText();
            string text16 = TextBox_OverageCommission.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text16, 500, 330, 0);
            cb.EndText();

            cb.BeginText();
            string text18 = TextBox_Discount.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text18, 300, 280, 0);
            cb.EndText();

            cb.BeginText();
            string text17 = TextBox_ReducedCommission.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text17, 425, 280, 0);
            cb.EndText();

            cb.BeginText();
            string text19 = TextBox_FinalTotal.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text19, 395, 215, 0);
            cb.EndText();

            cb.BeginText();
            string text20 = TextBox_Salesman.Text;
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text20, 80, 165, 0);
            cb.EndText();
            /*
            cb.BeginText();
            string text2 = DateTime.Now.ToShortDateString();
            // put the alignment and coordinates here
            cb.ShowTextAligned(1, text2, 495, 125, 0);
            cb.EndText();*/

            // create the new page and add it to the pdf
            PdfImportedPage page = pdfWriter.GetImportedPage(reader, 1);
            cb.AddTemplate(page, 0, 0);

            // close the streams and voilá the file should be changed :)
            document.Close();
            document.Close();
            Response.Buffer = true;
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Certificate.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Write(document);
            Response.End();


        }
    }
}
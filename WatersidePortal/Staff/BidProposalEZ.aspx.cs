﻿using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
// Microsoft.Graph;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using File = System.IO.File;

namespace WatersidePortal.Admin
{
    public partial class BidProposalEZ : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[6] { new DataColumn("ItemID"), new DataColumn("Quantity"), new DataColumn("Item"), new DataColumn("Price"), new DataColumn("Unit"), new DataColumn("Subtotal") });
                ViewState["Customers"] = dt;
                dt.Rows.Add("9999999", "1", "Standard EZ Flow Pool", "35750.00", "per", "35750.00");
                this.BindGrid();

                Label_Username.Text = User.Identity.Name;
                Label_CurrentEstimateID.Text = System.Guid.NewGuid().ToString();
            }


        }

        protected void BindGrid()
        {
            // Commented out by PH
            //GridView_Estimates.DataSource = (DataTable)ViewState["Customers"];
            //GridView_Estimates.DataBind();
        }


        protected void GridView_Estimate_Databound(object sender, EventArgs e)
        {
            DataTable dt2 = (DataTable)ViewState["Customers"];
            double total2 = 0;
            int count = 0;

            if (GridView_Estimates.Rows.Count != 0)
            {
                foreach (GridViewRow row2 in GridView_Estimates.Rows)
                {

                    if (row2.Cells[5].Text == "Total: ")
                    {
                        dt2.Rows.RemoveAt(count);
                        this.BindGrid();
                    }
                    else
                    {
                        total2 = total2 + Convert.ToDouble(row2.Cells[6].Text);

                        if (count != 2)
                        {
                            //row2.Cells[count].Attributes.Add("style", "white-space: nowrap;");
                        }
                    }

                    count++;
                }

            }

            dt2.Rows.Add("", "", "", "", "Total: ", total2.ToString("0,000.00"));
            GridView_Estimates.DataBind();

        }


        protected void GridView_Categories_SelectedIndexChanged(object sender, EventArgs e)
        {
            Panel_Categories.Visible = false;
            Panel_Items.Visible = true;

            GridView_Items.DataSource = Items;
            string subcat = GridView_Categories.SelectedRow.Cells[2].Text;

            if (subcat == "&nbsp;")
            {
                Items.SelectCommand = "SELECT TOP (1000000) [ItemID], [Item], [Description], [CustomerPrice], [Unit] FROM [PB_EZ] WHERE [Category] = '" + GridView_Categories.SelectedRow.Cells[1].Text + "' AND [Subcategory] is null Order by [Category]";
            }
            else
            {
                Items.SelectCommand = "SELECT TOP (1000000) [ItemID], [Item], [Description], [CustomerPrice], [Unit] FROM [PB_EZ] WHERE [Category] = '" + GridView_Categories.SelectedRow.Cells[1].Text + "' AND [Subcategory] = '" + GridView_Categories.SelectedRow.Cells[2].Text + "' Order by [Category]";
            }



            GridView_Items.DataBind();
        }

        protected void DeleteRow(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = (DataTable)ViewState["Customers"];
            dt.Rows.RemoveAt(e.RowIndex);
            GridView_Estimates.DataSource = dt;
            GridView_Estimates.DataBind();
        }

        protected void IndexChanged(object sender, EventArgs e)
        {
            GridView_RecalledEstimate.DataBind();
        }

        protected void GetEstimatesForCustomer(object sender, EventArgs e)
        {
            var customerId = DropDownList_Customer2.SelectedValue;
            DropDownList_Estimates.Items.Clear();
            //DropDownList_Estimates.DataSource = 
                LoadEstimates(customerId);
            //DropDownList_Estimates.Items.Add("text");
        }

        // <%--<asp:SqlDataSource ID="SqlDataSourceEsitmateIds" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [EstimateID], [EstimateItemID] FROM [Estimates] WHERE ([CustomerID] = @CustomerID)"></asp:SqlDataSource>--%>

        private void LoadEstimates(string customerId)
        {
            DataTable estimates = new DataTable();
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString))
            {

                try
                {
                    var sqlString = "SELECT [EstimateID], [EstimateItemID] FROM [Estimates] WHERE [CustomerID] = " + customerId;
                    SqlDataAdapter adapter = new SqlDataAdapter(sqlString, con);
                    adapter.Fill(estimates);

                    DropDownList_Estimates.DataSource = estimates;
                    DropDownList_Estimates.DataTextField = "EstimateID";
                    DropDownList_Estimates.DataValueField = "EstimateItemID";
                    DropDownList_Estimates.DataBind();
                }
                catch (Exception ex)
                {
                    // Handle the error
                }

            }

            // Add the initial item - you can add this even if the options from the
            // db were not successfully loaded
            //ddlSubject.Items.Insert(0, new ListItem("<Select Subject>", "0"));

        }


        protected void FinalizeEstimateButton_Click(object sender, EventArgs e)
        {

            string estimateid = Label_CurrentEstimateID.Text;
            GridView_Estimates.AutoGenerateDeleteButton = false;
            this.DataBind();

            foreach (GridViewRow row in GridView_Estimates.Rows)

            {
                //Basically only saves to DB if it's not a recalled dataset
                if (estimateid == DropDownList_Estimates.Text)
                {
                    estimateid = DateTime.Now.ToString() + estimateid;
                }

                if (row.Cells[0].Text.Length != 0 && row.Cells[0].Text != "&nbsp;")
                {
                    string cmdString = "INSERT INTO Estimates ([EstimateID],[PoolType],[ItemID],[Quantity],[CreatedBy],[CreatedDate],[CustomerID]) VALUES (@EstimateID, @PoolType, @ItemID, @Quantity, @CreatedBy, @CreatedDate, @CustomerID)";
                    string connString = ConfigurationManager.ConnectionStrings["WatersidePortal_dbConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        using (SqlCommand comm = new SqlCommand())
                        {
                            comm.Connection = conn;
                            comm.CommandText = cmdString;
                            comm.Parameters.AddWithValue("@EstimateID", estimateid);
                            comm.Parameters.AddWithValue("@PoolType", "EZ Flow");
                            comm.Parameters.AddWithValue("@ItemID", row.Cells[0].Text);
                            comm.Parameters.AddWithValue("@Quantity", row.Cells[1].Text);
                            comm.Parameters.AddWithValue("@CreatedBy", System.Web.HttpContext.Current.User.Identity.Name);
                            comm.Parameters.AddWithValue("@CreatedDate", DateTime.Now.ToString());
                            comm.Parameters.AddWithValue("@CustomerID", DropDownList_Customer.SelectedValue);


                            //try
                            {
                                conn.Open();
                                comm.ExecuteNonQuery();
                            }
                            //catch(SqlException f)
                            {
                                // do something with the exception
                                // don't hide it
                            }
                        }
                    }

                }
            }



            List<string> cssFiles = new List<string>();
            cssFiles.Add(@"~/Content/StyleSheets/style.css");

            string report = GrabGridView_Estimates();
            report = report.Replace("<div>", "<div> <br /> <br /> <br /> <br /> <br /> <br /> <br />");

            string css = System.IO.File.ReadAllText(this.MapPath("~/Content/StyleSheets/site.css"));
            report = "<html lang=\"en\"><head><style>" + css + "</style></head>" + "<body>" + report + "</body></html >";



            byte[] pdf; // result will be here

            var cssText = System.IO.File.ReadAllText(this.MapPath("~/Content/StyleSheets/style.css"));
            var html = GrabGridView_Estimates();

            html = html.Replace("<div>", "<div> <br /> <br /> <br /> <br /> <br /> <br /> <br />");

            PdfImportedPage importedPage = null;


            MemoryStream outStream = new MemoryStream();


            var document = new Document(PageSize.LETTER, 50, 50, 60, 60);
            PdfCopy pdfCopyProvider = null;


            // Intialize a new PdfReader instance with the contents of the source Pdf file:
            PdfReader reader = new PdfReader("https://watersidepoolsportal.azurewebsites.net/Forms/ez_template.pdf");

            // Capture the correct size and orientation for the page:
            document = new Document(reader.GetPageSizeWithRotation(4));

            // Initialize an instance of the PdfCopyClass with the source
            // document and an output file stream:
            pdfCopyProvider = new PdfCopy(document, outStream);
            document.Open();

            // Extract the desired page number:
            importedPage = pdfCopyProvider.GetImportedPage(reader, 4);
            pdfCopyProvider.AddPage(importedPage);
            //pdfCopyProvider.AddToBody
            pdfCopyProvider.Close();
            pdf = outStream.ToArray();


            PdfReader reader2 = new PdfReader(pdf);
            Document document2 = new Document(reader2.GetPageSizeWithRotation(1));
            MemoryStream outStream2 = new MemoryStream();

            System.Byte[] inputFile;
            System.Byte[] overlayFile;
            //System.Byte[] outFile;//= outFile = Directory.GetCurrentDirectory() + "//merged.pdf";

            List<byte[]> PDFList = new List<byte[]>();
            //Create a stream that we can write to, in this case a MemoryStream

            using (var ms = new MemoryStream())
            {
                //Create an iTextSharp Document which is an abstraction of a PDF but **NOT** a PDF
                using (var doc = document2)
                {
                    //Create a writer that's bound to our PDF abstraction and our stream
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {
                        doc.Open();
                        using (var msCss = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(css)))
                        {
                            using (var msHtml = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(report)))
                            {
                                using (var srHtml = new StringReader(report))
                                {

                                    //Parse the HTML
                                    iTextSharp.tool.xml.XMLWorkerHelper.GetInstance().ParseXHtml(writer, doc, srHtml);
                                }
                            }
                        }
                        doc.Close();
                    }

                }



                //PDFList.Add(pdf);
                overlayFile = pdf;
                pdf = ms.ToArray();
                inputFile = pdf;

                //PDFList.Add(pdf);
                //pdf = MergePDFs(PDFList);
            }


            string name = Path.GetTempPath() + "//" + Convert.ToBase64String(Guid.NewGuid().ToByteArray()).Substring(0, 8).Replace("/", "") + ".pdf";
            string name2 = Path.GetTempPath() + "//" + Convert.ToBase64String(Guid.NewGuid().ToByteArray()).Substring(0, 8).Replace("/", "") + ".pdf";

            //Create the reader and document to read the origanl PDF document
            PdfReader reader3 = new PdfReader(inputFile);
            Document inputDoc = new Document(reader3.GetPageSizeWithRotation(1));

            using (FileStream fs3 = new FileStream(name, FileMode.Create))
            {

                //Create the PDF Writer to create the new PDF Document
                PdfWriter outputWriter = PdfWriter.GetInstance(inputDoc, fs3);
                inputDoc.Open();
                //Create the Content Byte to stamp to the wrtiter
                PdfContentByte cb1 = outputWriter.DirectContent;

                //Get the PDF document to use as overlay
                PdfReader overlayReader = new PdfReader(overlayFile);
                PdfImportedPage overLay = outputWriter.GetImportedPage(overlayReader, 1);

                //Get the overlay page rotation
                int overlayRotation = overlayReader.GetPageRotation(1);

                int n = reader3.NumberOfPages;

                int i = 1;
                while (i <= n)
                {
                    //Make sure the new page's page size macthes the original document
                    inputDoc.SetPageSize(reader3.GetPageSizeWithRotation(i));
                    inputDoc.NewPage();


                    PdfImportedPage page1 = outputWriter.GetImportedPage(reader3, i);
                    int rotation = reader3.GetPageRotation(i);

                    //Insert the overlay with correct rotation
                    if (overlayRotation == 90 || overlayRotation == 270)
                    {
                        cb1.AddTemplate(overLay, 0, -1f, 1f, 0, 0,
                            reader3.GetPageSizeWithRotation(i).Height);
                    }
                    else
                    {
                        cb1.AddTemplate(overLay, 1f, 0, 0, 1f, 0, 0);
                    }

                    //Insert the original PDF page with correct rotation
                    if (rotation == 90 || rotation == 270)
                    {
                        cb1.AddTemplate(page1, 0, -1f, 1f, 0, 0,
                            reader3.GetPageSizeWithRotation(i).Height);
                    }
                    else
                    {
                        cb1.AddTemplate(page1, 1f, 0, 0, 1f, 0, 0);
                    }

                    //Increment the page
                    i++;

                }




                //Close the input file
                inputDoc.Close();
                //Close the reader for the overlay file
                overlayReader.Close();


            }
            reader3.Close();
            string homeownerrespon = "";
            if (CheckBox1.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox1.Text + "\r\n";
            }
            if (CheckBox2.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox2.Text + "\r\n";
            }
            if (CheckBox3.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox3.Text + "\r\n";

            }
            if (CheckBox4.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox4.Text + "\r\n";

            }
            if (CheckBox5.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox5.Text + "\r\n";

            }
            if (CheckBox6.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox6.Text + "\r\n";

            }
            if (CheckBox7.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox7.Text + "\r\n";

            }
            if (CheckBox8.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox8.Text + "\r\n";

            }
            if (CheckBox9.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox9.Text + "\r\n";

            }
            if (CheckBox10.Checked)
            {
                homeownerrespon = homeownerrespon + CheckBox10.Text + "\r\n";

            }
            if (CheckBox11.Checked)
            {
                homeownerrespon = homeownerrespon + TextBox_HomeownerResponsibilities.Text;
            }


            PdfReader reader5 = new PdfReader(name);
            FileStream fs = new FileStream(name2, FileMode.Create, FileAccess.Write);
            PdfStamper stamper = new PdfStamper(reader5, fs);
            PdfContentByte canvas = stamper.GetOverContent(1);
            BaseFont bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            ColumnText ct = new ColumnText(canvas);
            float ypos = 30.00E-1f;

            Phrase phrases = new Phrase(homeownerrespon);
            ct.SetSimpleColumn(phrases, document.Left, document.Bottom, document.Right, document.Top / ypos, 15, Element.ALIGN_CENTER);
            ct.Go();
            stamper.Close();

            Byte[] DocDataStream;

            using (FileStream stream = File.Open(Server.MapPath("/Forms/ez_template_part1.pdf"), FileMode.Open))
            {
                using (BinaryReader br = new BinaryReader(stream))
                {
                    DocDataStream = br.ReadBytes((int)stream.Length);
                }
            }

            Byte[] DocDataStream2;

            using (FileStream stream = File.Open(name2, FileMode.Open))
            {
                using (BinaryReader br = new BinaryReader(stream))
                {
                    DocDataStream2 = br.ReadBytes((int)stream.Length);
                }
            }

            Byte[] DocDataStream3;

            using (FileStream stream = File.Open(Server.MapPath("/Forms/ez_template_part3.pdf"), FileMode.Open))
            {
                using (BinaryReader br = new BinaryReader(stream))
                {
                    DocDataStream3 = br.ReadBytes((int)stream.Length);
                }
            }
            PDFList.Add(DocDataStream);
            PDFList.Add(DocDataStream2);
            PDFList.Add(DocDataStream3);
            pdf = MergePDFs(PDFList);

            Response.Clear();
            Response.AppendHeader("content-disposition", "attachment; filename=" + name);
            Response.ContentType = "application/pdf";
            Response.Buffer = true;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(pdf);
            Response.Flush();
            Response.End();

            GridView_Estimates.DataSource = null;
            GridView_Estimates.DataBind();
        }


        protected void RecallEstimateButton_Click(object sender, EventArgs e)
        {
            double total = 0;
            DataTable dt = (DataTable)ViewState["Customers"];
            Label_CurrentEstimateID.Text = DropDownList_Estimates.Text;


            foreach (GridViewRow row in GridView_RecalledEstimate.Rows)

            {
                if (row.Cells[0].Text != "ItemID")
                {
                    double subtotal = 0;
                    //subtotal
                    try
                    {
                        subtotal = Convert.ToDouble(row.Cells[1].Text) * Convert.ToDouble(row.Cells[3].Text);
                        total = total + subtotal;
                    }

                    catch { }

                    //ItemID, Quantity, Name, Price, Unit
                    dt.Rows.Add(row.Cells[0].Text, row.Cells[1].Text, row.Cells[2].Text, row.Cells[3].Text, row.Cells[4].Text, subtotal.ToString("0.00"));
                    //cleans unit blanks
                    if (row.Cells[4].Text == "")
                    {
                        row.Cells[4].Text = " ";
                    }



                    ViewState["Customers"] = dt;


                    this.BindGrid();
                }

            }
        }
        private static byte[] GeneratePdfBiteArray(string htmlTable)
        {
            byte[] bytes;
            using (var ms = new MemoryStream())
            {
                using (var doc = new iTextSharp.text.Document())
                {
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {
                        doc.Open();

                        using (var srHtml = new StringReader(htmlTable))
                        {
                            XMLWorkerHelper.GetInstance().ParseXHtml(writer, doc, srHtml);
                        }
                        doc.Close();
                    }
                }
                bytes = ms.ToArray();
            }
            return bytes;
        }


        public static byte[] MergePDFs(List<byte[]> pdfFiles)
        {
            if (pdfFiles.Count > 1)
            {
                PdfReader finalPdf;
                Document pdfContainer;
                PdfWriter pdfCopy;
                MemoryStream msFinalPdf = new MemoryStream();

                finalPdf = new PdfReader(pdfFiles[0]);
                pdfContainer = new Document();
                pdfCopy = new PdfSmartCopy(pdfContainer, msFinalPdf);

                pdfContainer.Open();

                for (int k = 0; k < pdfFiles.Count; k++)
                {
                    finalPdf = new PdfReader(pdfFiles[k]);
                    for (int i = 1; i < finalPdf.NumberOfPages + 1; i++)
                    {
                        ((PdfSmartCopy)pdfCopy).AddPage(pdfCopy.GetImportedPage(finalPdf, i));
                    }
                    pdfCopy.FreeReader(finalPdf);

                }
                finalPdf.Close();
                pdfCopy.Close();
                pdfContainer.Close();

                return msFinalPdf.ToArray();
            }
            else if (pdfFiles.Count == 1)
            {
                return pdfFiles[0];
            }
            return null;
        }

        //magical error killing function
        public override void VerifyRenderingInServerForm(Control control)
        {
            //required to avoid the runtime error "  
            //Control 'GridView1' of type 'GridView' must be placed inside a form tag with runat=server."  
        }

        private string GrabGridView_Estimates()
        {

            System.Web.UI.Page p = new System.Web.UI.Page();
            p.DesignerInitialize();

            HtmlForm form = new HtmlForm();
            p.Controls.Add(form);

            p.StyleSheetTheme = this.Page.StyleSheetTheme;
            GridView_Estimates.AllowPaging = false;
            Response.ClearContent();
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            //form.Attributes["runat"] = "server";
            form.Controls.Add(GridView_Estimates);
            form.RenderControl(htw);
            return (sw.ToString());
        }


        protected void AddItemButton_Click(object sender, EventArgs e)
        {
            double total = 0;
            DataTable dt = (DataTable)ViewState["Customers"];


            foreach (GridViewRow row in GridView_Items.Rows)

            {
                TextBox TextBox_ItemQuantity = (TextBox)row.FindControl("ItemQuantity");

                //DataTable dt = (DataTable)ViewState["Customers"];
                if (TextBox_ItemQuantity.Text != "" && row.Cells[4].Text != "")
                {
                    //subtotal
                    double subtotal = Convert.ToDouble(TextBox_ItemQuantity.Text) * Convert.ToDouble(row.Cells[4].Text);
                    total = total + subtotal;

                    //ItemID, Quantity, Name, Price, Unit
                    dt.Rows.Add(row.Cells[1].Text, TextBox_ItemQuantity.Text, row.Cells[2].Text, row.Cells[4].Text, row.Cells[5].Text, subtotal.ToString("0.00"));
                    //cleans unit blanks
                    if (row.Cells[5].Text == "")
                    {
                        row.Cells[5].Text = " ";
                    }



                    ViewState["Customers"] = dt;


                    this.BindGrid();
                }






                //Quantity
                //Label1.Text = Label1.Text + TextBoxTest.Text;

                //ItemID
                //row.Cells[1].Text; 

                TextBox_ItemQuantity.Text = "";
            }

            Panel_Items.Visible = false;
            Panel_Categories.Visible = true;

        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Panel_Items.Visible = false;
            Panel_Categories.Visible = true;
            this.DataBind();
        }

    }
}

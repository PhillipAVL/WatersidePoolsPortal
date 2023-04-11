<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="Forms.aspx.cs" Inherits="WatersidePortal.Staff.Forms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
            <br />
            <br />
            <div class="col-lg-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Customer Forms
                    </div>
                    <div class="panel-body">
                        <h4>
                            <asp:HyperLink ID="Contract" runat="server" NavigateUrl="~/Forms/Contract.pdf">Contract</asp:HyperLink>
                            <br />
                            <br />
                            <asp:HyperLink ID="Customer_Explanation" runat="server" NavigateUrl="~/Forms/Customer_Explanation.pdf">Customer Explanation</asp:HyperLink>
                            <br />
                            <br />
                            <asp:HyperLink ID="Electrical_Disclamer" runat="server" NavigateUrl="~/Forms/Electrical_Disclamer.pdf">Electrical Disclamer</asp:HyperLink>
                            <br />
                            <br />
                            <asp:HyperLink ID="Project_Breakdown" runat="server" NavigateUrl="~/Forms/Project_Breakdown.pdf">Project Breakdown</asp:HyperLink>
                            <br />
                            <br />
                            <asp:HyperLink ID="Schedule_of_Events" runat="server" NavigateUrl="~/Forms/Schedule_of_Events.pdf">Schedule of Events</asp:HyperLink>
                            <br />
                            <br />
                            <asp:HyperLink ID="Selection_Sheet" runat="server" NavigateUrl="~/Forms/Selection_Sheet.pdf">Selection Sheet</asp:HyperLink>
                            <br />
                            <br />
                            <asp:HyperLink ID="Commission_Checklist" runat="server" NavigateUrl="~/Forms/Customer_Explanation 2.pdf">Commission Checklist</asp:HyperLink>
                            <br />
                            <br />
                        </h4>
                    </div>
                </div>
            </div>

        </section>
    </section>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
    <%--You can add your custom JavaScript for each page on this section.--%>
    <script>$("#forms").addClass("active")</script>
</asp:Content>

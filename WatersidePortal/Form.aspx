<%-- Forms View --%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="Form.aspx.cs" Inherits="WatersidePortal.Form" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
            <br />
            <br />
            <div class="col-lg-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Customer Forms
                    </div>
                    <div class="panel-body">
                        <h4 runat="server" id="container">
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

<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="Locks.aspx.cs" Inherits="WatersidePortal.Admin.RemoveStaff" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
            <section id="main-content">
        <section class="wrapper site-min-height">
                                        <br />
                            <br />
                                            <div class="panel panel-default">

                        <div class="panel-heading">

                            <h4 class="title">
                                Manage User Account Locks
                            </h4>
                        </div>
                        <div class="panel-body">
            <br />
            <br />
                            Simply select the user account from the dropdown menu below and select your desired function.<br />
                            <br />
&nbsp;<asp:DropDownList ID="DropDownList_Users" runat="server" DataSourceID="SqlDataSource1" DataTextField="Email" DataValueField="Id"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [Email], [Id] FROM [AspNetUsers]"></asp:SqlDataSource>
                            <br />
    <br />
    <asp:Button ID="Button_LockAccount" runat="server" Text="Lock Account" OnClick="Button_LockAccount_Click" CssClass="btn btn-danger" />
    &nbsp;
    <asp:Button ID="Button_UnlockAccount" runat="server" OnClick="Button_UnlockAccount_Click" Text="Unlock Account" CssClass="btn btn-success" />
            
                            </div>
                                                </div>
                            </section>
                </section>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
            <script>$("#User-Management").addClass("active")</script>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="Permissions.aspx.cs" Inherits="WatersidePortal.Admin.Permissions" %>

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

                    <h4 class="title">Manage Staff Permissions
                    </h4>
                </div>
                <div class="panel-body">
                    <br />
                    <br />
                    <p>
                        Staff Selection:
                        &nbsp;<asp:DropDownList ID="DropDownList_Users" runat="server" DataSourceID="SqlDataSource1" DataTextField="Email" DataValueField="Id"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [Email], [Id] FROM [AspNetUsers]"></asp:SqlDataSource>
                    </p>
                    <br />
                    <br />
                    <p>
                        General Permissions:
                       
                        <asp:DropDownList ID="DropDownList_Permissions" runat="server">
                            <asp:ListItem Text="None" Value="None" />
                            <asp:ListItem Text="Salesperson" Value="Salesperson" />
                            <asp:ListItem Text="Construction Worker" Value="Construction Worker" />
                        </asp:DropDownList>
                    </p>
                    <br />
                    <div>
                        <h4>Permissions:</h4>
                        <div style="margin-left: 30px;">
                            <asp:CheckBoxList runat="server" ID="CheckList_Permissions">
                                <asp:ListItem>Customer Payments Tab - Receiving Payments</asp:ListItem>
                                <asp:ListItem>Manage Customers - Editing / Creating Customer Profile</asp:ListItem>
                                <asp:ListItem>Permitting Management - Approving Permit Documents</asp:ListItem>
                                <asp:ListItem>Request Item Changes</asp:ListItem>
                                <asp:ListItem>Surveys Status Management - Being Able to Set the Status / Edit any Survey</asp:ListItem>
                                <asp:ListItem>View All Projects</asp:ListItem>
                                <asp:ListItem>View All Employee Commissions</asp:ListItem>
                                <asp:ListItem>View Customer History</asp:ListItem>
                                <asp:ListItem>Manage Deposits</asp:ListItem>
                                <asp:ListItem>Payments Due Tab and Table</asp:ListItem>
                                <asp:ListItem>View Recently Approved Addendums</asp:ListItem>
                                <asp:ListItem>Handle Work Orders</asp:ListItem>
                                <asp:ListItem>Manage Work Orders</asp:ListItem>
                                <asp:ListItem>Edit Price Books Without Requesting</asp:ListItem>
                                <asp:ListItem>Technican Overview</asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <br />
                    <div>
                        <h4>Milestones:</h4>
                        <div style="margin-left: 30px">
                            <asp:CheckBoxList runat="server" ID="CheckList_Milestones">
                                <asp:ListItem>View Construction Milestones</asp:ListItem>
                                <asp:ListItem>View Sales Milestones</asp:ListItem>
                                <asp:ListItem>View Permitting Milestones</asp:ListItem>
                                <asp:ListItem>View Service and Repair History</asp:ListItem>
                                <asp:ListItem>Set Construction $$$$$ Milestones</asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <br />
                    <div>
                        <h4>Notifications:</h4>
                        <div style="margin-left: 30px">
                            <asp:CheckBoxList runat="server" ID="CheckList_Notifications">
                                <asp:ListItem>Notification for Deposits</asp:ListItem>
                                <asp:ListItem>Notification for Screen Enclosure File Has Upload</asp:ListItem>
                                <asp:ListItem>Notification for Fire Up</asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
    <script>$("#User-Management").addClass("active")</script>
</asp:Content>

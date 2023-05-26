<%@ Page Title="Reset Password" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="WatersidePortal.Account.ResetPassword" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="ContentBody">
    <section id="main-content">
        <section class="wrapper site-min-height">
            <br />
            <br />
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="title">Set User Account Password.
                            </h4>
                </div>
                <div class="panel-body">
                
                    <%-- User notification message --%>
                    <div id="divSuccess" class="panel panel-success" runat="server" visible="false">
                        <div id="divSuccessMessage" class="panel-heading" runat="server"></div>
                    </div>

                    <div class="form-horizontal">
                        <h4>Enter new password and select the Reset button</h4>
                        <br />
                        
                        <asp:ValidationSummary runat="server" CssClass="text-danger" />
                        
                        <%-- User DropDown List --%>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="DropDownList_Users" CssClass="col-md-2 control-label">Email</asp:Label>
                            <div class="col-md-3">
                                <asp:DropDownList ID="DropDownList_Users" runat="server" DataSourceID="SqlDataSource1" DataTextField="Email" DataValueField="Id"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [Email], [Id] FROM [AspNetUsers]"></asp:SqlDataSource>
                            </div>
                        </div>

                        <%-- Password --%>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                            <div class="col-md-3">
                                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                    CssClass="text-danger" ErrorMessage="The password field is required." />
                            </div>
                        </div>

                        <%-- Confirm Password --%>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>
                            <div class="col-md-3">
                                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                            </div>
                        </div>

                        <%-- Form Action Buttons --%>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button runat="server" OnClick="Reset_Click" Text="Reset" CssClass="btn btn-primary" />
                            </div>
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

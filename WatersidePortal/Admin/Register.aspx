<%@ Page Title="Register" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WatersidePortal.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="ContentBody">
    <section id="main-content">
        <section class="wrapper site-min-height">
            <br />
            <br />
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="title">Register New Staff Accounts</h4>
                </div>

                <div class="panel-body">
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="ErrorMessage" />
                    </p>

                    <%-- User success message --%>
                    <div id="divSuccess" class="panel panel-success" runat="server" visible="false">
                        <div id="divSuccessMessage" class="panel-heading" runat="server"></div>
                    </div>

                    <div class="form-horizontal">
                        <asp:ValidationSummary runat="server" CssClass="text-danger" />

                        <%-- Email Address --%>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox ID="Email" runat="server" CssClass="form-control control-medium" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                    Display="Dynamic" CssClass="text-danger" ErrorMessage="The email field is required." />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="Email"
                                    CssClass="text-danger" ErrorMessage="Please enter a valid email address formatted as (name@domain.com)"
                                    Display="Dynamic" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" />
                            </div>
                        </div>

                        <%-- Password --%>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control control-medium" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                    CssClass="text-danger" ErrorMessage="The password field is required." />
                            </div>
                        </div>

                        <%-- Confirm Password --%>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control control-medium" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                            </div>
                        </div>

                        <%--Form Buttons--%>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-primary" />
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

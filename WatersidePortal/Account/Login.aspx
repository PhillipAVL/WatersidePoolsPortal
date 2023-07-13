<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WatersidePortal.Login" Async="true" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | Waterside Portal
        </title>
    <link rel="shortcut" type="image/x-icon" href="~/favicon.ico" />
    <link rel="shortcut icon" type="image/x-icon" href="~/favicon.ico" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="description" content="Wawterside Pools Theme" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="keyword" content="Template, Theme, Responsive, Fluid, Retina" />
    <link href="~/Content/StyleSheets/bootstrap.css" rel="stylesheet" />
    <link href="~/Content/StyleSheets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="~/Content/StyleSheets/style.css" rel="stylesheet" />
    <link href="~/Content/StyleSheets/style-responsive.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
</head>

<body>

    <div id="login-page">
        <div class="container">
            <form class="form-login" runat="server">
                <div class="row">
                    <div class="col-md-12">


                        <section id="loginForm">
                            <h2 class="form-login-heading">User Login</h2>
                            <div class="login-wrap">
                                <center>
                                    <asp:Image ID="imgLoginLogo" runat="server" ImageUrl="~/Content/Images/waterside_pools_logo.png" alt="Waterside Pools Login" Style="width: 250px; height: 100px;" /></center>

                                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                                    <p class="text-danger">
                                        <asp:Literal runat="server" ID="FailureText" />
                                    </p>
                                </asp:PlaceHolder>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="Email" CssClass="control-label"></asp:Label>

                                    <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" placeholder="User Name" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                        CssClass="text-danger" ErrorMessage="The email field is required." />


                                    <asp:Label runat="server" AssociatedControlID="Password" CssClass="control-label"></asp:Label>

                                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" placeholder="Password" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />


                                    <span class="pull-right">

                                        <asp:CheckBox runat="server" ID="RememberMe" />
                                        <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                                    </span>
                                </div>
                                
                                <%-- Form Action Button --%>
                                <div class="form-group">
                                    <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="btn btn-theme btn-block" />
                                </div>

                                <%-- Currently Not Used --%>
                                <%--<div class="registration">
                                    Forgot your password?
                                    <br />
                                    <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Request a reset.</asp:HyperLink>
                                </div>--%>

                            </div>
                        </section>
                    </div>
                </div>
            </form>
        </div>
    </div>


</body>
</html>


<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="BlackFlib1.Shared.Sections.Header" %>

<header class="header black-bg">

    <div class="sidebar-toggle-box">
        <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation">
        </div>
    </div>

    <a href="/Default.aspx" class="logo">
        <asp:Image ID="Image1" runat="server" ImageUrl="https://watersidepoolsportal.azurewebsites.net/Content/Images/WP_Horizontal.png" ImageAlign="Left" CssClass="hidden-phone" />
    </a>

    <div class="nav notify-row" id="top_menu">
        <ul class="nav top-menu">
        </ul>
    </div>

    <div style="text-align:right; margin-top:5px;">
        <asp:Label runat="server" ID="CustomerDisplayName" Font-Size="Medium" />
    </div>

    <div class="top-menu">
        <ul class="nav pull-right top-menu">
            <li>
                <asp:LinkButton ID="LinkButtonLogout" style="text-align:right; bottom:5px;" runat="server" CausesValidation="false" Class="logout" OnClick="LinkButtonLogout_Click">Logout</asp:LinkButton>
            </li>
        </ul>
    </div>
</header>

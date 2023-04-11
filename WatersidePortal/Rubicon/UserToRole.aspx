<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="UserToRole.aspx.cs" Inherits="WatersidePortal.Admin.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
            <section id="main-content">
        <section class="wrapper site-min-height">
        <h2>
        Assign Role to User
    </h2>
    <fieldset class="register">
        <legend>User and Role</legend>
        <p>
            Select Role:
            <asp:DropDownList ID="ddlRole" runat="server"></asp:DropDownList>
            <asp:DropDownList ID="ddlUserID" runat="server"></asp:DropDownList>

            <asp:RequiredFieldValidator ID="rfvRole" runat="server" 
            ControlToValidate="ddlRole" Display="Dynamic" 
            ErrorMessage="*"></asp:RequiredFieldValidator>
        </p>
        <p>
            Select User:
            <asp:DropDownList ID="ddlUser" runat="server"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvUser" runat="server" 
            ControlToValidate="ddlUser" Display="Dynamic" 
            ErrorMessage="*"></asp:RequiredFieldValidator>
        </p>
    </fieldset>
    <p>
        <asp:Button ID="btnRoleAssign" runat="server" Text="Assign Role" 
            onclick="btnRoleAssign_Click" />
    </p>
    <p>
    </p>
            </section>
                </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

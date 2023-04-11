<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="AddRole.aspx.cs" Inherits="WatersidePortal.Admin.AddRole" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
        <section id="main-content">
        <section class="wrapper site-min-height">
        <h2>Create Roles</h2>
    <fieldset class="register">
        <legend>Role Information</legend>
        <p>
            Role Name:
            <asp:TextBox ID="txtRoleName" runat="server" CssClass="textEntry"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvRoleName" runat="server" 
                ControlToValidate="txtRoleName" Display="Dynamic" ValidationGroup="Role"
                ErrorMessage="*"></asp:RequiredFieldValidator>
        </p>
    </fieldset>
    <p>
        <asp:Button ID="btnCreateRole" runat="server" Text="Create Role"  ValidationGroup="Role"
                onclick="btnCreateRole_Click" />
    </p>
    <p>
        <asp:GridView ID="grdRoleList" runat="server" AutoGenerateColumns="False" onrowdeleting="grdRoleList_RowDeleting">
            <Columns>
                <asp:CommandField DeleteText="Delete Role" ShowDeleteButton="True" />
                <asp:TemplateField HeaderText="Role">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="RoleNameLabel" Text='<%# Container.DataItem %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </p>
            </section>
            </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

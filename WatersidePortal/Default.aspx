<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WatersidePortal._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <asp:Panel ID="Delinquent_Pop" runat="server" Visible="false" Style="position: absolute; left: 210px; top: 79px; background-color: #80808080; width: calc(100% - 210px); height: 100%; z-index: 1;">
            <asp:Panel ID="Delinquent_Message" runat="server" Style="width: 430px; height: 170px; background-color: white; margin: 0 auto; margin-top: 300px; padding: 5px;">
                <asp:Label ID="Delinquent_Client" runat="server" text="ERROR: Missing Delinquency Message" />
                <br />
                <asp:TextBox ID="Delinquent_Reason" runat="server" Width="95%" Height="300px" />
                <br />
                <asp:Button ID="Deplinquent_Submit" runat="server" text="Submit" />
            </asp:Panel>
        </asp:Panel>
        <section class="wrapper site-min-height">
            <br />
            <h2>Welcome
                    <asp:Label ID="Label_Name" runat="server" Text="Label"></asp:Label></h2>
                    <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></h2>
            <br />
            <h4>Incomplete Sold Jobs:</h4>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Customer Name" />
                    <asp:BoundField DataField="Address" HeaderText="Home Address" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT * FROM [Customers]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label_Name" Name="Salesman" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </section>
    </section>
</asp:Content>

<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
    <%--You can add your custom JavaScript for each page on this section.--%>
    <script>$("#home").addClass("active")</script>
</asp:Content>

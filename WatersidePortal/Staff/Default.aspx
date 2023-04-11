<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WatersidePortal.Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
                        <div class="panel panel-default">
                <div class="panel-body">


            <h2>Welcome <asp:Label ID="Label_Name" runat="server" Text="Label"></asp:Label></h2>
            <br />
            <h4>Here are your recently selected items.</h4>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataSourceID="SqlDataSource1" Width="100%">
                <Columns>
                    <asp:BoundField DataField="PoolType" HeaderText="PoolType" SortExpression="PoolType" />
                    <asp:BoundField DataField="ItemID" HeaderText="ItemID" SortExpression="ItemID" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                    <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" SortExpression="CreatedBy" />
                    <asp:BoundField DataField="CreatedDate" HeaderText="CreatedDate" SortExpression="CreatedDate" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT * FROM [Estimates] WHERE ([CreatedBy] = @CreatedBy)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label_Name" Name="CreatedBy" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
                    </div>
                            </div>
        </section>
    </section>
</asp:Content>

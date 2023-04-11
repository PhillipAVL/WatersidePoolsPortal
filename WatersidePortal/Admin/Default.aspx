<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WatersidePortal.DefaultAdmin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
         
            <div class="panel panel-default">
                <div class="panel-body">
            <h2>Welcome <asp:Label ID="Label_Name" runat="server" Text="Label"></asp:Label></h2>
            <br />
            <h4>Here are all recently created bid proposals.</h4>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataSourceID="SqlDataSource1" Width="100%" AllowPaging="True" DataKeyNames="EstimateID">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="PoolType" HeaderText="PoolType" SortExpression="PoolType" />
                    <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" SortExpression="CreatedBy" />
                    <asp:BoundField DataField="CreatedDate" HeaderText="CreatedDate" SortExpression="CreatedDate" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT DISTINCT [EstimateID], [PoolType], [CreatedBy], [CreatedDate] FROM [Estimates] ORDER BY [CreatedDate]">
            </asp:SqlDataSource>
                    <h4>Selected Bid Proposals Details populate below.</h4>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataSourceID="SqlDataSource2" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                            <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" />
                            <asp:BoundField DataField="CustomerPrice" HeaderText="CustomerPrice" SortExpression="CustomerPrice" />
                            <asp:BoundField DataField="COGS" HeaderText="COGS" SortExpression="COGS" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" OnSelecting="SqlDataSource2_Selecting" SelectCommand="SELECT [Quantity], [Item], [CustomerPrice], [COGS] FROM [Estimates_View] WHERE ([EstimateID] = @EstimateID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="EstimateID" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
        </div>
                </div>
        </section>
    </section>
</asp:Content>

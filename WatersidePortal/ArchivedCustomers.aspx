<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="ArchivedCustomers.aspx.cs" Inherits="WatersidePortal.ArchivedCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">

    <style type="text/css">
        .Grid, .Grid th, .Grid td {
            border: 1px solid #e0e0e0;
            text-align: center;
        }

        .custId {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <br />
                    <h4 class="title">Archived Customers
                    </h4>
                </div>
                <div class="panel-body">
                    <h4>Find Customer</h4>
                    <asp:TextBox runat="server" TextMode="Search" placeholder="Enter any detail" ID="search" Width="30%"/>
                    <p>
                        <asp:GridView OnSelectedIndexChanged="CustomersGridView_SelectedIndexChanged" ID="GridView1" CssClass="Grid" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="Both" DataKeyNames="CustomerID" Width="100%">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" ItemStyle-ForeColor="#428BCA" HeaderText="Edit/Pool Info" />
                                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                                <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" InsertVisible="False" ReadOnly="True" SortExpression="CustomerID" ControlStyle-CssClass="custId" />
                                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                                <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                                <asp:BoundField DataField="Telephone" HeaderText="Telephone" SortExpression="Telephone" />
                                <asp:BoundField DataField="" HeaderText="Alternate Telephone" SortExpression="State" />
                                <asp:BoundField DataField="" HeaderText="Email" SortExpression="Telephone" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [FirstName], [LastName], [CustomerID], [Address], [City], [State], [Telephone] FROM [Customers]" DeleteCommand="DELETE FROM [Customers] WHERE [CustomerID] = @CustomerID" InsertCommand="INSERT INTO [Customers] ([FirstName], [LastName], [Address], [City], [State], [Telephone], [Alternate], [Email]) VALUES (@FirstName, @LastName, @Address, @City, @State, @Telephone, @Alternate, @Email)" UpdateCommand="UPDATE [Customers] SET [FirstName] = @FirstName, [LastName] = @LastName, [Address] = @Address, [City] = @City, [State] = @State, [Telephone] = @Telephone, [Alternate] = @Alternate, [Email] = @Email WHERE [CustomerID] = @CustomerID">
                            <DeleteParameters>
                                <asp:Parameter Name="CustomerID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="FirstName" Type="String" />
                                <asp:Parameter Name="LastName" Type="String" />
                                <asp:Parameter Name="Address" Type="String" />
                                <asp:Parameter Name="City" Type="String" />
                                <asp:Parameter Name="State" Type="String" />
                                <asp:Parameter Name="Telephone" Type="String" />
                                <asp:Parameter Name="Alternate" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="FirstName" Type="String" />
                                <asp:Parameter Name="LastName" Type="String" />
                                <asp:Parameter Name="Address" Type="String" />
                                <asp:Parameter Name="City" Type="String" />
                                <asp:Parameter Name="State" Type="String" />
                                <asp:Parameter Name="Telephone" Type="String" />
                                <asp:Parameter Name="CustomerID" Type="Int32" />
                                <asp:Parameter Name="Alternate" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </p>
                </div>
            </div>
        </section>
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

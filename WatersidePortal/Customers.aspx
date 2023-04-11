<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="WatersidePortal.CreateCustomer" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
    
    <style type="text/css">
        .Grid, .Grid th, .Grid td
        {
            border:1px solid #e0e0e0;
            text-align: center;
        }

        .custId
        {
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
                            <h4 class="title">
                                Customer Management
                            </h4>
                        </div>
                        <div class="panel-body">
                            <ul class="nav nav-tabs">
                                <li id="CreateTab">
                                    <a href="#Create" data-toggle="tab" onclick="tab('Create');">
                                        Create Customer
                                    </a>
                                </li>
                                <li id="ModifyTab">
                                    <a href="#Modify" data-toggle="tab" onclick="tab('Modify');">
                                        Modify Customer
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade in" id="Create">
                                    <h4>Create Customer</h4>
                                    <p>
                                    First Name:
                                    <asp:TextBox ID="TextBox_FirstName" runat="server"></asp:TextBox>
                                    </p>
                                    <p>
                                    Last Name:
                                    <asp:TextBox ID="TextBox_LastName" runat="server"></asp:TextBox>
                                    </p>
                                    <p>
                                        Address:<asp:TextBox ID="TextBox_Address" runat="server"></asp:TextBox>
                                    </p>
                                    <p>
                                        City:<asp:TextBox ID="TextBox_City" runat="server"></asp:TextBox>
                                    </p>
                                    <p>
                                        Zip Code:<asp:TextBox ID="TextBox_ZipCode" runat="server"></asp:TextBox>
                                    </p>
                                    <p>
                                        Telephone:<asp:TextBox ID="TextBox_Telephone" runat="server"></asp:TextBox>
                                    </p>
                                    <p>
                                        Alternate Telephone:<asp:TextBox ID="TextBox_Alternate_Telephone" runat="server"></asp:TextBox>
                                    </p>
                                    <p>
                                        Email Address:<asp:TextBox ID="TextBox_Email_Address" runat="server"></asp:TextBox>
                                    </p>
                                    <p>
                                        <asp:Button ID="Button_CreateCustomer" runat="server" Text="Create Customer" OnClick="AddUser" />
                                    </p>
                                </div>
                                <div class="tab-pane fade in" id="Modify">
                                    <h4>Find Customer</h4>
                                    <asp:TextBox runat="server" TextMode="Search" placeholder="Enter any detail" ID="search" Width="30%"/>
                                    <p>
                                        <asp:GridView OnSelectedIndexChanged="CustomersGridView_SelectedIndexChanged" ID="GridView1" CssClass="Grid" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="Both" DataKeyNames="CustomerID" Width="100%">
                                            <AlternatingRowStyle BackColor="White" />
                                            <Columns>
                                                <asp:CommandField ShowSelectButton="True" ItemStyle-ForeColor="#428BCA" HeaderText="Edit/Pool Info" />
                                                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                                                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                                                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                                                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                                                <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                                                <asp:BoundField DataField="Telephone" HeaderText="Telephone" SortExpression="Telephone" />
                                                <asp:BoundField DataField="Alternate" HeaderText="Alternate Telephone" SortExpression="Alternate" />
                                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                                <asp:BoundField DataField="CustomerID" InsertVisible="False" ReadOnly="True" SortExpression="CustomerID" ControlStyle-CssClass="custId" ItemStyle-CssClass="custId" HeaderStyle-CssClass="custId"/>
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
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [FirstName], [LastName], [CustomerID], [Address], [City], [State], [Telephone], [Alternate], [Email] FROM [Customers]" DeleteCommand="DELETE FROM [Customers] WHERE [CustomerID] = @CustomerID" InsertCommand="INSERT INTO [Customers] ([FirstName], [LastName], [Address], [City], [State], [Telephone], [Alternate], [Email]) VALUES (@FirstName, @LastName, @Address, @City, @State, @Telephone, @Alternate, @Email)" UpdateCommand="UPDATE [Customers] SET [FirstName] = @FirstName, [LastName] = @LastName, [Address] = @Address, [City] = @City, [State] = @State, [Telephone] = @Telephone, [Alternate] = @Alternate, [Email] = @Email WHERE [CustomerID] = @CustomerID">
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
                            </div>
            </div>
        </section>
    </section>
    <script type="text/javascript">
        if (window.location.href.split('?').length > 1) {
            document.getElementById(window.location.href.split('?')[1]).classList.add('active');
            document.getElementById(window.location.href.split('?')[1] + "Tab").className = 'active';
        } else {
            window.location.href = "Customers?Create";
        }
        function tab(which) {
            if (window.location.href.split('?').length > 1) {
                window.location.href = "Customers?" + which;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

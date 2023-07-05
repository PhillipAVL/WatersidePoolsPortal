﻿<%-- Customer Add & Manage --%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="WatersidePortal.CreateCustomer" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
    <style type="text/css">
        .Grid, .Grid th, .Grid td {
            border: 1px solid #e0e0e0;
            text-align: left;
        }

        .custId {
            display: none;
        }

        div {
            margin-bottom: 2px;
        }

        /* Fomratting form label-textbox layout */
        input[type="textbox"] {
            display: block;
            float: left;
            margin-right: 2px;
        }

        label {
            display: block;
            float: left;
            width: 150px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <br />
                    <h4 class="title">Customer Management</h4>
                </div>

                <asp:ValidationSummary runat="server" CssClass="text-danger" />

                <div class="panel-body">
                    <ul class="nav nav-tabs">
                        <li id="CreateTab">
                            <a href="#Create" data-toggle="tab" onclick="tab('Create');">Create Customer
</a>
                        </li>
                        <li id="ModifyTab">
                            <a href="#Modify" data-toggle="tab" onclick="tab('Modify');">Manage Customer</a>
                        </li>
                    </ul>


                    <%-- Create Customer --%>
                    <div class="tab-content">
                        <br />
                        <div class="tab-pane fade in" id="Create">
                            <h4>Create Customer</h4>

                            <%-- First Name --%>
                            <p>
                                <asp:Label ID="label" AssociatedControlID="TextBox_FirstName" Text="First Name:" runat="server" />
                                <asp:TextBox ID="TextBox_FirstName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirst" ControlToValidate="TextBox_FirstName"
                                    Display="Static" ErrorMessage="First Name is required" runat="server" ForeColor="Red" />
                            </p>

                            <%-- Last Name --%>
                            <p>
                                <asp:Label ID="label1" AssociatedControlID="TextBox_LastName" Text="Last Name:" runat="server" />
                                <asp:TextBox ID="TextBox_LastName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorLast" ControlToValidate="TextBox_LastName"
                                    Display="Static" ErrorMessage="Last Name is required" runat="server" ForeColor="Red" />
                            </p>

                            <%-- Address --%>
                            <p>
                                <asp:Label ID="label2" AssociatedControlID="TextBox_Address" Text="Address:" runat="server" />
                                <asp:TextBox ID="TextBox_Address" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorAddress" ControlToValidate="TextBox_Address"
                                    Display="Static" ErrorMessage="Address is required" runat="server" ForeColor="Red" />
                            </p>

                            <%-- City --%>
                            <p>
                                <asp:Label ID="label3" AssociatedControlID="TextBox_City" Text="City:" runat="server" />
                                <asp:TextBox ID="TextBox_City" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorCity" ControlToValidate="TextBox_City"
                                    Display="Static" ErrorMessage="City is required" runat="server" ForeColor="Red" />
                            </p>

                            <%-- Zip Code --%>
                            <p>
                                <asp:Label ID="label4" AssociatedControlID="TextBox_ZipCode" Text="Zip Code:" runat="server" />
                                <asp:TextBox ID="TextBox_ZipCode" runat="server"></asp:TextBox>

                                <asp:RequiredFieldValidator runat="server" ID="rfvZipCode" ControlToValidate="TextBox_ZipCode"
                                    Display="Dynamic" ErrorMessage="Zip Code is required" ForeColor="Red" />
                                <asp:RegularExpressionValidator ID="regexpcontactZipCode" runat="server" ControlToValidate="TextBox_ZipCode"
                                    Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a Zip Code formatted as (XXXXX) or 10 Digit (XXXXX-XXXX)"
                                    ValidationExpression="^\d{5}(-\d{4})?$">
                                </asp:RegularExpressionValidator>
                            </p>

                            <%-- Phone --%>
                            <p>
                                <asp:Label ID="label5" AssociatedControlID="TextBox_Telephone" Text="Primary Phone:" runat="server" />
                                <asp:TextBox ID="TextBox_Telephone" runat="server"></asp:TextBox>

                                <asp:RequiredFieldValidator runat="server" ID="rfvPhone" ControlToValidate="TextBox_Telephone"
                                    Display="Dynamic" ErrorMessage="Primary Phone is required" ForeColor="Red" />
                                <asp:RegularExpressionValidator ID="regexpvalPhone" runat="server" ControlToValidate="TextBox_Telephone"
                                    Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a phone number formatted as (XXX-XXX-XXXX)"
                                    ValidationExpression="^(1-)?\d{3}-\d{3}-\d{4}$">
                                </asp:RegularExpressionValidator>
                            </p>

                            <%-- Alternate Phone --%>
                            <p>
                                <asp:Label ID="label6" AssociatedControlID="TextBox_Alternate_Telephone" Text="Alternate Telephone:" runat="server" />
                                <asp:TextBox ID="TextBox_Alternate_Telephone" runat="server"></asp:TextBox>

                                <asp:RegularExpressionValidator ID="regexpvalAlternatePhone" runat="server" ControlToValidate="TextBox_Alternate_Telephone"
                                    Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a phone number formatted as (XXX-XXX-XXXX)"
                                    ValidationExpression="^(1-)?\d{3}-\d{3}-\d{4}$">
                                </asp:RegularExpressionValidator>
                            </p>

                            <%-- Email --%>
                            <p>
                                <asp:Label ID="label7" AssociatedControlID="TextBox_Email_Address" Text="Email:" runat="server" />
                                <asp:TextBox ID="TextBox_Email_Address" runat="server"></asp:TextBox>

                                <asp:RequiredFieldValidator runat="server" ID="rfvEmail" ControlToValidate="TextBox_Email_Address"
                                    Display="Dynamic" ErrorMessage="Email Address is required" ForeColor="Red" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox_Email_Address"
                                    Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a valid email address formatted as (name@domain.com)"
                                    ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$">
                                </asp:RegularExpressionValidator>
                            </p>

                            <p>
                                <br />
                                <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Create Customer" OnClick="AddUser" />
                            </p>
                        </div>


                        <%-- Manage Customers Grid --%>
                        <asp:Panel ID="panSearch" runat="server" DefaultButton="btnFilterGrid" Width="100%" Visible="false">
                            <div class="tab-pane fade in" id="Modify">
                                <h4>Find Customer</h4>
                                <asp:TextBox runat="server" TextMode="Search" placeholder="Enter any customer detail" ID="search" Width="30%" onFocus="this.select()" />
                                <asp:Button ID="btnFilterGrid" runat="server" Text="Filter Customers" class="btn btn-primary" CausesValidation="false" OnClick="FilterGrid"/>

                                <p>
                                    <asp:GridView OnSelectedIndexChanged="CustomersGridView_SelectedIndexChanged" ID="GridView1" CssClass="Grid" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="Both" DataKeyNames="CustomerID" Width="100%">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" ItemStyle-ForeColor="#428BCA" HeaderText="" />
                                            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                                            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                                            <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                                            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                                            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                                            <asp:BoundField DataField="Telephone" HeaderText="Telephone" SortExpression="Telephone" />
                                            <asp:BoundField DataField="Alternate" HeaderText="Alternate Telephone" SortExpression="Alternate" />
                                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                            <asp:BoundField DataField="CustomerID" InsertVisible="False" ReadOnly="True" SortExpression="CustomerID" ControlStyle-CssClass="custId" ItemStyle-CssClass="custId" HeaderStyle-CssClass="custId" />
                                        </Columns>
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [FirstName], [LastName], [CustomerID], [Address], [City], [State], [Telephone], [Alternate], [Email] FROM [Customers] Order By [LastName], [FirstName]" DeleteCommand="DELETE FROM [Customers] WHERE [CustomerID] = @CustomerID" InsertCommand="INSERT INTO [Customers] ([FirstName], [LastName], [Address], [City], [State], [Telephone], [Alternate], [Email]) VALUES (@FirstName, @LastName, @Address, @City, @State, @Telephone, @Alternate, @Email)" UpdateCommand="UPDATE [Customers] SET [FirstName] = @FirstName, [LastName] = @LastName, [Address] = @Address, [City] = @City, [State] = @State, [Telephone] = @Telephone, [Alternate] = @Alternate, [Email] = @Email WHERE [CustomerID] = @CustomerID">
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
                        </asp:Panel>

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

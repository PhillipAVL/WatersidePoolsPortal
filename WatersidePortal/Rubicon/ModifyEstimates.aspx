<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="ModifyEstimates.aspx.cs" Inherits="WatersidePortal.Staff.ModifyEstimates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
        <section id="main-content">
        <section class="wrapper site-min-height">
            <br />
            <div class="panel panel-default">

                <div class="panel-heading">
                    <h4 class="title">
                        MODIFY ESTIMATES
                    </h4>
                    <asp:Label ID="Label_Username" runat="server" Text="" Visible="False"></asp:Label>
                    <p class="title">
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="Customers" DataTextField="FullName" DataValueField="CustomerID" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="Customers" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [CustomerID], [FullName] FROM [Customers]"></asp:SqlDataSource>
                    </p>
                    <p class="title">
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                            <Columns>
                                <asp:BoundField DataField="ItemID" HeaderText="ItemID" SortExpression="ItemID" />
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                                <asp:BoundField DataField="Subcategory" HeaderText="Subcategory" SortExpression="Subcategory" />
                                <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" />
                                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                <asp:BoundField DataField="CustomerPrice" HeaderText="CustomerPrice" SortExpression="CustomerPrice" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [ItemID], [Quantity], [Category], [Subcategory], [Item], [Description], [CustomerPrice] FROM [Estimates_View] WHERE (([CreatedBy] = @CreatedBy) AND ([CustomerID] = @CustomerID))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Label_Username" Name="CreatedBy" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="DropDownList1" Name="CustomerID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </p>
                </div>
                <div class="panel-body">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataSourceID="Estimates" DataKeyNames="EstimateItemID">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" />
                            <asp:BoundField DataField="EstimateID" HeaderText="EstimateID" SortExpression="EstimateID" />
                            <asp:BoundField DataField="ItemID" HeaderText="ItemID" SortExpression="ItemID" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                            <asp:BoundField DataField="EstimateItemID" HeaderText="EstimateItemID" InsertVisible="False" ReadOnly="True" SortExpression="EstimateItemID" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="Estimates" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [EstimateID], [ItemID], [Quantity], [EstimateItemID] FROM [Estimates] WHERE (([CreatedBy] = @CreatedBy) AND ([CustomerID] = @CustomerID))" DeleteCommand="DELETE FROM [Estimates] WHERE [EstimateItemID] = @EstimateItemID" InsertCommand="INSERT INTO [Estimates] ([EstimateID], [ItemID], [Quantity]) VALUES (@EstimateID, @ItemID, @Quantity)" UpdateCommand="UPDATE [Estimates] SET [EstimateID] = @EstimateID, [ItemID] = @ItemID, [Quantity] = @Quantity WHERE [EstimateItemID] = @EstimateItemID">
                        <DeleteParameters>
                            <asp:Parameter Name="EstimateItemID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="EstimateID" Type="String" />
                            <asp:Parameter Name="ItemID" Type="String" />
                            <asp:Parameter Name="Quantity" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Label_Username" Name="CreatedBy" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="DropDownList1" Name="CustomerID" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="EstimateID" Type="String" />
                            <asp:Parameter Name="ItemID" Type="String" />
                            <asp:Parameter Name="Quantity" Type="String" />
                            <asp:Parameter Name="EstimateItemID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                    <br />
                    </div>
                </div>
            </section>
            </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

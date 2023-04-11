<%@ Page MaintainScrollPositionOnPostback="true" Title="PriceBook EZ" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="PriceBookEZ.aspx.cs" Inherits="WatersidePortal.Admin.PriceBookEZ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
            <br />
                <div class="panel-heading">
                    <h4 class="title">
                        Pricebook EZ Flow
                    </h4>
                </div>
                <div class="panel-body">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="#EditDelete" data-toggle="tab">
                                Edit / Delete Items
                            </a>
                        </li>
                        <li>
                            <a href="#Add" data-toggle="tab">
                                Add Items
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="EditDelete">
                            <h4>
                                <br />
                                Edit or Delete items from the pricebook below. New Items can be added on the New Items tab.
                            <br />
                            </h4>

                            <asp:Panel ID="Panel_Items" runat="server" CssClass="panel panel-default">
                                <div class="panel-heading">Item Selection</div>
                                <div class="panel-body">
            <div class="table-responsive">
                <asp:GridView ID="GridView_Items" runat="server" CssClass ="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ItemID" DataSourceID="Items" AutoGenerateEditButton="True" OnRowEditing="GridView_Items_RowEditing">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="ItemID" HeaderText="ItemID" InsertVisible="False" ReadOnly="True" SortExpression="ItemID" />
                        <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"  ControlStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="Subcategory" HeaderText="Subcategory" SortExpression="Subcategory" ControlStyle-CssClass="form-control" />
                        <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" ControlStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" ControlStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" ControlStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="CustomerPrice" HeaderText="CustomerPrice" SortExpression="CustomerPrice" ControlStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="COGS" HeaderText="COGS" SortExpression="COGS" ControlStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="ImageString" HeaderText="ImageString" SortExpression="ImageString" ControlStyle-CssClass="form-control"/>
                    </Columns>
                </asp:GridView>
            </div>

        </div>

                            </asp:Panel>
                            <br />
                            <asp:SqlDataSource ID="Items" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT * FROM [PriceBookEZ]" DeleteCommand="DELETE FROM [PriceBookEZ] WHERE [ItemID] = @ItemID" InsertCommand="INSERT INTO [PriceBookEZ] ([Category], [Subcategory], [Item], [Description], [Unit], [CustomerPrice], [COGS], [ImageString]) VALUES (@Category, @Subcategory, @Item, @Description, @Unit, @CustomerPrice, @COGS, @ImageString)" UpdateCommand="UPDATE [PriceBookEZ] SET [Category] = @Category, [Subcategory] = @Subcategory, [Item] = @Item, [Description] = @Description, [Unit] = @Unit, [CustomerPrice] = @CustomerPrice, [COGS] = @COGS, [ImageString] = @ImageString WHERE [ItemID] = @ItemID" >
<DeleteParameters>
    <asp:Parameter Name="ItemID" Type="Int32" />
</DeleteParameters>
<InsertParameters>
    <asp:Parameter Name="Category" Type="String" />
    <asp:Parameter Name="Subcategory" Type="String" />
    <asp:Parameter Name="Item" Type="String" />
    <asp:Parameter Name="Description" Type="String" />
    <asp:Parameter Name="Unit" Type="String" />
    <asp:Parameter Name="CustomerPrice" Type="String" />
    <asp:Parameter Name="COGS" Type="String" />
    <asp:Parameter Name="ImageString" Type="String" />
</InsertParameters>
<UpdateParameters>
    <asp:Parameter Name="Category" Type="String" />
    <asp:Parameter Name="Subcategory" Type="String" />
    <asp:Parameter Name="Item" Type="String" />
    <asp:Parameter Name="Description" Type="String" />
    <asp:Parameter Name="Unit" Type="String" />
    <asp:Parameter Name="CustomerPrice" Type="String" />
    <asp:Parameter Name="COGS" Type="String" />
    <asp:Parameter Name="ImageString" Type="String" />
    <asp:Parameter Name="ItemID" Type="Int32" />
</UpdateParameters>
    </asp:SqlDataSource>


                            <br />
                            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                            <br />
                        </div>
                            
                        <div class="tab-pane fade" id="Add">
                            <h4>
                                <br />
                                Add items to the pricebook below. Identically named Category / Subcategory will merge.
                            <br />
                                                            <br />

                            </h4>

                            Category: <asp:TextBox ID="TextBox_Category" runat="server" CssClass="form-control control-medium"></asp:TextBox>
                            <br />
                            Subcategory: <asp:TextBox ID="TextBox_Subcategory" runat="server" CssClass="form-control control-medium"></asp:TextBox>
                            <br />
                            Item: <asp:TextBox ID="TextBox_Item" runat="server" CssClass="form-control control-medium"></asp:TextBox>
                            <br />
                            Description: <asp:TextBox ID="TextBox_Description" runat="server" CssClass="form-control control-medium"></asp:TextBox>
                            <br />
                            Unit: <asp:TextBox ID="TextBox_Unit" runat="server" CssClass="form-control control-medium"></asp:TextBox>
                            <br />
                            Customer Price: <asp:TextBox ID="TextBox_CustomerPrice" runat="server" CssClass="form-control control-medium" TextMode="Number"></asp:TextBox>
                            <br />
                            Cost Of Goods Sold (COGS):<asp:TextBox ID="TextBox_COGS" runat="server" CssClass="form-control control-medium" TextMode="Number"></asp:TextBox>
                            <br />
                            Image String: <asp:TextBox ID="TextBox_ImageString" runat="server" CssClass="form-control control-medium"></asp:TextBox>
                            <br />
                            <asp:Button ID="Button_AddItem" runat="server" Text="Add Item" CssClass="btn btn-primary" OnClick="Button_AddItem_Click"/>
                            
                        </div>
                    </div>
                            
                </div>




</section>
</section>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

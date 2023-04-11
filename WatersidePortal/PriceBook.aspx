<%@ Page MaintainScrollPositionOnPostback="true" Title="Pricebook" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="PriceBook.aspx.cs" Inherits="WatersidePortal.PriceBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
            <br />
                <div class="panel-body">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="EditDelete">

                            <asp:Panel ID="Panel_Items" runat="server" CssClass="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="title">
                                        Price Book
                                    </h4>
                                </div>
                                <div class="panel-body">
                                    <h4>
                                        Select the category to view products. These will not be transferred to any shopping carts. (View Only)
                                    </h4>
                                    <asp:TextBox runat="server" TextMode="Search" placeholder="Enter any detail" ID="search" Width="50%"/>
                                    <br />
                                    <br />
                                    <div class="table-responsive">
                                        <asp:GridView ID="GridView_Items" runat="server" CssClass ="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowEditing="GridView_Items_RowEditing" OnSelectedIndexChanged="Selected">
                                            <Columns>
                                                <asp:CommandField ShowSelectButton="True" />
                                                <asp:BoundField ControlStyle-CssClass="form-control" DataField="Category" HeaderText="Category" SortExpression="Category" ItemStyle-Width="45%">
                                                <ControlStyle CssClass="form-control" />
                                                </asp:BoundField>
                                                <asp:BoundField ControlStyle-CssClass="form-control" DataField="Subcategories" HeaderText="Subcategory">
                                                <ControlStyle CssClass="form-control" />
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [Category], STRING_AGG(nullif([Subcategory],''), ', ') WITHIN GROUP (ORDER BY [Subcategory]) AS Subcategories FROM (select distinct [Subcategory], [Category] FROM [PriceBook]) x GROUP BY [Category]"></asp:SqlDataSource>
                                    </div>
                                </div>
                            </asp:Panel>
                            <br />
                        </div>
                    </div>
                            
                </div>




        </section>
    </section>
    <script type="text/javascript">
        current = "Category";
        if (window.location.href.split('?').length > 1) {
            document.getElementById(window.location.href.split('?')[1]).classList.add('active');
            document.getElementById(window.location.href.split('?')[1] + "Tab").className = 'active';
        } else {
            window.location.href = "PriceBook?";
        }
        function tab(which) {
            if (window.location.href.split('?').length > 1) {
                window.location.href = "PriceBook?" + which;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>
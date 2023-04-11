<%@ Page MaintainScrollPositionOnPostback="true" Title="Pricebook" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="ItemPriceBook.aspx.cs" Inherits="WatersidePortal.ItemPriceBook" %>
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
                                <div class="panel-body panel panel-default">
                                    <asp:TextBox runat="server" TextMode="Search" placeholder="Enter any detail" ID="search" Width="50%"/>
                                    <br />
                                    <br />
                                    <div class="panel-heading">
                                        <asp:Label CssClass="title" ID="hdr" runat="server" Text="Decking" />
                                    </div>
                                    <div class="panel-body panel panel-default">
                                        <div class="table-responsive">
                                            <asp:GridView ID="GridView1" runat="server" CssClass ="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" OnRowEditing="GridView_Items_RowEditing" OnSelectedIndexChanged="Selected">
                                                <Columns>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Item" HeaderText="Item" SortExpression="Item" ItemStyle-Width="20%">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Description" HeaderText="Description">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="CustomerPrice" HeaderText="Price" ItemStyle-Width="8%">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Unit" HeaderText="Unit" ItemStyle-Width="10%">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [Item], [Description], [CustomerPrice], [Unit] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = 'DECKING' AND [dbo].[PriceBook].[Subcategory] = 'Travertine' AND [dbo].[PriceBook].[Subsubcategory] = 'Alaskan Silver (Travertine - Tumbled)'"></asp:SqlDataSource>
                                        </div>
                                        <asp:Button Text="Click To Cancel And Return To Catalog" runat="server" Width="100%" BackColor="#e34a3f" ForeColor="White" Height="40px" OnClick="Back" />
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
        if (window.location.href.split('?').length > 1) {
            document.getElementById(window.location.href.split('?')[1]).classList.add('active');
            document.getElementById(window.location.href.split('?')[1] + "Tab").className = 'active';
        } else {
            window.location.href = "ItemPriceBook?DECKING&Travertine&Alaskan Silver (Travertine - Tumbled)";
        }
        function tab(which) {
            if (window.location.href.split('?').length > 1) {
                window.location.href = "ItemPriceBook?" + which;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>
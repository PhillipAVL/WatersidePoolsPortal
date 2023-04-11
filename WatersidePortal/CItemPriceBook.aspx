<%@ Page MaintainScrollPositionOnPostback="true" Title="Pricebook" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="CItemPriceBook.aspx.cs" Inherits="WatersidePortal.CItemPriceBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <style>
        .custId
        {
            display: none;
        }

        .centered
        {
            text-align: center;
            vertical-align: middle;
            align-content: center;
            align-items: center;
        }

        .checked input 
        {
            width: 25px;
            height: 25px;
        }
    </style>
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
                                        <asp:Label CssClass="title" ID="hdr" runat="server" />
                                    </div>
                                    <div class="panel-body panel panel-default">
                                        <div class="table-responsive">
                                            <asp:GridView ID="GridView1" runat="server" CssClass ="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" OnRowEditing="GridView_Items_RowEditing" OnSelectedIndexChanged="Selected">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Quantity" ItemStyle-Width="5%">
                                                        <ItemTemplate>
                                                            <asp:TextBox TextMode="Number" runat="server" Width="100%" Text="0"/>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Item" HeaderText="Item" ItemStyle-Width="20%">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Description" HeaderText="Description">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="CustomerPrice" HeaderText="Price" ItemStyle-Width="5%">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Unit" HeaderText="Unit" ItemStyle-Width="10%">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Optional" ItemStyle-Width="2%" ItemStyle-CssClass="centered">
                                                        <ItemTemplate>
                                                            <asp:CheckBox runat="server" CssClass="centered"/>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="ItemID" HeaderText="ID" ItemStyle-CssClass="custId" FooterStyle-CssClass="custId" HeaderStyle-CssClass="custId">
                                                    <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [Item], [Description], [CustomerPrice], [Unit], [ItemID] FROM [PriceBook] WHERE [dbo].[PriceBook].[Category] = 'DECKING' AND [dbo].[PriceBook].[Subcategory] = 'Travertine' AND [dbo].[PriceBook].[Subsubcategory] = 'Alaskan Silver (Travertine - Tumbled)'"></asp:SqlDataSource>
                                        </div>
                                        <br />
                                        <br />
                                        <div style="text-align: center">
                                            <asp:Button Text="Add All Item Quantities And Return To Catalog" runat="server" Width="30%" BackColor="#2196f3" ForeColor="White" Height="40px" OnClick="Submit" />
                                            <br />
                                            <br />
                                            <asp:Button Text="Click To Cancel And Return To Catalog" runat="server" Width="30%" BackColor="#e34a3f" ForeColor="White" Height="40px" OnClick="Back" />
                                        </div>
                                        <br />
                                        <br />
                                        <div style="text-align:right">
                                            <asp:CheckBox Text="Mark Unfinished" Font-Size="XX-Large" runat="server" CssClass="checked" ID="unfinished" />
                                        </div>
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
            window.location.href = "CItemPriceBook?DECKING&Travertine&Alaskan Silver (Travertine - Tumbled)";
        }
        function tab(which) {
            if (window.location.href.split('?').length > 1) {
                window.location.href = "CItemPriceBook?" + which;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>
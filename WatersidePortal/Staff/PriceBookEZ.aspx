<%@ Page Title="PriceBook EZ" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="Staff/PriceBookEZ.aspx.cs" Inherits="WatersidePortal.Staff.PriceBookEZ" %>
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
                                Pricebook EZ Flow
                            </h4>
                        </div>
                        <div class="panel-body">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#Select" data-toggle="tab">
                                        Select
                                    </a>
                                </li>
                                <li>
                                    <a href="#Estimate" data-toggle="tab">
                                        Estimate Items
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="Select">
                                    <h4>
                                        Select the items for the estimate. Results appear on the Estimate tab.
                                        Results are not saved or generated until the &quot;Click to Generate and View Finalized Estimate&quot; is pressed.</h4>

                                                <asp:Panel ID="Panel_Categories" runat="server" CssClass="panel panel-default">
                <div class="panel-body">
                    <div class="table-responsive">
                        <asp:GridView ID="GridView_Categories" runat="server" AutoGenerateColumns="False" DataSourceID="Categories" OnSelectedIndexChanged="GridView_Categories_SelectedIndexChanged" CssClass ="table table-striped table-bordered table-hover">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                                <asp:BoundField DataField="Subcategory" HeaderText="Subcategory" SortExpression="Subcategory" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>
               <asp:Panel ID="Panel_Items" runat="server" CssClass="panel panel-default" Visible="false">
                <div class="panel-heading">Item Selection</div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <asp:GridView ID="GridView_Items" runat="server" CssClass ="table table-striped table-bordered table-hover" CellPadding="4" ForeColor="#333333" GridLines="None" BorderStyle="Outset" >
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Quantity
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="ItemQuantity" runat="server" width="40px" TextMode="Number" />
                                    </ItemTemplate>
                                </asp:TemplateField>
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
                    </div>

                </div>
                                        <asp:Button ID="AddItemButton" runat="server" Text="Click to add all Item Quantities and return to Catalog." OnClick="AddItemButton_Click" class="btn btn-primary btn-lg btn-block" />

                   <br />
                   <asp:Button ID="Button_Cancel" runat="server" Text="Click to cancel and return to Catalog" class ="btn btn-danger btn-lg btn-block" OnClick="CancelButton_Click"/>

            </asp:Panel>

                                </div>
                                <div class="tab-pane fade" id="Estimate">
                                    
                                    <asp:Panel runat ="server" ID ="test" >
                                    <h4>
                                        Estimate Items
                                    </h4>
                                    </asp:Panel>
                                    <asp:GridView ID="GridView_Estimates" runat="server" CssClass="table table-striped table-bordered table-hover blueTable" CellPadding="4" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BorderStyle="Outset" AutoGenerateDeleteButton="True" OnRowDeleting="DeleteRow" ForeColor="#333333" GridLines="None">
                                        <AlternatingRowStyle BackColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
<HeaderStyle HorizontalAlign="Center" BorderStyle="Outset" BackColor="#507CD1" Font-Bold="True" ForeColor="White"></HeaderStyle>
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                        </asp:GridView>
                                    <h4>
                                        Homeowner Responsibilities
                                    </h4>
                                    <asp:TextBox ID="TextBox_HomeownerResponsibilities" runat="server" TextMode="SingleLine" Width="100%"></asp:TextBox>
                                    <br />
                                    <br />
                                    <asp:Button ID="GenerateEstimateButton" runat="server" Text="Click to Generate and View Finalized Estimate" OnClick="FinalizeEstimateButton_Click" class="btn btn-primary btn-lg btn-block" />
                                </div>
                            </div>
                        </div>
                    </div>
            <br />


            <br />
                                    


            <br />

            <asp:SqlDataSource ID="Categories" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT DISTINCT [Category], [Subcategory] FROM [PB_EZ] GROUP BY [Subcategory], Category"></asp:SqlDataSource>
            <asp:SqlDataSource ID="Items" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" > </asp:SqlDataSource>

            <br />
            <br />

        </section>
    </section>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
    <%--You can add your custom JavaScript for each page on this section.--%>
        <script>$("#estimate").addClass("active")</script>
</asp:Content>

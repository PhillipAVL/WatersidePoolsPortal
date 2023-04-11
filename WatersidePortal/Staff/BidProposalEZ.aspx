<%@ Page MaintainScrollPositionOnPostback="true" Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="BidProposalEZ.aspx.cs" Inherits="WatersidePortal.Admin.BidProposalEZ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    p
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	}
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <section class="wrapper site-min-height">
                        <br />
                     <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="title">
                                EZ-Flow Pool Bid Proposal

                            </h4>
                        </div>
                        <div class="panel-body">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#Select" data-toggle="tab">
                                        Select Specs
                                    </a>
                                </li>
                                <li>
                                    <a href="#Estimate" data-toggle="tab">
                                        Generate Pool Bid Proposal
                                    </a>
                                </li>
                                                                <li>
                                    <a href="#Recall" data-toggle="tab">
                                        Recall Pool Bid Proposal
                                    </a>
                                </li>

                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="Select">
                                    <h2>A CUSTOMER MUST BE CREATED PRIOR TO BID PROPOSAL GENERATION</h2>
                                    <br />
                                    <h4>
                                        Select the items for the Pool Bid Proposal. Results appear on the Pool Bid Proposal tab.
                                        Results are not saved or generated until the &quot;Click to Generate and View Finalized Pool Bid Proposal&quot; is pressed.</h4>
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

            <br />
                                    


            <asp:Panel ID="Panel_Items" runat="server" CssClass="panel panel-default" Visible="false">
                <div class="panel-heading">All Specs</div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <asp:GridView ID="GridView_Items" runat="server" CssClass ="table table-striped table-bordered table-hover" OnDataBound="GridView_Estimate_Databound">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Quantity
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="ItemQuantity" runat="server" width="80px" TextMode="Number" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
                                        <asp:Button ID="AddItemButton" runat="server" Text="Add All Item Quantities and return to Catalog" OnClick="AddItemButton_Click" class="btn btn-primary btn-lg btn-block" />
                                   <br />
                   <asp:Button ID="Button_Cancel" runat="server" Text="Click to cancel and return to Catalog" class ="btn btn-danger btn-lg btn-block" OnClick="CancelButton_Click"/>

                <br />

            </asp:Panel>
                                    </div>
    <br />
    <asp:SqlDataSource ID="Categories" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT DISTINCT [Category], [Subcategory] FROM [PB_EZ] ORDER BY [Category]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Items" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" > </asp:SqlDataSource>


                                <div class="tab-pane fade" id="Estimate">
                                    
                                    <h4>
                                        Select Customer
                                    </h4>
                                     <br />
                                    <asp:DropDownList ID="DropDownList_Customer" runat="server" DataSourceID="Customers" DataTextField="FullName" DataValueField="CustomerID"></asp:DropDownList>
                                    <asp:SqlDataSource ID="Customers" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [CustomerID], [FullName] FROM [Customers]"></asp:SqlDataSource>
                                    <br />
                                    <br />
                                    <h4>
                                        Estimate Items
                                    </h4>

                                    <asp:GridView ID="GridView_Estimates" runat="server" CssClass="table table-striped table-bordered table-hover" CellPadding="4" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BorderStyle="Outset" AutoGenerateDeleteButton="True" OnRowDeleting="DeleteRow" ForeColor="#333333" GridLines="None" OnPreRender="GridView_Estimate_Databound" Width="100%">
                                        <AlternatingRowStyle BackColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
<HeaderStyle HorizontalAlign="Center" BorderStyle="Outset" BackColor="#507CD1" Font-Bold="True" ForeColor="Black"></HeaderStyle>
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
                                    <table class="auto-style1">
                                        <tr>
                                            <td>                                    <asp:CheckBox ID="CheckBox1" runat="server" Text=" Landscaping, Irrigation, Sod and /or Hay &amp; Seed " />
                                    <br />
                                    <asp:CheckBox ID="CheckBox2" runat="server" Text=" Get Access letter signed by neighbor " CssClass="morris-hover" />
                                    <br />
                                    <asp:CheckBox ID="CheckBox3" runat="server" Text=" Install Gas Tank / Gas Lines / Hook-up Gas Heater " />
                                    <br />
                                    <asp:CheckBox ID="CheckBox4" runat="server" Text=" Equipment Wall or Retaining Walls " />
                                    <br />
                                    <asp:CheckBox ID="CheckBox5" runat="server" Text=" Stucco &amp; Painting" /></td>
                                            <td>                                    <asp:CheckBox ID="CheckBox6" runat="server" Text=" Additional Fill " />
                                    <br />
                                    <asp:CheckBox ID="CheckBox7" runat="server" Text=" Provide On-site Dumpster throughout project " />
                                    <br />
                                    <asp:CheckBox ID="CheckBox8" runat="server" Text=" Screen or Fence By code " />
                                    <br />
                                    <asp:CheckBox ID="CheckBox9" runat="server" Text=" Final Grade and Prepare yard for sod " />
                                    <br />
                                    <asp:CheckBox ID="CheckBox10" runat="server" Text=" Supply Initial Survey and Final Survey" />
                                    <br />
                                    <asp:CheckBox ID="CheckBox11" runat="server" />
                                    <asp:TextBox ID="TextBox_HomeownerResponsibilities" runat="server" TextMode="SingleLine"></asp:TextBox></td>
                                        </tr>
                                    </table>

                                    <br />

                                    <br />
                                    <asp:Button ID="GenerateEstimateButton" runat="server" Text="Click to Generate and View Finalized Estimate" OnClick="FinalizeEstimateButton_Click" class="btn btn-primary btn-lg btn-block" />
                                    <br />
                                    <h4>
                                        Permit Downloads below</h4>
                                    <p>
                                        <span style="font-family:&quot;HelveticaNeue&quot;,serif;color:black">Flagler County, Flagler Beach, St. Augustine Beach, St. Johns County, Volusia County, Ormond Beach, Palm Coast, Bunnell, City of St. Augustine</span><span style="color:
black"><o:p></o:p></span></p>
                                </div>
                                <div class="tab-pane fade" id="Recall">
                                    <h4>
                                        Recall Pool Bid Proposal
                                    </h4>
                                    
                                    
                                    <asp:Label ID="Label_Username" runat="server" Visible="False"></asp:Label>
                                <br />
                                Customer:
                                    <asp:DropDownList ID="DropDownList_Customer2" runat="server" DataSourceID="Customers" DataTextField="FullName" DataValueField="CustomerID"></asp:DropDownList>
                                <br />
                                EstimateID:
                                <asp:DropDownList ID="DropDownList_Estimates" runat="server" DataSourceID="SqlDataSource1" DataTextField="EstimateID" DataValueField="EstimateID" OnSelectedIndexChanged="IndexChanged"></asp:DropDownList>


                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT DISTINCT [EstimateID] FROM [Estimates] WHERE (([CustomerID] = @CustomerID) AND ([CreatedBy] = @CreatedBy) AND PoolType = 'EZ')">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Customer2" Name="CustomerID" PropertyName="SelectedValue" Type="Int32" />
                                        <asp:ControlParameter ControlID="Label_Username" Name="CreatedBy" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="GridView_RecalledEstimate" runat="server" AutoGenerateColumns="False" DataSourceID="Estimates" CssClass="table table-striped table-bordered table-hover">
                                    <Columns>
                                        <asp:BoundField DataField="ItemID" HeaderText="ItemID" SortExpression="ItemID" />
                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                        <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" />
                                        <asp:BoundField DataField="CustomerPrice" HeaderText="CustomerPrice" SortExpression="CustomerPrice" />
                                        <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="Estimates" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [ItemID], [Quantity], [Item], [CustomerPrice], [Unit] FROM [Estimates_View] WHERE ([EstimateID] = @EstimateID)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Estimates" Name="EstimateID" PropertyName="SelectedValue" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <br />
                                <asp:Button ID="Button_RecallEstimate" runat="server" OnClick="RecallEstimateButton_Click" Text="Recall Estimate" />
                                    <br />
                            <asp:Label ID="Label_CurrentEstimateID" runat="server"></asp:Label>
                                </div></div></div>
                    </div>

</section>
                </section>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
    <%--You can add your custom JavaScript for each page on this section.--%>
        <script>$("#estimate").addClass("active")</script>
</asp:Content>
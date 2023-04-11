<%@ Page MaintainScrollPositionOnPostback="true" Title="CustomerPricebook" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="CustomerPricebook.aspx.cs" Inherits="WatersidePortal.CustomerPricebook" %>

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
                                <p>
                                    <asp:Label runat="server" ID="header_title" Font-Bold="true" Font-Size="Large">Pricebook</asp:Label>
                                    <asp:TextBox runat="server" ID="description" Width="40%" Style="float: right;" />
                                </p>
                            </div>
                            <div class="panel-body">
                                <div id="Tabs" role="tabpanel">
                                    <ul runat="server" class="nav nav-tabs" id="tabs" onchange="tab">
                                        <li id="SelectTab">
                                            <a title="Select_Tab" runat="server" href="#Select" role="tab" data-toggle="tab" onclick="tab('Select');">Price Book
                                            </a>
                                        </li>
                                        <li id="CartTab">
                                            <a title="Cart_Tab" role="tab" href="#Cart" data-toggle="tab" onclick="tab('Cart');">Shopping Cart
                                            </a>
                                        </li>
                                        <%--<li id="PreviousTab">
                                            <a title="Previous_Tab" href="#Previous" role="tab" data-toggle="tab" onclick="tab('Previous');">Previous Bid Proposal Version
                                            </a>
                                        </li> --%>
                                    </ul>
                                </div>
                                <br />
                                <br />
                                <div class="tab-content">
                                    <br />
                                    <div class="tab-pane fade in" id="Select">
                                        <asp:TextBox runat="server" TextMode="Search" placeholder="Enter any detail" ID="search" Width="50%" />
                                        <br />
                                        <br />
                                        <div class="table-responsive">
                                            <asp:GridView ID="GridView_Items" runat="server" CssClass="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowEditing="GridView_Items_RowEditing">
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True" />
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Category" HeaderText="Category" SortExpression="Category">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Res" HeaderText="Subcategory">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [Category], STRING_AGG([Subcategory], ',') WITHIN GROUP (ORDER BY [Subcategory]) AS Res FROM (select distinct [Subcategory], [Category] FROM [PB_Global]) x GROUP BY [Category]"></asp:SqlDataSource>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade in" id="Cart">
                                        <div style="flex-direction: column; display: flex; float: right;">
                                            <p>
                                                <asp:Button runat="server" Width="180px" Height="40px" Text="Save Changes" BackColor="#ffeb3b" ForeColor="#000" />
                                            </p>
                                            <p>
                                                <asp:Button runat="server" Width="180px" Height="40px" Text="Preview" BackColor="#987dc7" ForeColor="#FFFFFF" />
                                            </p>
                                        </div>
                                        <p>
                                            <asp:Label runat="server" ID="Cart_Title" Font-Size="Large">Pricebook: </asp:Label>
                                            <asp:TextBox runat="server" ID="TextBox1" Width="40%" />
                                        </p>
                                        <p>
                                            <asp:Label runat="server" ID="Cart_Description" Font-Size="Large">Description: </asp:Label>
                                            <asp:TextBox runat="server" ID="TextBox2" Width="40%" />
                                        </p>
                                        <asp:Label runat="server" ID="Label1" Font-Size="Large">Selected Items:</asp:Label>
                                        <p>
                                            Pool Length:
                                            <asp:TextBox runat="server" TextMode="Number" Text="16" Width="40"></asp:TextBox>
                                            ft.
                                            <asp:TextBox runat="server" TextMode="Number" Text="0" Width="40"></asp:TextBox>
                                            in.
                                        </p>
                                        <p>
                                            Pool Width:
                                            <asp:TextBox runat="server" TextMode="Number" Text="8" Width="40"></asp:TextBox>
                                            ft.
                                            <asp:TextBox runat="server" TextMode="Number" Text="0" Width="40"></asp:TextBox>
                                            in.
                                        </p>
                                        <br />
                                        <br />
                                        <asp:Label runat="server" ID="Label2" Font-Bold="true" Font-Size="Large">Homeowner Responsibilities</asp:Label>
                                        <asp:CheckBoxList runat="server" ID="Responsibilities" AutoPostBack="true" Font-Bold="true" Font-Size="Small" CellSpacing="1" CellPadding="1" RepeatColumns="2" RepeatDirection="Vertical" Width="100%">
                                            <asp:ListItem runat="server" Text="Landscaping, Irrigation, Sod and /or Hay & Seed" />
                                            <asp:ListItem runat="server" Text="Get Access letter signed by neighbor" />
                                            <asp:ListItem runat="server" Text="Gas Lines, Gas Hook-Ups" />
                                            <asp:ListItem runat="server" Text="Equipment Wall or Retaining Walls" />
                                            <asp:ListItem runat="server" Text="Stucco & Painting" />
                                            <asp:ListItem runat="server" Text="Homeowner Supplies Mosaic Tiles" />
                                            <asp:ListItem runat="server" Text="Additional Fill" />
                                            <asp:ListItem runat="server" Text="Provide On-site Dumpster throughout project" />
                                            <asp:ListItem runat="server" Text="Screen or Fence By code" />
                                            <asp:ListItem runat="server" Text="Final Grade and Prepare yard for sod" />
                                            <asp:ListItem runat="server" Text="Supply Initial Survey and Final Survey" />
                                        </asp:CheckBoxList>
                                        <p>
                                            <asp:CheckBox runat="server" />
                                            <asp:TextBox runat="server" />
                                        </p>
                                        <div style="flex-direction: column; display: flex; float: right;">
                                            <p>
                                                <asp:Button runat="server" Width="180px" Height="40px" Text="Save Changes" BackColor="#ffeb3b" ForeColor="#000" />
                                            </p>
                                            <p>
                                                <asp:Button runat="server" Width="180px" Height="40px" Text="Preview" BackColor="#987dc7" ForeColor="#FFFFFF" />
                                            </p>
                                        </div>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <div style="flex-direction: column; display: flex; margin: 10px; text-align: center;">
                                            <p>
                                                <asp:Button runat="server" Text="Save This as Version #1, Duplicate Cart To Version #2" BackColor="#03a9f4" ForeColor="#FFFFFF" Width="30%" Height="40px" />
                                                <asp:Button runat="server" Text="Create Version #2 From Master" BackColor="#03a9f4" ForeColor="#FFFFFF" Width="30%" Height="40px" />
                                            </p>
                                            <p>
                                                <asp:Button runat="server" Text="Lock In This Bid Proposal Version #1 and Print" ForeColor="#FFFFFF" BackColor="#4caf50" Width="30%" Height="40px" />
                                            </p>
                                            <p>
                                                <asp:Button runat="server" Text="Bid Proposal Version #1 Continue to Contract" ForeColor="#FFFFFF" BackColor="#f44336" Width="50%" Height="40px" />
                                            </p>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade in" id="Previous">
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
        if (window.location.href.split('?').length > 1 && window.location.href.split('?')[1].split('&').length > 0) {
            document.getElementById(window.location.href.split('?')[1].split('&')[1]).classList.add('active');
            document.getElementById(window.location.href.split('?')[1].split('&')[1] + "Tab").className = 'active';
        }
        function tab(which) {
            //$("[id*=TabName]").val(which);
            if (window.location.href.split('?').length > 1 && window.location.href.split('?')[1].split('&').length > 0) {
                window.location.href = "CustomerPricebook?" + window.location.href.split('?')[1].split('&')[0] + "&" + which;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

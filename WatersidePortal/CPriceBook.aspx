<%@ Page MaintainScrollPositionOnPostback="true" Title="Pricebook" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="CPriceBook.aspx.cs" Inherits="WatersidePortal.CPriceBook" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
    <style type="text/css">
        div {
            margin-bottom: 2px;
        }

        /* Fomratting form label-textbox layout */


        .labeldisplay {
            display: inline-block;
            float: left;
            width: 200px;
            font-weight: bold;
            font-size: medium;
        }

        .textboxdisplay {
            width: 400px;
            border: 0px none;
            font-size: medium;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <style type="text/css">
        .inclusion {
            width: 50%;
            margin: auto;
        }

        .item {
            list-style: circle;
        }
    </style>

    <section id="main-content">
        <section class="wrapper site-min-height">
            <br />
            <div class="panel-body">
                <asp:HiddenField ID="CustomerId" runat="server" />
                <asp:HiddenField ID="CustomerName" runat="server" />
                <asp:HiddenField ID="ProjectId" runat="server" />

                <% 
                    var hCustomerId = CustomerId.Value;
                   // var selectSpecsTabNav = "Select&" + hCustomerId;
                %>

                <div class="tab-content">
                    <div class="tab-pane fade in active" id="EditDelete">

                        <asp:Panel ID="Panel_Items" runat="server" CssClass="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="title">Manage Bid Proposal: <asp:Label runat="server" ID="CustomerFullName" Value=""/></h4>
                            </div>
                           
                            <%-- Tabs --%>
                            <div class="panel-body">
                                <ul class="nav nav-tabs">
                                    <li id="SelectTab">
                                        <a href="#Select" data-toggle="tab"">Select Specs
                                            </a>
                                    </li>
                                    <li id="ShoppingTab">
                                        <a href="#Shopping" data-toggle="tab"">Bid Proposal
                                            </a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div class="tab-pane fade in" id="Select">
                                        <br />
                                        <asp:TextBox runat="server" TextMode="Search" placeholder="Enter any detail" ID="search" Width="50%" />
                                        <br />
                                        <br />
                                        <div class="table-responsive">
                                            <asp:GridView ID="GridView_Items" runat="server" CssClass="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowEditing="GridView_Items_RowEditing" OnSelectedIndexChanged="Selected">
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True" />
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Category" HeaderText="Category" ItemStyle-Width="45%">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Subcategories" HeaderText="Subcategory">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" 
                                                SelectCommand="SELECT [Category], STRING_AGG(nullif([Subcategory],''), ', ') WITHIN GROUP (ORDER BY [Subcategory]) AS Subcategories FROM (select distinct [Subcategory], [Category] FROM [PriceBook]) x GROUP BY [Category]"></asp:SqlDataSource>
                                        </div>
                                    </div>

                                    <%-- Shopping Tab Content --%>
                                    <div class="tab-pane fade in" id="Shopping">
                                        <br />

                                        <div>
                                            <%-- Project Name / Description --%>
                                            <div style="width: 50%; float: left">
                                                <%--<p>
                                                    <asp:Label ID="label2" AssociatedControlID="CustomerFullName" Text="Customer Name: " runat="server" CssClass="labeldisplay" />
                                                    <asp:TextBox ID="CustomerFullName" runat="server" CssClass="textboxdisplay" ReadOnly="true"></asp:TextBox>
                                                </p>--%>

                                                <p>
                                                    <asp:Label ID="label" AssociatedControlID="Project_Name" Text="Project Name: " runat="server" CssClass="labeldisplay" />
                                                    <asp:TextBox ID="Project_Name" runat="server" CssClass="textboxdisplay" ReadOnly="true"></asp:TextBox>
                                                </p>

                                                <p>
                                                    <asp:Label ID="label1" AssociatedControlID="Project_Desc" Text="Project Description: " runat="server" CssClass="labeldisplay" />
                                                    <asp:TextBox ID="Project_Desc" runat="server" CssClass="textboxdisplay" ReadOnly="true"></asp:TextBox>
                                                </p>
                                            </div>

                                            <div style="float: right">
                                                <asp:Button Text="Save Changes" OnClick="Save" runat="server" BackColor="#ffeb3b" ForeColor="Black" Width="190px" Height="40px" />
                                                <br />
                                                <br />
                                                <asp:Button Text="Preview" runat="server" BackColor="#987dc7" ForeColor="White" Width="190px" Height="40px" />
                                            </div>
                                        </div>
                                        <div style="width: 100%">
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />

                                            <%-- Pool Engineering --%>
                                            <asp:Panel runat="server" BorderStyle="Double" BorderColor="Blue" CssClass="inclusion" ID="ezinc">
                                                <br />
                                                <br />
                                                <h3 style="text-align: center"><span style="color: blue"><b><u>"EZ FLOW POOL"&trade; INCLUDES:</u></b></span></h3>
                                                <br />
                                                <ul style="font-size: large;">
                                                    <li class="item"><b>Pool Engineering</b></li>
                                                    <li class="item"><span style="color: #C00000"><b><u>Initial Survey</u></b></span> with Pool design on it <b>(Standard Lot Size Only)</b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>Final Survey</u></span> (Standard Lot Size Only)</b></li>
                                                    <li class="item"><b><span style="color: blue">Building Permits</span></b></li>
                                                    <li class="item"><b><span style="color: blue"><span style="color: #C00000"><u>80</u></span> Perimeter Ft. – <span style="color: #C00000"><u>375</u></span> Surface Sq. Ft. <span style="color: #C00000"><u>735</u></span> Total Sq. Ft.</span></b></li>
                                                    <li class="item"><span style="color: #C00000"><u><b>3’</b></u></span> to <b><span style="color: #C00000"><u>5’</u></span> <span style="color: blue">Deep</span></b></li>
                                                    <li class="item"><b>Strip Sod, Form and Layout Pool</b></li>
                                                    <li class="item"><b>Excavate and Haul dirt (Unless fill is needed to stay on-site)</b></li>
                                                    <li class="item"><b>De-water hole</b> during excavation*</li>
                                                    <li class="item"><b>Cap sprinklers</b> (if needed)</li>
                                                    <li class="item"><b>Orange Safety fence</b> around pool during construction</li>
                                                    <li class="item"><b>On-site Dumpster</b> throughout project (if will fit and/or applicable)</li>
                                                    <li class="item"><b>Progress report Emails or Phone calls <u>EVERY week</u></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>10” o. c.</u></span> <span style="color: blue">Steel Reinforcement Cage</span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>6”</u></span> <span style="color: blue">Walls</span> / 6” Floors (<span style="color: #C00000"><u>8” Bond Beam</u></span> <span style="color: blue">if Brick Copings are selected</span>)</b></li>
                                                    <li class="item"><b>Up to 10 Tons of rock</b> under pool foundation</li>
                                                    <li class="item"><b>Under-pool Drain line</b></li>
                                                    <li class="item"><b><span style="color: blue"><span style="color: #C00000"><u>1.5</u></span> HP / <span style="color: #C00000"><u>Two Speed Pump</u></span> Mfr: Hayward / Model: <span style="color: #C00000"><u>Super 2</u></span></span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>4820</u></span> Size <span style="color: #C00000"><u>D.E. Filter</u></span></b> with <b>50’ Backwash Hose <span style="color: blue">Mfr:</span> <span style="color: #C00000"><u>Hayward</u></span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>Pour</u></span> 3.5’ x 8’ <span style="color: blue">Equipment Pad</span></b></li>
                                                    <li class="item"><b>MDX <span style="color: #C00000"><u>Debris Removal</u></span> <span style="color: blue">Main Drain</span> and Side wall drain</b></li>
                                                    <li class="item"><b>Hydrostatic Relief Valve</b> in Drain</li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>1</u></span>) EZ Flow <span style="color: #C00000"><u>Power</u></span> <span style="color: blue">Skimmer</span></b></li>
                                                    <li class="item"><b>(1) Down jet</b> under power skimmer</li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>3</u></span>) 2” <span style="color: blue">Return lines</span> Adjustable Eyeballs fittings  <span style="color: #C00000">Color</span>: <span style="color: #C00000"><u>White</u></span></b></li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>4</u></span>) <span style="color: blue">EZ Flow Jets</span></b> in-floor (1.5” piping)</li>
                                                    <li class="item">Dedicated <b>1.5” <span style="color: #C00000"><u>Suction</u></span> Vacuum Line with Vac Lock</b></li>
                                                    <li class="item"><b>2” Plumbing</b> throughout pool system</li>
                                                    <li class="item"><b>Pressure Testing</b> of <b>All</b> plumbing lines</li>
                                                    <li class="item"><b>(4) Jandy Neverlube Valves -- 3-way</b> non-corrosive <b>(2” x 2.5”)</b></li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>90’</u></span>) Footer (<span style="color: #C00000"><u>8”</u></span> Wide)</b></li>
                                                    <li class="item"><b>Termite Treatment</b></li>
                                                    <li class="item"><b>Water Pack Soil</b> around shell and under deck to minimize settling</li>
                                                    <li class="item"><b>Tamper Soil</b> in deck area for better compaction before pouring deck</li>
                                                    <li class="item"><b><span style="color: #C00000"><u>700</u></span> Sq. Ft. <span style="color: #C00000"><u>Acrylic and Texture</u></span></b> over <b><span style="color: #C00000"><u>Cantilever Concrete</u></span> <span style="color: blue">Deck</span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>80</u></span> Ln. ft. <span style="color: #C00000"><u>Cantilever Concrete Coping</u></span></b> around pool perimeter</li>
                                                    <li class="item"><b>Grounding / Bond</b> Pool, Deck, Equipment and Screen (if applicable)</li>
                                                    <li class="item"><b><span style="color: #C00000"><u>50</u></span> L.F. of <span style="color: #C00000"><u>1.5”</u></span> <span style="color: #C00000">Deco Drain</span></b></li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>3</u></span>) <span style="color: blue">Shallow end Steps</span> (<span style="color: #C00000"><u>20 L.F.</u></span>)</b></li>
                                                    <li class="item"><b>Waterproof Tile Line</b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>80</u></span> L.F. 6” x 6” <span style="color: #C00000"><u>Standard</u></span> <span style="color: blue">Waterline Tile</span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>3” x 3”</u></span> <span style="color: blue">Tile inserts</span></b> on <b><span style="color: #C00000"><u>Steps and Benches</u></span></b> and Swim-out</li>
                                                    <li class="item"><b>1.5’ wide x <span style="color: #C00000"><u>5’</u></span> long <span style="color: blue">Swim-out</span></b> bench in deep end</li>
                                                    <li class="item"><b><span style="color: #C00000"><u>Aqua Pro Plus</u></span> (<span style="color: #C00000"><u>Salt unit</u></span> with <u>40,000 gallon</u> cell and Sub Panel)</b></li>
                                                    <li class="item"><b>Up to 100’ of Normal Electric Hook-up</b></li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>2</u></span>) LED <span style="color: #C00000"><u>Color</u></span> <span style="color: blue">Lights</span> (up to 100’ Cords)</b></li>
                                                    <li class="item"><b>(1) <span style="color: #C00000"><u>Light Switch</u></span> or Basic Remote Inside House</b></li>
                                                    <li class="item"><b><u>735</u> Sq. Ft. <span style="color: #C00000"><u>Exposed Aggregate</u></span> <span style="color: blue">Interior Surface</span> (White-based)</b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>Pre-Filter water fill-up</u></span> (Sock type</b> filter only)</li>
                                                    <li class="item"><b>Test and Balance</b> water (Initial <b>Start up</b> with Chemicals)</li>
                                                    <li class="item"><b>Cleaning Equipment</b> (Pole, Vacuum head and Hose, Net, Testing kit, Discharge hose, Brush, Thermometer)</li>
                                                    <li class="item"><b>Remove</b> all excess <b>Dirt & Complete Clean Up</b></li>
                                                    <li class="item"><b>Final Grade yard to</b> prepare for sod (<b>Note:</b> some hand work will be needed BY OWNER to feather in sod)</li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>6</u></span>) <span style="color: blue">Alarms</span> for <span style="color: #C00000"><u>Windows / Doors</u></span> or (<span style="color: #C00000"><u>1</u></span>) <span style="color: #C00000"><u>Poolside</u></span> <span style="color: blue">Alarm</span> by Code</b></li>
                                                    <li class="item"><b>Pool School Instruction</b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>3-month</u></span> <span style="color: #C00000">Pool Service</span> (<span style="color: #C00000"><u>1 Month Service</u></span> for jobs <span style="color: #C00000">over 35 min.</span> away)</b></li>
                                                    <li class="item"><b>FINAL INSPECTIONS</b></li>
                                                </ul>
                                                <br />
                                                <br />
                                            </asp:Panel>

                                            <%-- Pool Includes Detail --%>
                                            <asp:Panel runat="server" BorderStyle="Double" BorderColor="Blue" CssClass="inclusion" ID="geninc" Visible="false">
                                                <br />
                                                <br />
                                                <h3 style="text-align: center"><span style="color: blue"><b><u>"GENESIS POOL" INCLUDES:</u></b></span></h3>
                                                <br />
                                                <ul style="font-size: large;">
                                                    <li class="item"><b>Pool Engineering</b></li>
                                                    <li class="item"><span style="color: #C00000"><b><u>Initial Survey</u></b></span> with Pool design on it <b>(Standard Lot Size Only)</b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>Final Survey</u></span> (Standard Lot Size Only)</b></li>
                                                    <li class="item"><b><span style="color: blue">Building Permits</span></b></li>
                                                    <li class="item"><b><span style="color: blue"><span style="color: #C00000"><u>80</u></span> Perimeter Ft. – <span style="color: #C00000"><u>375</u></span> Surface Sq. Ft. <span style="color: #C00000"><u>735</u></span> Total Sq. Ft.</span></b></li>
                                                    <li class="item"><span style="color: #C00000"><u><b>3’</b></u></span> to <b><span style="color: #C00000"><u>5’</u></span> <span style="color: blue">Deep</span></b></li>
                                                    <li class="item"><b>Strip Sod, Form and Layout Pool</b></li>
                                                    <li class="item"><b>Excavate and Haul dirt (Unless fill is needed to stay on-site)</b></li>
                                                    <li class="item"><b>De-water hole</b> during excavation*</li>
                                                    <li class="item"><b>Cap sprinklers</b> (if needed)</li>
                                                    <li class="item"><b>Orange Safety fence</b> around pool during construction</li>
                                                    <li class="item"><b>On-site Dumpster</b> throughout project (if will fit and/or applicable)</li>
                                                    <li class="item"><b>Progress report Emails or Phone calls <u>EVERY week</u></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>10” o. c.</u></span> <span style="color: blue">Steel Reinforcement Cage</span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>6”</u></span> <span style="color: blue">Walls</span> / 6” Floors (<span style="color: #C00000"><u>8” Bond Beam</u></span> <span style="color: blue">if Brick Copings are selected</span>)</b></li>
                                                    <li class="item"><b>Up to 10 Tons of rock</b> under pool foundation</li>
                                                    <li class="item"><b>Under-pool Drain line</b></li>
                                                    <li class="item"><b><span style="color: blue"><span style="color: #C00000"><u>3/4</u></span> HP / <span style="color: #C00000"><u>Single Spd</u></span> Mfr: <span style="color: #C00000"><u>Hayward</u></span> / Model: <span style="color: #C00000"><u>Tristar</u></span></span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>120</u></span> <span style="color: blue">Size</span> <span style="color: #C00000"><u>Cartridge Filtration</u></span> System <span style="color: blue">Mfr:</span> <span style="color: #C00000"><u>Hayward</u></span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>Hunk Lite</u></span> <span style="color: blue">Equipment Pad</span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>Dual</u></span> <span style="color: blue">Main Drain</span> System</b></li>
                                                    <li class="item"><b>Hydrostatic Relief Valve</b> in Main Drain</li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>1</u></span>) Deluxe Flow <span style="color: #C00000"><u>Standard</u></span> <span style="color: blue">Skimmer</span></b></li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>3</u></span>) <span style="color: blue">Adjustable Eyeballs fittings / Return Lines</span> <b>Color</b>: <span style="color: #C00000"><u>White</u></span></b></li>
                                                    <li class="item">Dedicated <b>1.5” <span style="color: #C00000"><u>Suction</u></span> Vacuum Line with Vac Lock</b></li>
                                                    <li class="item"><b>2” Plumbing</b> throughout pool system</li>
                                                    <li class="item"><b>Pressure Testing</b> of <b>All</b> plumbing lines</li>
                                                    <li class="item"><b>(3) Valves</b> for pipe flow control</li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>90’</u></span>) Footer (<span style="color: #C00000"><u>8”</u></span> Wide)</b></li>
                                                    <li class="item"><b>Termite Treatment</b></li>
                                                    <li class="item"><b>Water Pack Soil</b> around shell and under deck to minimize settling</li>
                                                    <li class="item"><b>Tamper Soil</b> in deck area for better compaction before pouring deck</li>
                                                    <li class="item"><b><span style="color: #C00000"><u>700</u></span> Sq. Ft. <span style="color: #C00000"><u>Acrylic and Texture</u></span></b> over <b><span style="color: #C00000"><u>Cantilever Concrete</u></span> <span style="color: blue">Deck</span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>80</u></span> Ln. ft. <span style="color: #C00000"><u>Cantilever Concrete Coping</u></span></b> around pool perimeter</li>
                                                    <li class="item"><b>Grounding / Bond</b> Pool, Deck, Equipment and Screen (if applicable)</li>
                                                    <li class="item"><b><span style="color: #C00000"><u>50</u></span> L.F. of <span style="color: #C00000"><u>1.5”</u></span> <span style="color: #C00000">Deco Drain</span></b></li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>3</u></span>) <span style="color: blue">Shallow end Steps</span> (<span style="color: #C00000"><u>15 L.F.</u></span>)</b></li>
                                                    <li class="item"><b>Waterproof Tile Line</b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>80</u></span> L.F. 6” x 6” <span style="color: #C00000"><u>Standard</u></span> <span style="color: blue">Waterline Tile</span></b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>3” x 3”</u></span> <span style="color: blue">Tile inserts</span></b> on <b><span style="color: #C00000"><u>Steps and Benches</u></span></b> and Swim-out</li>
                                                    <li class="item"><b>1.5’ wide x <span style="color: #C00000"><u>4’</u></span> long <span style="color: blue">Swim-out</span></b> bench in deep end</li>
                                                    <li class="item"><b><span style="color: #C00000"><u>2 Speed Timeclock</u></span></b></li>
                                                    <li class="item"><b>Up to 100’ of Normal Electric Hook-up</b></li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>1</u></span>) LED <span style="color: #C00000"><u>White</u></span> <span style="color: blue">Light</span> (up to 100’ Cords)</b></li>
                                                    <li class="item"><b>(1) <span style="color: #C00000"><u>Light Switch</u></span> or Basic Remote Inside House</b></li>
                                                    <li class="item"><b><u>735</u> Sq. Ft. <span style="color: #C00000"><u>Exposed Aggregate</u></span> <span style="color: blue">Interior Surface</span> (White-based)</b></li>
                                                    <li class="item"><b><span style="color: #C00000"><u>Pre-Filter water fill-up</u></span> (Sock type</b> filter only)</li>
                                                    <li class="item"><b>Test and Balance</b> water (Initial <b>Start up</b> with Chemicals)</li>
                                                    <li class="item"><b>Cleaning Equipment</b> (Pole, Vacuum head and Hose, Net, Testing kit, Discharge hose, Brush, Thermometer)</li>
                                                    <li class="item"><b>Remove</b> all excess <b>Dirt & Complete Clean Up</b></li>
                                                    <li class="item"><b>Final Grade yard to</b> prepare for sod (<b>Note:</b> some hand work will be needed BY OWNER to feather in sod)</li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>6</u></span>) <span style="color: blue">Alarms</span> for <span style="color: #C00000"><u>Windows / Doors</u></span> or (<span style="color: #C00000"><u>1</u></span>) <span style="color: #C00000"><u>Poolside</u></span> <span style="color: blue">Alarm</span> by Code</b></li>
                                                    <li class="item"><b>Pool School Instruction</b></li>
                                                    <li class="item"><b>(<span style="color: #C00000"><u>1</u></span>) Month <span style="color: #C00000">Pool Service</span></b></li>
                                                    <li class="item"><b>FINAL INSPECTIONS</b></li>
                                                </ul>
                                                <br />
                                                <br />
                                            </asp:Panel>

                                            <div style="width: 100%" id="optional" runat="server">
                                                <br />
                                                <br />
                                                <br />
                                                <br />
                                                <br />
                                                <h4>Selected Optional Items
                                                </h4>
                                                <div class="table-responsive">
                                                    <asp:GridView ID="GridView2" runat="server" CssClass="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" OnSelectedIndexChanged="Selected">
                                                        <Columns>
                                                            <asp:CommandField ShowDeleteButton="true" />
                                                            <asp:TemplateField HeaderText="Optional" ItemStyle-Width="2%" ItemStyle-CssClass="centered">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox runat="server" CssClass="centered" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Status">
                                                                <ControlStyle CssClass="form-control" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Quantity" ItemStyle-Width="5%">
                                                                <ItemTemplate>
                                                                    <asp:TextBox TextMode="Number" runat="server" Width="100%" Text="0" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Item">
                                                                <ControlStyle CssClass="form-control" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Description" ItemStyle-Width="20%">
                                                                <ItemTemplate>
                                                                    <asp:TextBox runat="server" Width="100%" Text="" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Unit">
                                                                <ControlStyle CssClass="form-control" />
                                                            </asp:BoundField>
                                                            <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Price">
                                                                <ControlStyle CssClass="form-control" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Overage/Underage" ItemStyle-Width="5%">
                                                                <ItemTemplate>
                                                                    <asp:TextBox TextMode="Number" runat="server" Width="100%" Text="0" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Locked Time">
                                                                <ControlStyle CssClass="form-control" />
                                                            </asp:BoundField>
                                                            <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Total Price Change">
                                                                <ControlStyle CssClass="form-control" />
                                                            </asp:BoundField>
                                                            <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Subtotal">
                                                                <ControlStyle CssClass="form-control" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                                <div style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                    <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                        <asp:Label runat="server" Font-Size="Large">Subtotal Overage/Underage: </asp:Label>
                                                        <asp:TextBox runat="server" Height="30px" ID="subo2" ReadOnly="true" />
                                                    </p>
                                                    <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                        <asp:Label runat="server" Font-Size="Large">Subtotal: </asp:Label>
                                                        <asp:TextBox runat="server" ID="sub2" Height="30px" ReadOnly="true" />
                                                    </p>
                                                    <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                        <asp:Label runat="server" Font-Size="X-Large" Font-Bold="true">Total: </asp:Label>
                                                        <asp:TextBox runat="server" ID="tot2" Height="40px" ReadOnly="true" />
                                                    </p>
                                                    <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                        <asp:Label runat="server" Font-Size="X-Large" Font-Bold="true">Total (Once Lock Is Lifted): </asp:Label>
                                                        <asp:TextBox runat="server" ID="lift2" Height="40px" ReadOnly="true" />
                                                    </p>
                                                </div>
                                            </div>
                                            <br />
                                            <br />

                                            <%-- Project Items Grid --%>
                                            <h4>Selected Items
                                                </h4>
                                            <div class="table-responsive">
                                                <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-bordered table-hover" OnRowDeleting="Deleted" AllowSorting="True" AutoGenerateColumns="False" OnSelectedIndexChanged="Selected">
                                                    <Columns>
                                                        <asp:CommandField ShowDeleteButton="true" />
                                                        <asp:TemplateField HeaderText="Optional" ItemStyle-Width="2%" ItemStyle-CssClass="centered">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" CssClass="centered" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Status">
                                                            <ControlStyle CssClass="form-control" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Quantity" ItemStyle-Width="5%">
                                                            <ItemTemplate>
                                                                <asp:TextBox TextMode="Number" runat="server" Width="100%" Text="0" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Item">
                                                            <ControlStyle CssClass="form-control" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Description" ItemStyle-Width="20%">
                                                            <ItemTemplate>
                                                                <asp:TextBox runat="server" Width="100%" Text="" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Unit">
                                                            <ControlStyle CssClass="form-control" />
                                                        </asp:BoundField>
                                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Price">
                                                            <ControlStyle CssClass="form-control" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Overage/Underage" ItemStyle-Width="5%">
                                                            <ItemTemplate>
                                                                <asp:TextBox TextMode="Number" runat="server" Width="100%" Text="0" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Locked Time">
                                                            <ControlStyle CssClass="form-control" />
                                                        </asp:BoundField>
                                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Total Price Change">
                                                            <ControlStyle CssClass="form-control" />
                                                        </asp:BoundField>
                                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Subtotal">
                                                            <ControlStyle CssClass="form-control" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            
                                            <%-- Grid Totals Section --%>
                                            <div style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                    <asp:Label runat="server" Font-Size="Large">Subtotal Overage/Underage: </asp:Label>
                                                    <asp:TextBox runat="server" ID="subo1" Height="30px" ReadOnly="true" />
                                                </p>
                                                <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                    <asp:Label runat="server" Font-Size="Large">Commissions: </asp:Label>
                                                    <asp:TextBox runat="server" ID="com1" Height="30px" ReadOnly="true" />
                                                </p>
                                                <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                    <asp:Label runat="server" Font-Size="Large">Subtotal: </asp:Label>
                                                    <asp:TextBox runat="server" ID="sub1" Height="30px" ReadOnly="true" />
                                                </p>
                                                <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                    <asp:Label runat="server" Font-Size="X-Large" Font-Bold="true">Total: </asp:Label>
                                                    <asp:TextBox runat="server" ID="tot1" Height="40px" ReadOnly="true" />
                                                </p>
                                                <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                    <asp:Label runat="server" Font-Size="X-Large" Font-Bold="true">Total (Once Lock Is Lifted): </asp:Label>
                                                    <asp:TextBox runat="server" ID="lift1" Height="40px" ReadOnly="true" />
                                                </p>
                                                <p style="text-align: right; margin: 0px; border: 0px; padding: 0px;">
                                                    <asp:Label runat="server" Font-Size="X-Large" Font-Bold="true">Grand Total: </asp:Label>
                                                    <asp:TextBox runat="server" ID="grand" Height="40px" ReadOnly="true" />
                                                </p>
                                            </div>
                                        </div>

                                        <%-- Pool Dimensions --%>
                                        <div>
                                            <p>
                                                <asp:Label runat="server" Font-Size="Large">Pool Length (ft.-in.):</asp:Label>
                                                <asp:TextBox runat="server" TextMode="Number" ID="LF" Width="45px" />
                                                <asp:TextBox runat="server" TextMode="Number" ID="LI" Width="45px" />
                                            </p>
                                            <p>
                                                <asp:Label runat="server" Font-Size="Large">Pool Width (ft.-in.):</asp:Label>
                                                <asp:TextBox runat="server" TextMode="Number" ID="WF" Width="45px" />
                                                <asp:TextBox runat="server" TextMode="Number" ID="WI" Width="45px" />
                                            </p>
                                            <p>
                                                <asp:Label runat="server" Font-Size="Large" ID="SOPLabel" Visible="false">Spa Outside Perimeter:</asp:Label>
                                                <asp:TextBox runat="server" TextMode="Number" ID="SOP" Visible="false" Width="45px" />
                                            </p>
                                        </div>
                                        <br />
                                        <br />

                                        <%-- Homeowner Responsibilities --%>
                                        <asp:Label Font-Bold="true" runat="server" Font-Size="Large">Homeowner Responsibilities</asp:Label>
                                        <div style="flex-direction: row; display: flex;">
                                            <div style="flex-direction: column; width: 50%;">
                                                <asp:CheckBox runat="server" ID="landscaping" Text="&nbsp;Landscaping, Irrigation, Sod and /or Hay & Seed" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Access" Text="&nbsp;Get Access letter signed by neighbor" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Gas" Text="&nbsp;Gas Lines, Gas Hook-Ups" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Equipment" Text="&nbsp;Equipment Wall or Retaining Walls" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Stucco" Text="&nbsp;Stucco & Painting" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Homeowner" Text="&nbsp;Homeowner Supplies Mosaic Tiles" />
                                            </div>
                                            <div style="flex-direction: column; width: 50%;">
                                                <asp:CheckBox runat="server" ID="Additional" Text="&nbsp;Additional Fill" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Provide" Text="&nbsp;Provide On-site Dumpster throughout project" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Screen" Text="&nbsp;Screen or Fence By code" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Final" Text="&nbsp;Final Grade and Prepare yard for sod" />
                                                <br />
                                                <asp:CheckBox runat="server" ID="Supply" Text="&nbsp;Supply Initial Survey and Final Survey" />
                                                <br />
                                                <p>
                                                    <asp:CheckBox runat="server" ID="Other" Text="" />
                                                    <asp:TextBox runat="server" ID="OtherText" />
                                                </p>
                                            </div>
                                        </div>
                                        <div style="float: right">
                                            <asp:Button Text="Save Changes" OnClick="Save" runat="server" BackColor="#ffeb3b" ForeColor="Black" Width="190px" Height="40px" />
                                            <br />
                                            <br />
                                            <asp:Button Text="Preview" runat="server" BackColor="#987dc7" ForeColor="White" Width="190px" Height="40px" />
                                        </div>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />

                                        <%-- Form Action Buttons --%>
                                        <div style="width: 100%; text-align: center">
                                            <asp:Button Text="Lock In This Bid Proposal and Print" runat="server" Height="40px" Width="33%" OnClick="GenerateBid" />
                                            <br />
                                            <br />
                                            <asp:Button Text="To Contract" runat="server" Height="40px" Width="50%" OnClick="GenerateContract" />
                                        </div>
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
            if (window.location.href.split('?').length > 1 && window.location.href.split('?')[1].split('&').length > 0) {
                window.location.href = "CPriceBook?" + window.location.href.split('?')[1].split('&')[0] + "&" + which;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

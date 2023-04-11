<%@ Page MaintainScrollPositionOnPostback="true" Title="Finalized" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="FinalizedShopping.aspx.cs" Inherits="WatersidePortal.FinalizedShopping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
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
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="EditDelete">

                        <asp:Panel ID="Panel_Items" runat="server" CssClass="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="title">Finalized Shopping Cart
                                </h4>
                            </div>
                            <div class="panel-body">
                                <br />
                                <div style="width: 50%; float: left">
                                    <p>
                                        <asp:Label runat="server" Text="Bid Proposal, Version #1:" ID="Project_Name" Font-Size="Large" />
                                    </p>
                                </div>
                                <div style="width: 100%">

                                    <div style="width: 100%" runat="server">
                                        <br />
                                        <br />
                                        <div class="table-responsive">
                                            <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" OnSelectedIndexChanged="Selected">
                                                <Columns>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Category" ItemStyle-Width="20%">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Quantity" ItemStyle-Width="5%">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Item Name" ItemStyle-Width="20%">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Description">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Price" ItemStyle-Width="5%">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Overage / Underage" ItemStyle-Width="5%" HeaderStyle-Font-Size="Small">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Unit" ItemStyle-Width="5%">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                    <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Subtotal" ItemStyle-Width="5%">
                                                        <ControlStyle CssClass="form-control" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div style="text-align: right; margin: 0px; border: 0px; padding: 0px; width: 250px; float: right; border-style: solid;">
                                            <asp:Label runat="server" Text="Overage / Underage: " ID="OverageText" Font-Size="Larger" />
                                            <br />
                                            <asp:Label runat="server" Text="Commission: " ID="CommissionText" Font-Size="Larger" />
                                            <br />
                                            <asp:Label runat="server" Font-Bold="true" Text="Total: " ID="TotalText" Font-Size="Larger" />
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <br />
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
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <div style="width: 100%; text-align: center">
                                    <asp:Button Text="Lock In This Bid Proposal and Print" runat="server" Height="40px" Width="33%" OnClick="GenerateBid" />
                                    <br />
                                    <br />
                                    <asp:Button Text="To Contract" runat="server" Height="40px" Width="50%" OnClick="GenerateContract" />
                                </div>
                            </div>
                        </asp:Panel>
                        <br />
                    </div>
                </div>

            </div>




        </section>
    </section>
</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

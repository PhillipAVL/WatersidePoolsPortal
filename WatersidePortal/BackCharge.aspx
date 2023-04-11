<%@ Page MaintainScrollPositionOnPostback="true" Title="BackCharge" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayoutAdmin.Master" AutoEventWireup="true" CodeBehind="BackCharge.aspx.cs" Inherits="WatersidePortal.BackCharge" %>
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
                                        Back Charge
                                    </h4>
                                </div>
                                <div class="panel-body">
                                    <div style="width: 50%;">
                                        <p>
                                            Salesperson / Subcontractor: 
                                            <asp:DropDownList runat="server" ID="salespeople">
                                                <asp:ListItem Text="Select" />
                                                <asp:ListItem Text="Salesperson A" />
                                                <asp:ListItem Text="Salesperson B" />
                                                <asp:ListItem Text="Other" />
                                            </asp:DropDownList>
                                        </p>
                                        <p>
                                            Amount:
                                            <asp:TextBox TextMode="Number" runat="server" />
                                        </p>
                                        <div style="display: flex; flex-direction:row;">
                                            Reason:
                                            <asp:TextBox TextMode="MultiLine" runat="server" width="100%" Height="100px"/>
                                        </div>
                                        <br />
                                        <asp:Button ForeColor="#FFFFFF" BackColor="#f44336" runat="server" Width="110" Height="40" Text="Cancel" />
                                        <asp:Button BackColor="#03a9f4" ForeColor="#FFFFFF" runat="server" Width="110" Height="40" Text="Submit" style="float: right;" />
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
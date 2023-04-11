<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="Commission.aspx.cs" Inherits="WatersidePortal.Staff.Comission" %>
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
                        COMMISSION BREAKDOWN
                    </h4>
                </div>
                <div class="panel-body">
            <asp:Panel ID="Panel_Commission" runat="server">        
            <br />
            Homeowner <asp:TextBox ID="TextBox_Homeowner" runat="server" CssClass="form-control control-medium"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Homeowner" ErrorMessage="Required" />
            <br />
            Breakdown Total <asp:TextBox ID="TextBox_BreakdownTotal" runat="server" CssClass="form-control control-medium"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_BreakdownTotal" ErrorMessage="Required" />
            <br />
            Contract Price <asp:TextBox ID="TextBox_ContractPrice" runat="server" CssClass="form-control control-medium"></asp:TextBox> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox_ContractPrice" ErrorMessage="Required" />    
            <br />
            Overage (+) <asp:TextBox ID="TextBox_Overage" runat="server" CssClass="form-control control-medium"></asp:TextBox> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox_Overage" ErrorMessage="Required" />
            <br />
            Discount (-) <asp:TextBox ID="TextBox_Discount" runat="server" CssClass="form-control control-medium"></asp:TextBox> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox_Discount" ErrorMessage="Required" />
   
                <br />
                Comm. % <asp:TextBox ID="TextBox_CommissionPercent" runat="server" CssClass="form-control control-medium"></asp:TextBox> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox_CommissionPercent" ErrorMessage="Required" />
                <br />
                Split Amount <asp:TextBox ID="TextBox_SplitAmount" runat="server" CssClass="form-control control-medium"></asp:TextBox> 
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox_SplitAmount" ErrorMessage="Required" />

                <br />

                
              Salesman <asp:TextBox ID="TextBox_Salesman" runat="server" CssClass="form-control control-medium"></asp:TextBox> 
                                                    <asp:RequiredFieldValidator id="RequiredFieldValidator8" ControlToValidate="TextBox_Salesman" ErrorMessage="Required" runat="server"/>

                <br />

                <br />

            <asp:Button ID="Button_Calculate" runat="server" Text="Calculate" CssClass="btn btn-primary" OnClick="Button_Calculate_Click" />
            </asp:Panel>

                <asp:Panel ID="Panel_Results" runat="server" Visible="false">

    <h4>&nbsp;</h4>
                    <h4>&nbsp;</h4>
                    <h4>&nbsp;</h4>
                    <h4>BEFORE COMMISSION TOTAL </h4>
            <br />
            Before Comm. Total <asp:TextBox ID="TextBox_BeforeCommTotal" runat="server" CssClass="form-control control-medium" ReadOnly="True"></asp:TextBox> <br />
            <br />
    <h4>COMMISSION</h4>
            <br />
            Total Comm. <asp:TextBox ID="TextBox_TotalComission" runat="server" CssClass="form-control control-medium" ReadOnly="True"></asp:TextBox> <br />
            <br />
    <h4>OVERAGE / DISCOUNT</h4>
            <br />
            Overage Comm. <asp:TextBox ID="TextBox_OverageCommission" runat="server" CssClass="form-control control-medium" ReadOnly="True"></asp:TextBox> <br />
            Reduced Commission Total <asp:TextBox ID="TextBox_ReducedCommission" runat="server" CssClass="form-control control-medium" ReadOnly="True"></asp:TextBox> <br />
            <br />
    <h4>TOTAL COMMISSION</h4>
            <br />
            Total <asp:TextBox ID="TextBox_FinalTotal" runat="server" CssClass="form-control control-medium" ReadOnly="True"></asp:TextBox> <br />
            
                </asp:Panel>
                    </div>
            </div>

        </section>
    </section>

</asp:Content>
<asp:Content ID="JavaScriptCurretPage" ContentPlaceHolderID="JavaScriptPage" runat="server">
    <%--You can add your custom JavaScript for each page on this section.--%>
        <script>$("#Submit_Commission").addClass("active")</script>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WatersidePortal.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">
    <style type="text/css">
        .auto-style1 {
            font-size: x-large;
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentBody" runat="server">
    <section id="main-content">
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Label ID="Label_User" runat="server" Text="(Current User)"></asp:Label>
        <br />
        <br />
        <br />
        <strong><span class="auto-style1">Send Message<br />
        </span></strong>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Select Message Recip"></asp:Label>
        <%--<asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="UserName" DataValueField="UserName">
    </asp:CheckBoxList>--%>
        <strong>
            <asp:DropDownList ID="Recipient" runat="server" DataSourceID="SqlDataSource1" DataTextField="UserName" DataValueField="UserName">
            </asp:DropDownList>
        </strong>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [UserName] FROM [AspNetUsers]"></asp:SqlDataSource>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Message Body"></asp:Label>
        <br />
        <asp:TextBox ID="TextBox_Message" Width="50%" Height="100px" runat="server" TextMode="MultiLine"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button_SendMessage" runat="server" OnClick="Button_SendMessage_Click" Text="Send" />
        <br />
        <br />
        <br />
        <span class="auto-style1"><strong>Read</strong></span><strong><span class="auto-style1"> New Messages</span></strong><br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource_MyMessages" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="SenderId" HeaderText="Sender" HeaderStyle-Width="10%" SortExpression="SenderId" />
                <asp:BoundField DataField="MessageText" HeaderText="Message" HeaderStyle-Width="70%" SortExpression="MessageText" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource_MyMessages" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [SenderId], [MessageText], [Date] FROM [Messages] WHERE (([IsVisible] = @IsVisible) AND ([IsRead] = @IsRead) AND (RecipientId = @username))">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="IsVisible" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="IsRead" Type="Int32" />
                <asp:Parameter Name="username" Type="String" DefaultValue="Unknown" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="Button_MarkAsRead" runat="server" Text="Mark Selected Message as Read" />
        <br />
        <br />
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Jason's"></asp:Label>
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="UserName" DataValueField="UserName" AutoPostBack="true">
        </asp:DropDownList>
        <br />
        <br />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="SenderId" HeaderText="Sender" HeaderStyle-Width="16%" SortExpression="SenderId" />
                <asp:BoundField DataField="RecipientId" HeaderText="Recipient" HeaderStyle-Width="16%" SortExpression="RecipientId" />
                <asp:BoundField DataField="MessageText" HeaderText="MessageText" HeaderStyle-Width="60%" SortExpression="MessageText" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT [SenderId], [RecipientId], [MessageText], [Date] FROM [Messages] WHERE (([IsVisible] = @IsVisible) AND ([SenderId] = @SenderId) OR ([RecipientId] = @SenderId))">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="IsVisible" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList1" Name="SenderId" PropertyName="SelectedValue" Type="String" />
                <%-- <asp:ControlParameter ControlID="Label_User" Name="RecipientId" PropertyName="Text" Type="String" /> --%>
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

<%@ Page Title="About" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WatersidePortal.About" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentBody" runat="server">
        <section id="main-content">
        <section class="wrapper site-min-height">
    <h2><%: Title %>.</h2>
    <h3>Your application description page.</h3>
    <p>Use this area to provide additional information.<p>
            &nbsp;<p>
        
        <asp:SqlDataSource ID="CategoriesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT DISTINCT [Category], [Subcategory], [ItemID], [Item], [Description], [Unit], [CustomerPrice] FROM [PriceBookGenesis] ORDER BY [Category], [Subcategory]">
        </asp:SqlDataSource>


                        <p>
        
                            &nbsp;<p>
        

            <input type="button" class="expand" value="Expand All" />
            <input type="button" class="close" value="Close All" />
            
<asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="Grid"
DataKeyNames="ItemID" OnRowDataBound="OnRowDataBound">
<Columns>
    <asp:BoundField ItemStyle-Width="150px" DataField="Category" HeaderText="Category" />
    <asp:BoundField ItemStyle-Width="150px" DataField="Subcategory" HeaderText="Subcategory" />
    <asp:TemplateField>
        <ItemTemplate>
            <asp:Panel ID="pnlOrders" runat="server" >
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass = "ChildGrid">
                    <Columns>
                        <asp:BoundField ItemStyle-Width="150px" DataField="Item" HeaderText="Item" />
                        <asp:BoundField ItemStyle-Width="150px" DataField="CustomerPrice" HeaderText="Customer Price" />
                    </Columns>
                </asp:GridView>
            </asp:Panel>
            Quantity: <asp:TextBox ID="QuantityTextBox" runat="server"></asp:TextBox>
        </ItemTemplate>
    </asp:TemplateField>

</Columns>
    </asp:GridView>


                        &nbsp;<div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="title">
                                Categories</h4>
                            <h4>&nbsp;</h4>
                        </div>
                        <div class="panel-body">
                            <div class="panel-group" id="accordion">
                                <div class="panel panel-default">
                                    <asp:Repeater ID="CategoryRepeater" runat="server" DataSourceID="CategoriesSqlDataSource" >

                                    <ItemTemplate>
                                     
                                        <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                                <%#Eval("Category")%> <%#Eval("Subcategory")%>
                                            </a>
                                        </h4>
                                    </div>
                                        <div id="collapseOne" class="panel-collapse collapse ">
                                        <div class="panel-body">

                                            <asp:Repeater ID="Repeater1" runat="server" >
                                                <ItemTemplate>
                                                <div><h4><%#Eval("Item")%> </h4> <h5><%#Eval("Description")%></h5>
                                                    <h5>$<%#Eval("CustomerPrice")%><%#Eval("Unit")%></h5> <h5>Quantity: <asp:TextBox ID="TextBox" runat="server"></asp:TextBox></h5> <br />
                                                </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    
                                   </div>
                                   </ItemTemplate>                
                                

        </asp:Repeater>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>

        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
</p>

            </section>
            </section>
</asp:Content>

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sidebar.ascx.cs" Inherits="BlackFlib1.Shared.Sections.Sidebar" %>
<aside>
    <div id="sidebar"  class="nav-collapse ">
        <ul class="sidebar-menu" id="nav-accordion">
            <li>
                
            </li>
            <li class="mt">
                <a id="home" href="/default.aspx">
                    <i class="fa fa-home">
                    </i>
                    <span>
                        My Dashboard
                    </span>
                </a>
            </li>
            <li class="mt">
                <a id="forms" href="/Form.aspx">
                    <i class="fa fa-file">
                    </i>
                    <span>
                        Forms
                    </span>
                </a>
            </li>
            <li class="mt">
                <a id="customers" href="/Customers.aspx">
                    <i class="fa fa-user">
                    </i>
                    <span>
                        Customer Profiles
                    </span>
                </a>
            </li>
            <li class="mt">
                <a id="pricebook" href="/PriceBook.aspx">
                    <i class="fa fa-list-alt">
                    </i>
                    <span>
                        Price Book
                    </span>
                </a>
            </li>
            <li class="mt">
                <a id="backcharge" href="/BackCharge.aspx">
                    <i class="fa fa-list-alt">
                    </i>
                    <span>
                        Back Charge
                    </span>
                </a>
            </li>
            <li class="mt">
                <a id="Archived_Customers" href="/Staff/Commission.aspx" >
                    <i class=" fa fa-bar-chart-o">
                    </i>
                    <span>
                        Archived Customers
                    </span>
                </a>
            </li>
            <%--<li class="sub-menu">
                <a id="estimate" href="/PriceBook.aspx">
                    <i class="fa fa-user">
                    </i>
                    <span>
                        Price Book
                    </span>
                </a>
                <%-- <a id="estimate" href="javascript:;" >
                    <i class="fa fa-files-o">
                    </i>
                    <span>
                       Price Books
                    </span>
                </a>
                <ul class="sub">
                    <li>
                        <a id="Genesis" href="/Staff/PriceBookGenesis.aspx">
                            Genesis
                        </a>
                    </li>
                    <li>
                        <a id="EZ-Flow" href="/Staff/BidProposalEZ.aspx">
                            EZ-Flow 
                        </a>
                    </li>
                </ul> --%>
            <%--</li> --%>
            <li class="mt">
                <a id="Submit_Commission" href="/Staff/Commission.aspx" >
                    <i class=" fa fa-bar-chart-o">
                    </i>
                    <span>
                        Comission Breakdown
                    </span>
                </a>
            </li>
            <li class="mt">
                <a id="Master_Bids" href="/Staff/Commission.aspx" >
                    <i class=" fa fa-bar-chart-o">
                    </i>
                    <span>
                        Manage Master Bids
                    </span>
                </a>
            </li>

        </ul>
    </div>
</aside>
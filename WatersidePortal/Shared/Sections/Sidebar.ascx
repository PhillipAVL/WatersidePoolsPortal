<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sidebar.ascx.cs" Inherits="BlackFlib1.Shared.Sections.Sidebar" %>

<aside>
    <div id="sidebar"  class="nav-collapse ">
        <ul class="sidebar-menu" id="nav-accordion">
            <li></li>
>
            <%-- Home --%>
            <li class="mt">
                <a id="home" href="/default.aspx">
                    <i class="fa fa-home">
                    </i>
                    <span>
                        My Dashboard
                    </span>
                </a>
            </li>

            <%-- Forms --%>
            <li class="mt">
                <a id="forms" href="/Form.aspx">
                    <i class="fa fa-file">
                    </i>
                    <span>
                        Forms
                    </span>
                </a>
            </li>

            <%-- Customer Management --%>
            <li class="mt">
                <a id="customers" href="/Customers.aspx">
                    <i class="fa fa-user">
                    </i>
                    <span>
                        Customer Management
                    </span>
                </a>
            </li>

            <%-- User Management --%>
            <li class="mt">
                <a id="User-Management" href="javascript:;">
                    <i class="fa fa-user"></i>
                    <span>User Management
                    </span>
                </a>
                <ul class="sub">
                    <li>
                        <a id="Add-Staff" href="/Admin/Register.aspx">Add Staff
                        </a>
                    </li>
                    <li>
                        <a id="User-Locks" href="/Admin/Locks.aspx">User Locks
                        </a>
                    </li>
                    <li>
                        <a id="Reset-Passwords" href="/Admin/ResetPassword.aspx">Reset Passwords
                        </a>
                    </li>
                    <li>
                        <a id="Manage-Permissions" href="/Admin/Permissions.aspx">Manage Permissions
                        </a>
                    </li>
                </ul>
            </li>

            <%-- Price Book --%>
            <li class="mt">
                <a id="pricebook" href="/PriceBook.aspx">
                    <i class="fa fa-list-alt">
                    </i>
                    <span>
                        Price Book
                    </span>
                </a>
            </li>

            <%-- Back Charge --%>
            <li class="mt">
                <a id="backcharge" href="/BackCharge.aspx">
                    <i class="fa fa-list-alt">
                    </i>
                    <span>
                        Back Charge
                    </span>
                </a>
            </li>

            <%-- Archived Customers --%>
            <li class="mt">
                <a id="Archived_Customers" href="/ArchivedCustomers.aspx" >
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

            <%-- Commission Breakdown --%>
            <li class="mt">
                <a id="Submit_Commission" href="/Staff/Commission.aspx" >
                    <i class=" fa fa-bar-chart-o">
                    </i>
                    <span>
                        Commission Breakdown
                    </span>
                </a>
            </li>

            <%-- Manage Master Bids --%>
            <li class="mt">
                <a id="Master_Bids" href="/ManageMasters.aspx" >
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
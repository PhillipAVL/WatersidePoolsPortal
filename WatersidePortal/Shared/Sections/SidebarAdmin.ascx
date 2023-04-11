<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SidebarAdmin.ascx.cs" Inherits="BlackFlib1.Shared.Sections.Sidebar" %>
<aside>
    <div id="sidebar"  class="nav-collapse ">
        <ul class="sidebar-menu" id="nav-accordion">
            <li>
                
            </li>
            <li class="mt">
                <a href="/Admin/Default.aspx">
                    <i class="fa fa-home">
                    </i>
                    <span>
                        My Dashboard
                    </span>
                </a>
            </li>
            <li class="mt">
                <a href="/Form.aspx">
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
             <li class="sub-menu">
                <a id="User-Management" href="javascript:;" >
                    <i class="fa fa-user">
                    </i>
                    <span>
                       User Management
                    </span>
                </a>
                <ul class="sub">
                    <li>
                        <a id="Add-Staff" href="/Admin/Register.aspx">
                            Add Staff
                        </a>
                    </li>
                    <li>
                        <a id="User-Locks" href="/Admin/Locks.aspx">
                            User Locks
                        </a>
                    </li>
                    <li>
                        <a id="Reset-Passwords"href="/Admin/ResetPassword.aspx">
                            Reset Passwords
                        </a>
                    </li>
                    <li>
                        <a id="Manage-Permissions"href="/Admin/Permissions.aspx">
                            Manage Permissions
                        </a>
                    </li>
                </ul>
            </li>
            <%--            <li class="sub-menu">
                <a id="estimate" href="javascript:;" >
                    <i class="fa fa-files-o">
                    </i>
                    <span>
                       Pool Bid Proposals
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
                </ul>
            </li>--%>
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
            <%--<li class="sub-menu">
                <a href="javascript:;" >
                    <i class="fa fa-list-alt">
                    </i>
                    <span>
                        Price Book
                    </span>
                </a>
                <ul class="sub">
                    <li>
                        <a id="PB-EZ-Flow" href="/Admin/PriceBookEZ.aspx">
                            Edit Ez-Flow Pricebook
                        </a>
                    </li>
                    <li>
                        <a id="PB-Genesis" href="/Admin/PriceBookGenesis.aspx">
                            Edit Genesis Pricebook
                        </a>
                    </li>
                                        <li>
                        <a href="/Admin/PriceBookVendor.aspx">
                            Edit Renovation Pricebook
                        </a>
                    </li>
                    <li>
                        <a href="/Admin/PriceBookVendor.aspx">
                            Edit Artistry in Mosaic Pricebook
                        </a>
                    </li>
                    <li>
                        <a href="/Admin/PriceBookVendor.aspx">
                            Edit Custom Mosaic Pricebook
                        </a>
                    </li>
                    <li>
                        <a href="/Admin/PriceBookVendor.aspx">
                            Edit Travertine Pricebook
                        </a>
                    </li>
                    <li>
                        <a href="/Admin/PriceBookVendor.aspx">
                            Edit Vendor/COG Pricebook
                        </a>
                    </li>
                    <li>
                        <a href="/Admin/PriceBookVendor.aspx">
                            Edit Service/Repair Pricebook
                        </a>
                    </li>
                </ul>
            </li> --%>
            <li class="sub-menu">
                <a href="javascript:;" >
                    <i class="fa fa-files-o">
                    </i>
                    <span>
                       Pool Bid Proposals
                    </span>
                </a>
                <ul class="sub">
                    <li>
                        <a href="/Staff/PriceBookGenesis.aspx">
                            Genesis
                        </a>
                    </li>
                    <li>
                        <a href="/Staff/BidProposalEZ.aspx">
                            EZ-Flow 
                        </a>
                    </li>
                </ul>
            </li>



        </ul>
    </div>
</aside>
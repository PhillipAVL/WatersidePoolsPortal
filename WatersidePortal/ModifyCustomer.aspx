<%@ Page Title="" MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="ModifyCustomer.aspx.cs" Inherits="WatersidePortal.ModifyCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="StyleSheetPage" runat="server">

    <style type="text/css">
        .Grid, .Grid th, .Grid td {
            border: 1px solid #e0e0e0;
            text-align: center;
        }

        p {
            margin: 5px;
        }

        /* Fomratting form label-textbox layout */
        /*input[type="textbox"] {
            display: block;
            float: left;
            margin-right: 2px;
            width: 150px;
        }

        label {*/
        /*display: block;
            float: left;*/
        /*width: 150px;
        }*/

        /* Borderless table form form input */
        .table-borderless > tbody > tr > td,
        .table-borderless > tbody > tr > th,
        .table-borderless > tfoot > tr > td,
        .table-borderless > tfoot > tr > th,
        .table-borderless > thead > tr > td,
        .table-borderless > thead > tr > th {
            border: none;
            /*padding: 6px;*/
        }

        tdLeftIndent {
            padding-top: 0px;
            padding-bottom: 0px;
            padding-left: 20px;
        }

        textarea {
            resize: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <asp:HiddenField ID="TabName" runat="server" />
    <%-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>--%>
    <script type="text/javascript">
        /*$(function () {
            var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "Info";
            $('#Tabs a[href="#' + tabName + '"]').tab('show');
            $("#Tabs a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });
        });*/

        function tab(which) {
            //$("[id*=TabName]").val(which);
            if (window.location.href.split('?').length > 1 && window.location.href.split('?')[1].split('&').length > 0) {
                window.location.href = "ModifyCustomer?" + window.location.href.split('?')[1].split('&')[0] + "&" + which;
            }
        }
        function openInNewTab() {
            window.open('/Documents/Access Permission.pdf', '_blank');
        }
    </script>

    <section id="main-content">
        <section class="wrapper site-min-height">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <br />
                    <h4 class="title">Customer Management
                    </h4>
                </div>

                <div class="panel-body">
                    <asp:Label runat="server" ID="name" Font-Bold="true" Font-Size="Large"></asp:Label>
                    <br />
                    <br />

                    <%-- Tabs --%>
                    <div id="Tabs" role="tabpanel">
                        <ul runat="server" class="nav nav-tabs" id="tabs" onchange="tab">
                            <li id="InfoTab">
                                <a title="Info_Tab" runat="server" href="#Info" role="tab" data-toggle="tab" onclick="tab('Info');">Customer Information
                                </a>
                            </li>
                            <li id="CreateTab">
                                <a title="Create_Tab" role="tab" href="#Create" data-toggle="tab" onclick="tab('Create');">Create Bid Proposal
                                </a>
                            </li>
                            <li id="UploadTab">
                                <a title="Upload_Tab" href="#Upload" role="tab" data-toggle="tab" onclick="tab('Upload');">Upload Documents / Forms
                                </a>
                            </li>
                            <li id="PermittingTab">
                                <a title="Permitting_Tab" href="#Permitting" role="tab" data-toggle="tab" onclick="tab('Permitting');">Permitting
                                </a>
                            </li>
                            <li id="PacketTab">
                                <a title="Packet_Tab" href="#Packet" data-toggle="tab" role="tab" onclick="tab('Packet');">Packet Printing
                                </a>
                            </li>
                            <li id="HistoryTab">
                                <a title="History_Tab" href="#History" data-toggle="tab" role="tab" onclick="tab('History');">Customer History
                                </a>
                            </li>
                            <li id="AddendumsTab">
                                <a title="Addendums_Tab" href="#Addendums" data-toggle="tab" role="tab" onclick="tab('Addendums');">Addendums
                                </a>
                            </li>
                            <li id="MilestonesTab">
                                <a title="Milestone_Tab" href="#Milestones" data-toggle="tab" role="tab" onclick="tab('Milestones');">Milestones
                                </a>
                            </li>
                            <li id="WarrantiesTab">
                                <a title="Warranties_Tab" href="#Warranties" data-toggle="tab" role="tab" onclick="tab('Warranties');">Warranties
                                </a>
                            </li>
                        </ul>
                    </div>

                    <%-- Tab: Customer Info --%>
                    <div class="tab-content">
                        <br />

                        <div class="tab-pane fade in" id="Info">
                            <div style="flex-direction: row; display: flex;">

                                <%-- Tab Left: Customer Info --%>
                                <%------------------------------------------------------------------------------------------------------------------%>
                                <div style="flex-direction: column; width: 100%;">
                                    <table class="table table-borderless" cellspacing="0" cellpadding="0">
                                        <tbody>
                                            <%-- First Name --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label" AssociatedControlID="TextBox_FirstName" Text="*First Name:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_FirstName" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirst" ControlToValidate="TextBox_FirstName"
                                                        Display="Static" ErrorMessage="First Name is required" runat="server" ForeColor="Red" /></td>
                                            </tr>


                                            <%-- Last Name --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label1" AssociatedControlID="TextBox_LastName" Text="*Last Name:" runat="server" /></td>
                                                <td style="border: none;">
                                                    <asp:TextBox ID="TextBox_LastName" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="TextBox_LastName"
                                                        Display="Static" ErrorMessage="Last Name is required" runat="server" ForeColor="Red" /></td>
                                            </tr>

                                            <%-- Address --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label2" AssociatedControlID="TextBox_Address" Text="*Address:" runat="server" />
                                                </td>
                                                <td style="border: none;">
                                                    <asp:TextBox ID="TextBox_Address" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorAddress" ControlToValidate="TextBox_Address"
                                                        Display="Static" ErrorMessage="Address is required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>

                                            <%-- City --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label3" AssociatedControlID="TextBox_City" Text="*City:" runat="server" /></td>

                                                <td>
                                                    <asp:TextBox ID="TextBox_City" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorCity" ControlToValidate="TextBox_City"
                                                        Display="Static" ErrorMessage="City is required" runat="server" ForeColor="Red" /></td>

                                            </tr>

                                            <%-- State --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label4" AssociatedControlID="DropDownListState" Text="*State:" runat="server" /></td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownListState" runat="server">
                                                        <asp:ListItem Value="FL">Florida</asp:ListItem>
                                                        <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                                        <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                                        <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                                        <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                                        <asp:ListItem Value="CA">California</asp:ListItem>
                                                        <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                                        <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                                        <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                                        <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                                        <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                                        <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                                        <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                                        <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                                        <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                                        <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                                        <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                                        <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                                        <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                                        <asp:ListItem Value="ME">Maine</asp:ListItem>
                                                        <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                                        <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                                        <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                                        <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                                        <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                                        <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                                        <asp:ListItem Value="MT">Montana</asp:ListItem>
                                                        <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                                        <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                                        <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                                        <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                                        <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                                        <asp:ListItem Value="NY">New York</asp:ListItem>
                                                        <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                                        <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                                        <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                                        <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                                        <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                                        <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                                        <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                                        <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                                        <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                                        <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                                        <asp:ListItem Value="TX">Texas</asp:ListItem>
                                                        <asp:ListItem Value="UT">Utah</asp:ListItem>
                                                        <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                                        <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                                        <asp:ListItem Value="WA">Washington</asp:ListItem>
                                                        <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                                        <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                                        <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                                    </asp:DropDownList></td>

                                            </tr>

                                            <%-- Zip --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label5" AssociatedControlID="TextBox_Zip" Text="*Zip Code:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Zip" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvZip" ControlToValidate="TextBox_Zip"
                                                        Display="Dynamic" ErrorMessage="Zip Code is required" ForeColor="Red" />
                                                    <asp:RegularExpressionValidator ID="regexpcontactZip" runat="server" ControlToValidate="TextBox_Zip"
                                                        ValidationGroup="contactValidation" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a Zip Code formatted as (XXXXX) or 10 Digit (XXXXX-XXXX)"
                                                        ValidationExpression="^\d{5}(?:[-\s]\d{4})?$">
                                                    </asp:RegularExpressionValidator></td>
                                            </tr>

                                            <%-- Phone --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label6" AssociatedControlID="TextBox_Telephone" Text="*Primary Phone:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Telephone" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvPhone" ControlToValidate="TextBox_Telephone"
                                                        Display="Dynamic" ErrorMessage="Primarty Phone is required" ForeColor="Red" />
                                                    <asp:RegularExpressionValidator ID="regexpvalPhone" runat="server" ControlToValidate="TextBox_Telephone"
                                                        ValidationGroup="contactValidation" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a phone number formatted as (XXX-XXX-XXXX)"
                                                        ValidationExpression="^(1-)?\d{3}-\d{3}-\d{4}$">
                                                    </asp:RegularExpressionValidator></td>
                                            </tr>

                                            <%-- Alt Phone --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label7" AssociatedControlID="TextBox_Alternate_Telephone" Text="Alternate Telephone:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Alternate_Telephone" runat="server"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="regexpvalAlternatePhone" runat="server" ControlToValidate="TextBox_Alternate_Telephone"
                                                        ValidationGroup="contactValidation" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a phone number formatted as (XXX-XXX-XXXX)"
                                                        ValidationExpression="^(1-)?\d{3}-\d{3}-\d{4}$">
                                                    </asp:RegularExpressionValidator></td>
                                            </tr>

                                            <%-- Email --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label8" AssociatedControlID="TextBox_Email_Address" Text="*Email:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Email_Address" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvEmail" ControlToValidate="TextBox_Email_Address"
                                                        Display="Dynamic" ErrorMessage="Email Address is required" ForeColor="Red" />
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox_Email_Address"
                                                        ValidationGroup="contactValidation" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a valid email address formatted as (name@domain.com)"
                                                        ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$">
                                                    </asp:RegularExpressionValidator></td>
                                            </tr>

                                            <%-- Alt Email --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label9" AssociatedControlID="TextBox_Email_Address" Text="Alternate Email Address:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Alternate_Email" runat="server"></asp:TextBox></td>
                                            </tr>

                                            <%-- Left: BUTTON - Copy Customer to Job Site Address --%>
                                            <tr>
                                                <td><asp:Button runat="server" ID="same_above" class="btn btn-primary" OnClick="copy" Font-Size="Small" AutoPostBack="true" Text="Jobsite Info same as Above" CausesValidation="false"/></td>
                                                <td></td>
                                            </tr>


                                            <%------------------------------------------------------------------------------------------------------------------%>
                                            <%-- Left: Job Site Info --%>

                                            <%-- Job Site Address --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label10" AssociatedControlID="TextBox_Job_Address" Text="*Address:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Job_Address" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TextBox_Job_Address"
                                                        Display="Static" ErrorMessage="Address is required" runat="server" ForeColor="Red" /></td>
                                            </tr>

                                            <%-- Job Site City --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label11" AssociatedControlID="TextBox_Job_City" Text="City:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Job_City" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TextBox_Job_City"
                                                        Display="Static" ErrorMessage="City is required" runat="server" ForeColor="Red" /></td>
                                            </tr>

                                            <%-- Job Site City/County --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label12" AssociatedControlID="DropDownListState" Text="*Permitting City/County:" runat="server" /></td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="Permit">
                                                        <asp:ListItem Value="Select">Select</asp:ListItem>
                                                        <asp:ListItem Value="Palm">Palm Coast</asp:ListItem>
                                                        <asp:ListItem Value="CityAugustine">City of St. Augustine</asp:ListItem>
                                                        <asp:ListItem Value="Ormond">Ormond Beach</asp:ListItem>
                                                        <asp:ListItem Value="FlaglerCounty">Flagler County</asp:ListItem>
                                                        <asp:ListItem Value="FlaglerBeach">Flagler Beach</asp:ListItem>
                                                        <asp:ListItem Value="StAugustine">St. Augustine Beach</asp:ListItem>
                                                        <asp:ListItem Value="John">St. Johns County</asp:ListItem>
                                                        <asp:ListItem Value="Volusia">Volusia County</asp:ListItem>
                                                        <asp:ListItem Value="Putnam">Punam</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>

                                            <%-- Job Site Zip Code --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label13" AssociatedControlID="TextBox_Job_Zip" Text="*Zip Code:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Job_Zip" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvZipCode" ControlToValidate="TextBox_Job_Zip"
                                                        Display="Dynamic" ErrorMessage="Zip Code is required" ForeColor="Red" />
                                                    <asp:RegularExpressionValidator ID="regexpcontactZipCode" runat="server" ControlToValidate="TextBox_Job_Zip"
                                                        ValidationGroup="contactValidation" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a Zip Code formatted as (XXXXX) or 10 Digit (XXXXX-XXXX)"
                                                        ValidationExpression="^\d{5}(?:[-\s]\d{4})?$">
                                                    </asp:RegularExpressionValidator></td>
                                            </tr>

                                            <%-- Job Site ARB/HOA/Subdivision --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label14" AssociatedControlID="arb" Text="*ARB / HOA / Subdiv:" runat="server" /></td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="arb">
                                                        <asp:ListItem Value="None">None</asp:ListItem>
                                                        <asp:ListItem Value="Select">Select</asp:ListItem>
                                                        <asp:ListItem Value="Grand">Grand Haven</asp:ListItem>
                                                        <asp:ListItem Value="PalmCoast">Palm Coast Plantation</asp:ListItem>
                                                        <asp:ListItem Value="Plantation">Plantation Bay</asp:ListItem>
                                                        <asp:ListItem Value="Ocean">Ocean Hammok</asp:ListItem>
                                                        <asp:ListItem Value="Dunes">Hammok Dunes</asp:ListItem>
                                                        <asp:ListItem Value="Shores">The Shores</asp:ListItem>
                                                        <asp:ListItem Value="Hidden">Hidden Lakes</asp:ListItem>
                                                        <asp:ListItem Value="North">North Shore</asp:ListItem>
                                                        <asp:ListItem Value="Polo">Polo Club</asp:ListItem>
                                                        <asp:ListItem Value="Island">Island Estates</asp:ListItem>
                                                        <asp:ListItem Value="Tuscana">Tuscana</asp:ListItem>
                                                        <asp:ListItem Value="Other">Other</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>

                                            <%-- Job Site Lot Number --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label15" AssociatedControlID="TextBox_Lot" Text="Lot Number:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Lot" runat="server"></asp:TextBox></td>
                                            </tr>

                                            <%-- Job Site Block --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label16" AssociatedControlID="TextBox_Block" Text="Block:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Block" runat="server"></asp:TextBox></td>
                                            </tr>

                                            <%-- Job Site Section --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label17" AssociatedControlID="TextBox_Section" Text="Section:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Section" runat="server"></asp:TextBox></td>
                                            </tr>

                                            <%-- Job Site Plat Book --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label18" AssociatedControlID="TextBox_Plat" Text="Plat Book:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Plat" runat="server"></asp:TextBox></td>
                                            </tr>

                                            <%-- Job Site Pages --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label19" AssociatedControlID="TextBox_Pages" Text="Page(s):" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Pages" runat="server"></asp:TextBox></td>
                                            </tr>

                                            <%-- BUTTON: Archive Dead Deal --%>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="Button2" runat="server" Text="Archive Dead Deal" BackColor="#616161" ForeColor="#FFFFFF" /></td>
                                                <td></td>
                                            </tr>

                                        </tbody>
                                    </table>
                                </div>


                                <%------------------------------------------------------------------------------------------------------------------%>
                                <%-- Tab Right: Job Details --%>
                                <div style="flex-direction: column; width: 100%;">
                                    <table class="table table-borderless" cellspacing="0" cellpadding="0">
                                        <tbody>
                                            <%-- General Private Notes --%>
                                            <tr style="width: 20px;height: 30px">
                                                <td>
                                                    <asp:Label runat="server">General Private Notes</asp:Label>
                                                    <asp:TextBox runat="server" ID="Notes" Width="100%" Height="450px" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                                <td></td>
                                            </tr>


                                            <%-- Minimum Access Space --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Minimum Access Space: </asp:Label>
                                                    <asp:TextBox ID="Min_Access_F" runat="server" TextMode="Number" Text="0" Width="40"></asp:TextBox> ft.
                                                    <asp:TextBox ID="Min_Access_I" runat="server" TextMode="Number" Text="0" Width="40"></asp:TextBox> in.
                                                <br />
                                                    <asp:RequiredFieldValidator ID="rfvMinAccessFeet" ControlToValidate="Min_Access_F"
                                                        Display="Static" ErrorMessage="Feet are required" runat="server" ForeColor="Red" />
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="rfvMinAccessInches" ControlToValidate="Min_Access_I"
                                                        Display="Static" ErrorMessage="Inches are required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>


                                            <%-- Jobsite Distance from HQ --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Jobsite Distance From HQ (mins): </asp:Label></td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="drop_distance">
                                                        <asp:ListItem Value="34">0-34</asp:ListItem>
                                                        <asp:ListItem Value="45">35-45</asp:ListItem>
                                                        <asp:ListItem Value="60">46-60</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>


                                            <%-- Referral to be Paid --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Referral Fee To Be Paid: </asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="Referral" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                            </tr>
                                            <%-- Referral to be Paid Details --%>
                                            <asp:Panel runat="server" ID="Referral_Div" Style="margin-left: 30px" Visible="false">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Amount: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="Referral_Amount" TextMode="Number" runat="server"></asp:TextBox></td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Full Name: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="Referral_Full" runat="server"></asp:TextBox></td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">Address: </asp:Label></td>

                                                    <td>
                                                        <asp:TextBox ID="Referral_Address" runat="server"></asp:TextBox></td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">City: </asp:Label></td>

                                                    <td>
                                                        <asp:TextBox ID="Referral_City" runat="server"></asp:TextBox></td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">State: </asp:Label></td>
                                                    <td>
                                                        <asp:DropDownList ID="Referral_State" runat="server">
                                                            <asp:ListItem Value="FL">Florida</asp:ListItem>
                                                            <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                                            <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                                            <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                                            <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                                            <asp:ListItem Value="CA">California</asp:ListItem>
                                                            <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                                            <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                                            <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                                            <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                                            <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                                            <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                                            <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                                            <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                                            <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                                            <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                                            <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                                            <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                                            <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                                            <asp:ListItem Value="ME">Maine</asp:ListItem>
                                                            <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                                            <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                                            <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                                            <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                                            <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                                            <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                                            <asp:ListItem Value="MT">Montana</asp:ListItem>
                                                            <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                                            <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                                            <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                                            <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                                            <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                                            <asp:ListItem Value="NY">New York</asp:ListItem>
                                                            <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                                            <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                                            <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                                            <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                                            <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                                            <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                                            <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                                            <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                                            <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                                            <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                                            <asp:ListItem Value="TX">Texas</asp:ListItem>
                                                            <asp:ListItem Value="UT">Utah</asp:ListItem>
                                                            <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                                            <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                                            <asp:ListItem Value="WA">Washington</asp:ListItem>
                                                            <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                                            <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                                            <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">Zip Code: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="Referral_Zip" runat="server"></asp:TextBox></td>
                                                </tr>
                                            </asp:Panel>


                                            <%-- New Home Construction Project--%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*New Home Construction Project: </asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="New_Home" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                            </tr>


                                            <%-- New Home Construction Project Details --%>
                                            <asp:Panel runat="server" ID="Home_Div" Style="margin-left: 30px" Visible="false">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Builder Name: </asp:Label></td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="New_Home_Builder" OnSelectedIndexChanged="onChanged" AutoPostBack="true">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Other">Other</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                </tr>

                                                <asp:Panel runat="server" ID="Other_New_Panel" Visible="false">
                                                    <tr>
                                                        <td>
                                                            <asp:Label runat="server">*Builder's Name: </asp:Label></td>
                                                        <asp:TextBox runat="server" ID="Other_New_Builder" />
                                                    </tr>
                                                </asp:Panel>
                                            </asp:Panel>


                                            <%-- Builder Referral Fee --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Builder Referral Fee: </asp:Label></td>

                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="Builder_Referral" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList></td>

                                            </tr>


                                            <%-- Builder Referral Fee Details --%>
                                            <asp:Panel runat="server" ID="Builder_Panel" Style="margin-left: 30px" Visible="false">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">Builder Name: </asp:Label></td>

                                                    <td>
                                                        <asp:DropDownList runat="server" ID="Builder_Names" OnSelectedIndexChanged="onChanged" AutoPostBack="true">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Other">Other</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                </tr>

                                                <asp:Panel runat="server" ID="Other_Builder_Panel" Visible="false">
                                                    <td>
                                                        <asp:Label runat="server">Builder Names: </asp:Label></td>
                                                    <tr>
                                                        <asp:TextBox runat="server" ID="Other_Builder" />
                                                    </tr>
                                                </asp:Panel>

                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">Fee Amount: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox runat="server" TextMode="Number" ID="Builder_Amount"></asp:TextBox></td>
                                                </tr>
                                            </asp:Panel>


                                            <%-- Access Letter Required --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Access Permission Letter Required: </asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="Permission_Letter" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                                <asp:Button runat="server" Text="Print Access Letter" BackColor="#03a9f4" ForeColor="#FFFFFF" ID="Letter_Button" Visible="false" OnClick="PrintAccess" />
                                            </tr>


                                            <%-- Homeowner To Furnish Surveys --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Homeowner To Furnish Surveys: </asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="Homeowner_Furnish" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                            </tr>


                                            <%-- Homeowner To Furnish Surveys Details--%>
                                            <asp:Panel runat="server" ID="Survey_Panel" Style="margin-left: 30px" Visible="false">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">Furnished Surveys: </asp:Label></td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="Surveys_Selection">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Initial">Initial</asp:ListItem>
                                                            <asp:ListItem Value="Final">Final</asp:ListItem>
                                                            <asp:ListItem Value="Both">Both</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                </tr>
                                            </asp:Panel>


                                            <%-- Existing Fence --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Existing Fence: </asp:Label></td>

                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="Existing_Fence" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                            </tr>


                                            <%-- Existing Septic Tank --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Existing Septic Tank:  </asp:Label></td>

                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="Septic_Tank" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                            </tr>
                                            <%-- Existing Septic Tank  Details--%>
                                            <asp:Panel runat="server" ID="Septic_Panel" Style="margin-left: 30px" Visible="false">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">Is The Septic On The Survey?: </asp:Label></td>

                                                    <td>
                                                        <asp:RadioButtonList runat="server" ID="Septic_Buttons" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                            <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                            <asp:ListItem Value="No">No</asp:ListItem>
                                                        </asp:RadioButtonList></td>
                                                </tr>
                                            </asp:Panel>


                                            <%-- Waterfill Type --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">Waterfill type: </asp:Label></td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="DropDownList2">
                                                        <asp:ListItem Value="City Water">City Water</asp:ListItem>
                                                        <asp:ListItem Value="Well Water">Well Water</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>


                                            <%-- Form Buttons --%>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="Button_CreateCustomer" runat="server" Text="Discard Changes" BackColor="#f44336" ForeColor="#FFFFFF" OnClick="Discard" />
                                                    <asp:Button ID="Button1" runat="server" Text="Save Changes" BackColor="#03a9f4" ForeColor="#FFFFFF" OnClick="Save" />
                                                </td>
                                                <td></td>
                                            </tr>

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>


                        <%-- Tab: Create Bid Proposal --%>
                        <div class="tab-pane fade in" id="Create">
                            <p>
                                Bid Proposal Version Description: 
                               
                                <asp:TextBox runat="server" ID="bid_prop_desc" Width="50%"></asp:TextBox>
                            </p>

                            <div class="panel panel-primary" style="max-width: 40%;">
                                <div class="panel-heading">
                                    Create Bid Proposal Version #1
                               
                                </div>
                                <div class="panel-body">
                                    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 5px;">
                                        <asp:Button runat="server" Text="Genesis" OnClick="GenerateGenesis" Height="130%"></asp:Button>
                                        <asp:Button runat="server" Text="EZ Flow" OnClick="GenerateEZ" Height="130%"></asp:Button>
                                        <%--<asp:Button runat="server" Text="Renovation" OnClick="GenerateRenovation" Height="130%"></asp:Button>--%>
                                    </div>
                                    <br />
                                    <asp:Button runat="server" Text="Select Custom Master Bid" Width="100%" Height="130%"></asp:Button>
                                </div>
                            </div>
                            <asp:Button Width="40%" runat="server" Text="Continue Project" ID="ContinueButton" ForeColor="#2196f3" BackColor="White" OnClick="Continue" />
                        </div>


                        <%-- Tab: Upload Documents / Forms --%>
                        <div class="tab-pane fade in" id="Upload">
                            <p>
                                <strong style="color: red;">Red</strong>
                                = Not Uploaded but Required
                               
                                <strong style="color: #4caf50;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Green</strong>
                                = Upload Completed
                           
                            </p>
                            <div class="panel panel-primary" style="max-width: 100%; display: grid; grid-template-columns: repeat(4, 1fr); border: 0px none;">
                                <div class="panel-heading" style="border: 1px solid #000; border-radius: 5px 0px 0px 0px;">
                                    Immediate Required Documents
                               
                                </div>
                                <div class="panel-heading" style="border: 1px solid #000; border-radius: 0px;">
                                    Commission Related Documents
                               
                                </div>
                                <div class="panel-heading" style="border: 1px solid #000; border-radius: 0px;">
                                    Required Documents
                               
                                </div>
                                <div class="panel-heading" style="border: 1px solid #000; border-radius: 0px 5px 0px 0px;">
                                    Addendums
                               
                                </div>
                                <div class="panel-body" style="border: 1px solid #000; border-radius: 0px 0px 0px 5px;">
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_signed" ForeColor="Red">Signed Design</asp:Label>
                                        <asp:Image ID="warning_signed" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_contract" ForeColor="Red">Signed Contract</asp:Label>
                                        <asp:Image ID="warning_contract" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_explanation" ForeColor="Red">Signed Customer Explanation</asp:Label>
                                        <asp:Image ID="warning_explanation" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_sub" ForeColor="Red">Sub Copy Design</asp:Label>
                                        <asp:Image ID="warning_sub" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_survey" ForeColor="Red">Survey Without Pool</asp:Label>
                                        <asp:Image ID="warning_survey" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_mosaic" ForeColor="#9e9e9e" Visible="false">Mosaic Tile Disclaimer</asp:Label>
                                        <asp:Image ID="warning_mosaic" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_contingency" ForeColor="#9e9e9e" Visible="false">Contingency</asp:Label>
                                        <asp:Image ID="warning_contingency" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                </div>
                                <div class="panel-body" style="border: 1px solid #000;">
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_project" ForeColor="Red">Project / Commission Breakdown</asp:Label>
                                        <asp:Image ID="warning_project" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_addendumcomm" ForeColor="#9e9e9e" Visible="false">Addendum Commissions</asp:Label>
                                        <asp:Image ID="warning_addendumcomm" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_tiless" ForeColor="#9e9e9e" Visible="false">Tile Selection Sheet</asp:Label>
                                        <asp:Image ID="warning_titless" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                </div>
                                <div class="panel-body" style="border: 1px solid #000;">
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_tss" ForeColor="Red">Tile Selection Sheet</asp:Label>
                                        <asp:Image ID="warning_tss" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_access" ForeColor="Red">Access Permission Letter</asp:Label>
                                        <asp:Image ID="warning_access" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_surveypool" ForeColor="Red">Survey With Pool</asp:Label>
                                        <asp:Image ID="warning_surveypool" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_tdh" ForeColor="Red">Total Dynamic Head</asp:Label>
                                        <asp:Image ID="warning_tdh" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_warranty" ForeColor="Red">Warranty Deed</asp:Label>
                                        <asp:Image ID="warning_warranty" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_easement" ForeColor="#9e9e9e" Visible="false">Easement Encroachment Form</asp:Label>
                                        <asp:Image ID="warning_easement" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_contingency_release" ForeColor="#9e9e9e" Visible="false">Contingency Release Letter</asp:Label>
                                        <asp:Image ID="warning_contingency_release" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_arb" ForeColor="#9e9e9e" Visible="false">ARB Approval Letter</asp:Label>
                                        <asp:Image ID="warning_arb" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                </div>
                                <div class="panel-body" style="border: 1px solid #000; border-radius: 0px 0px 5px 0px;">
                                </div>
                            </div>
                            <br />
                            <br />
                            <asp:Button ID="Upload_Doc_Button" runat="server" Text="Upload Document" BackColor="#03a9f4" ForeColor="#FFFFFF" OnClick="popup" />


                            <asp:Panel ID="Upload_Pop" runat="server" Visible="false" Style="position: absolute; left: 210px; top: 79px; background-color: #80808080; width: calc(100% - 210px); height: 100%; z-index: 1;">
                                <asp:Panel ID="Doc_Upload" runat="server" Style="width: 430px; height: 170px; background-color: white; margin: 0 auto; margin-top: 300px; padding: 5px;">
                                    <p>
                                        Select Document to Upload: 
                                       
                                        <asp:DropDownList runat="server" ID="Selected_File">
                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                            <asp:ListItem Value="Access Permission Letter">Access Permission Letter</asp:ListItem>
                                            <asp:ListItem Value="Addendum Commissions">Addendum Commissions</asp:ListItem>
                                            <asp:ListItem Value="ARB Approval Letter">ARB Approval Letter</asp:ListItem>
                                            <asp:ListItem Value="Contingency Release Letter">Contingency Release Letter</asp:ListItem>
                                            <asp:ListItem Value="Contract">Contract</asp:ListItem>
                                            <asp:ListItem Value="Customer Explanation">Customer Explanation</asp:ListItem>
                                            <asp:ListItem Value="Easement Encroachment Form">Easement Encroachment Form</asp:ListItem>
                                            <asp:ListItem Value="Mosaic Tile Disclaimer">Mosaic Tile Disclaimer</asp:ListItem>
                                            <asp:ListItem Value="Project / Commission Breakdown">Project / Commission Breakdown</asp:ListItem>
                                            <asp:ListItem Value="Revised Sub Copy">Revised Sub Copy</asp:ListItem>
                                            <asp:ListItem Value="Signed Design">Signed Design</asp:ListItem>
                                            <asp:ListItem Value="Sub Copy Design">Sub Copy Design</asp:ListItem>
                                            <asp:ListItem Value="Survey With Pool">Survey With Pool</asp:ListItem>
                                            <asp:ListItem Value="Survey Without Pool">Survey Without Pool</asp:ListItem>
                                            <asp:ListItem Value="Tile Selection Sheet">Tile Selection Sheet</asp:ListItem>
                                            <asp:ListItem Value="Total dynamic Head">Total dynamic Head</asp:ListItem>
                                            <asp:ListItem Value="Warranty Deed">Warranty Deed</asp:ListItem>
                                        </asp:DropDownList>
                                    </p>
                                    <p style="padding: 5px; border: 2px solid;">
                                        <asp:FileUpload ID="FileUpLoad1" runat="server" />
                                    </p>
                                    <p>
                                        Signed Date:
                                       
                                        <asp:TextBox TextMode="Date" runat="server" ID="Input_Date" />
                                    </p>
                                    <p style="padding-top: 12px; float: right;">
                                        <asp:Button runat="server" BackColor="#f44336" ForeColor="White" Text="Cancel" OnClick="popup" />
                                        <asp:Button runat="server" BackColor="#03a9f4" ForeColor="White" Text="Upload Document" OnClick="Upload" />
                                    </p>
                                </asp:Panel>
                            </asp:Panel>
                        </div>


                        <%-- Tab: Permitting --%>
                        <div class="tab-pane fade in" id="Permitting">
                            <div style="flex-direction: row; display: flex;">
                                <div style="flex-direction: column; width: 50%;">
                                    <p>
                                        Permitting for 
                                       
                                        <asp:Label Font-Bold="True" runat="server" ID="label_permitting">Flagler County</asp:Label>
                                    </p>
                                    <p>
                                        Name: 
                                       
                                        <asp:Label runat="server" ID="label_name" Font-Size="Large"></asp:Label>
                                    </p>
                                    <p>
                                        Jobsite Address: 
                                       
                                        <asp:Label runat="server" ID="label_address" Font-Size="Large"></asp:Label>
                                    </p>
                                    <p>
                                        &nbsp;&nbsp;&nbsp;&nbsp;Note: 
                                       
                                        <asp:Label runat="server" ForeColor="Red" Font-Underline="True">Red = Notarized</asp:Label>
                                        &nbsp;&nbsp;&nbsp;&nbsp;Note: 
                                       
                                        <asp:Label runat="server" ForeColor="#428BCA">Blue = Signed</asp:Label>
                                    </p>
                                    <br />
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_permit_app" Font-Size="Small" Text="&nbsp;Permit Application" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_hard_copy" Font-Size="Small" Text="&nbsp;Hard Copy Site Plan With Elevations / Survey With Pool Design / Survey With Existing Fence" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_cut_sheet" Font-Size="Small" Text="&nbsp;Manufacturer Cut Sheet Specs" />
                                    </p>
                                    <p>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                       
                                        <asp:CheckBox runat="server" ID="check_pump" Font-Size="Small" Text="&nbsp;Pump:" />
                                        <asp:DropDownList runat="server" ID="drop_pump">
                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                            <asp:ListItem Value="super">Super II</asp:ListItem>
                                            <asp:ListItem Value="900">Tri Star VS 900</asp:ListItem>
                                            <asp:ListItem Value="950">Tri Star VS 950</asp:ListItem>
                                            <asp:ListItem Value="single">Tri Star 3/4 HP Single Speed</asp:ListItem>
                                        </asp:DropDownList>
                                    </p>
                                    <p>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                       
                                        <asp:CheckBox runat="server" ID="check_filter" Font-Size="Small" Text="&nbsp;Filter:" />
                                        <asp:DropDownList runat="server" ID="DropDownList1">
                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                            <asp:ListItem Value="3620">3620 DE Filter</asp:ListItem>
                                            <asp:ListItem Value="4820">4820 DE Filter</asp:ListItem>
                                            <asp:ListItem Value="6020">6020 DE Filter</asp:ListItem>
                                            <asp:ListItem Value="7220">7220 DE Filter</asp:ListItem>
                                            <asp:ListItem Value="120">120 Sq. Ft. Cartridge</asp:ListItem>
                                            <asp:ListItem Value="150">150 Sq. Ft. Cartridge</asp:ListItem>
                                            <asp:ListItem Value="175">175 Sq. Ft. Cartridge</asp:ListItem>
                                            <asp:ListItem Value="200">200 Sq. Ft. Cartridge</asp:ListItem>
                                        </asp:DropDownList>
                                    </p>
                                    <p>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                       
                                        <asp:CheckBox runat="server" ID="check_drain" Font-Size="Small" Text="&nbsp;Main Drain" />
                                        <asp:DropDownList runat="server" ID="drop_drain">
                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                            <asp:ListItem Value="std">Std. Dual Main Drain</asp:ListItem>
                                            <asp:ListItem Value="mdx">MDX Main Drain</asp:ListItem>
                                        </asp:DropDownList>
                                    </p>
                                    <p>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                       
                                        <asp:CheckBox runat="server" ID="check_heater" Font-Size="Small" Text="&nbsp;Heater:" />
                                        <asp:DropDownList runat="server" ID="drop_heater">
                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                            <asp:ListItem Value="a_125">AquaCal SQ 125</asp:ListItem>
                                            <asp:ListItem Value="a_145">AquaCal SQ 145</asp:ListItem>
                                            <asp:ListItem Value="a_150">AquaCal SQ 150 VS</asp:ListItem>
                                            <asp:ListItem Value="a_225">AquaCal SQ 225</asp:ListItem>
                                            <asp:ListItem Value="a_120">AquaCal SQ 120 R</asp:ListItem>
                                            <asp:ListItem Value="a_166">AquaCal SQ 166 R</asp:ListItem>
                                            <asp:ListItem Value="a_115">AquaCal T115</asp:ListItem>
                                            <asp:ListItem Value="a_135">AquaCal T135</asp:ListItem>
                                            <asp:ListItem Value="h_110">Hayward 110 K</asp:ListItem>
                                            <asp:ListItem Value="h_140">Hayward 140 K</asp:ListItem>
                                            <asp:ListItem Value="h_120">Hayward 120 K Heat / Cool</asp:ListItem>
                                            <asp:ListItem Value="h_140_low">Hayward 140 K Low Ambient</asp:ListItem>
                                            <asp:ListItem Value="h_250k_gas">Hayward 250,000 BTU Gas</asp:ListItem>
                                            <asp:ListItem Value="h_400k_gas">Hayward 400,000 BTU Gas</asp:ListItem>
                                        </asp:DropDownList>
                                    </p>
                                    <p>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                       
                                        <asp:CheckBox runat="server" ID="check_safety" Font-Size="Small" Text="&nbsp;Safety Feature" />
                                        <asp:DropDownList runat="server" ID="drop_safety">
                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                            <asp:ListItem Value="Pool">Pool Side Alarms</asp:ListItem>
                                            <asp:ListItem Value="Window">Window / Door Alarms</asp:ListItem>
                                            <asp:ListItem Value="Fence">Baby Fence</asp:ListItem>
                                        </asp:DropDownList>
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_warranty_deed" Font-Size="Small" Text="&nbsp;Recorded Warranty Deed (www.flaglerpa.com)" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_commencement" Font-Size="Small" ForeColor="Red" Font-Underline="true" Text="&nbsp;Notice of Commencement" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_energy_calc" ForeColor="#428BCA" Font-Size="Small" Text="&nbsp;TDH Energy Calculations" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_shop" Font-Size="Small" Text="&nbsp;Shop Drawings / Sub Copy" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_lien_law" ForeColor="Red" Font-Size="Small" Text="&nbsp;Construction Lien Law Affidavit" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_pool_engineering" Font-Size="Small" Text="&nbsp;Pool Engineering" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_additional_engineering" Font-Size="Small" Text="&nbsp;Additional Engineering" />
                                        <asp:DropDownList runat="server" ID="drop_additional_engineering">
                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                            <asp:ListItem Value="Screen">Screen Engineering</asp:ListItem>
                                            <asp:ListItem Value="Fence">Fence Engineering</asp:ListItem>
                                        </asp:DropDownList>
                                    </p>
                                    <div style="display: flex; flex-direction: row">
                                        <p>
                                            SUBCONTRACTORS:
                                       
                                        </p>
                                        <div style="flex-direction: column">
                                            <p>
                                                <asp:CheckBox runat="server" ID="ws_license" Font-Size="Small" Text="&nbsp;Waterside Electrical Lic#EC13002161" />
                                            </p>
                                            <p>
                                                <asp:CheckBox runat="server" ID="aluminum_license" Font-Size="Small" Text="&nbsp;East Coast Aluminum Lic#SCC131150000" />
                                            </p>
                                            <p>
                                                <asp:CheckBox runat="server" ID="fencing_license" Font-Size="Small" Text="&nbsp;Liberty Fencing LIC#SPEC-000145" />
                                            </p>
                                        </div>
                                    </div>
                                    <p>
                                        <asp:Label runat="server" ForeColor="#428BCA" ID="label_received">ARB Approval Received</asp:Label>
                                        <asp:RadioButtonList runat="server" ID="radio_received" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                            <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </p>
                                    <p>
                                        <asp:Label runat="server" ForeColor="#428BCA" ID="label_easement_encroachment">Easement Encroachment Form Required</asp:Label>
                                        <asp:RadioButtonList runat="server" ID="radio_easement_encroachment" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                            <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </p>
                                </div>
                                <div style="flex-direction: column; width: 50%;">
                                    <p>
                                        <asp:Label ForeColor="Red" runat="server">Red</asp:Label>
                                        = Not Uploaded but Required
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                       
                                        <asp:Label ForeColor="#4caf50" runat="server">Green</asp:Label>
                                        = Upload Completed
                                   
                                    </p>

                                    <div class="panel panel-primary" style="max-width: 80%">
                                        <div class="panel-heading">
                                            Important Forms
                                       
                                        </div>
                                        <div class="panel-body">
                                            <p>
                                                <asp:Label Font-Bold="True" runat="server" ID="important_NoC" ForeColor="#4caf50">Notice of Commencement</asp:Label>
                                            </p>
                                            <p>
                                                <asp:Label Font-Bold="True" runat="server" ID="important_lien" ForeColor="#4caf50">Mechanics Lien Law Affidavit</asp:Label>
                                            </p>
                                            <p>
                                                <asp:Label Font-Bold="True" runat="server" ID="important_energy" ForeColor="#4caf50">TDH Energy Calculations</asp:Label>
                                            </p>
                                            <p>
                                                <asp:Label Font-Bold="True" runat="server" ID="important_shop" ForeColor="#4caf50">Shop Drawings / Sub Copy</asp:Label>
                                            </p>
                                            <p>
                                                <asp:Label Font-Bold="True" runat="server" ID="important_warranty" ForeColor="#4caf50">Warranty Deed</asp:Label>
                                            </p>
                                            <p>
                                                <asp:Label Font-Bold="True" runat="server" ID="important_safety" ForeColor="#4caf50">Safety Act Form</asp:Label>
                                            </p>
                                            <p>
                                                <asp:Label Font-Bold="True" runat="server" ID="important_drainage" ForeColor="#4caf50">Affidavit of Drainage Control</asp:Label>
                                            </p>
                                            <p>
                                                <asp:Label Font-Bold="True" runat="server" ID="important_tree" ForeColor="#4caf50">Tree Protection</asp:Label>
                                            </p>
                                            <div>
                                                <br />
                                                <p>
                                                    <asp:Label Font-Bold="True" runat="server" ID="important_screen" ForeColor="#9e9e9e">Screen Engineering</asp:Label>
                                                </p>
                                                <p>
                                                    <asp:Label Font-Bold="True" runat="server" ID="important_easement" ForeColor="#9e9e9e">Easement Encroachment Form</asp:Label>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <asp:Button Text="Upload File" BackColor="#03a9f4" ForeColor="White" runat="server" Style="padding: 5px; padding-left: 30px; padding-right: 30px;" />
                                </div>
                            </div>
                        </div>


                        <%-- Tab: Packet Printing --%>
                        <div class="tab-pane fade in" id="Packet">
                            <div class="panel panel-primary" style="max-width: 100%; display: grid; grid-template-columns: repeat(3, 1fr); border: 0px none;">
                                <div class="panel-heading" style="border: 1px solid #000; border-radius: 5px 0px 0px 0px;">
                                    Legal Paper Size
                               
                                </div>
                                <div class="panel-heading" style="border: 1px solid #000; border-radius: 0px;">
                                    Letter Paper Size
                               
                                </div>
                                <div class="panel-heading" style="border: 1px solid #000; border-radius: 0px;">
                                    Surveys
                               
                                </div>
                                <div class="panel-body" style="border: 1px solid #000; border-radius: 0px 0px 0px 5px;">
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_contract" Font-Size="Medium" Text="&nbsp;Contract" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_explanation" Font-Size="Medium" Text="&nbsp;Customer Explanation" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_sub" Font-Size="Medium" Text="&nbsp;Sub Copy Design" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_revised" Font-Size="Medium" Text="&nbsp;Revised Sub Copy Design" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_signed" Font-Size="Medium" Text="&nbsp;Signed Design" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_breakdown" Font-Size="Medium" Text="&nbsp;Project / Commission Breakdown" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_tile" Font-Size="Medium" Text="&nbsp;Tile Selection Sheet" Visible="false" />
                                    </p>
                                </div>
                                <div class="panel-body" style="border: 1px solid #000;">
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_access" Font-Size="Medium" Text="&nbsp;Access Permission Letter" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_schedule" Font-Size="Medium" Text="&nbsp;Schedule of Events" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_addendum_comm" Font-Size="Medium" Text="&nbsp;Addendum Commissions" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_arb" Font-Size="Medium" Text="&nbsp;ARB Approval Letter" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_contingency" Font-Size="Medium" Text="&nbsp;Contingency Release Letter" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_easement" Font-Size="Medium" Text="&nbsp;Easement Encroachment Form" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_mosaic" Font-Size="Medium" Text="&nbsp;Mosaic Tile Disclaimer" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_tdh" Font-Size="Medium" Text="&nbsp;Total Dynamic Head" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_warranty" Font-Size="Medium" Text="&nbsp;Warranty Deed" Visible="false" />
                                    </p>
                                </div>
                                <div class="panel-body" style="border: 1px solid #000;">
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_survey_pool" Font-Size="Medium" Text="&nbsp;Survey With Pool" Visible="false" />
                                    </p>
                                    <p>
                                        <asp:CheckBox runat="server" ID="check_survey" Font-Size="Medium" Text="&nbsp;Survey Without Pool" Visible="false" />
                                    </p>
                                </div>
                            </div>
                            <asp:Button runat="server" Text="Print Selected" BackColor="#03a9f4" ForeColor="White" OnClick="packetPrint" />
                        </div>


                        <%-- Tab: Customer History --%>
                        <div class="tab-pane fade in" id="History">
                            <div style="display: flex; flex-direction: row;">
                                Add a Note:
                               
                                <asp:TextBox runat="server" TextMode="MultiLine" ID="historyNote" Height="70px" Width="85%"></asp:TextBox>
                                <div style="margin: 0 auto; padding: 0; height: 70px; align-items: center;">
                                    <asp:Button runat="server" ID="history_button" Text="Add Note" BackColor="#03a9f4" ForeColor="White" Height="40px" OnClick="addNote" />
                                </div>
                            </div>
                            <asp:Panel runat="server" ID="customer_history">
                            </asp:Panel>
                        </div>
                        <div class="tab-pane fade in" id="Addendums">
                            <asp:Button runat="server" Text="New Addendum" BackColor="#03a9f4" ForeColor="White" Height="40px" Width="25%" />
                            <br />
                            <br />
                            <br />
                            Previous Addendums:
                           
                            <asp:GridView ID="GridView1" CssClass="Grid" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="Both" Width="100%">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" ItemStyle-ForeColor="#428BCA" HeaderText="View" />
                                    <asp:BoundField DataField="FirstName" HeaderText="Description" SortExpression="FirstName" />
                                    <asp:BoundField DataField="LastName" HeaderText="Date Signed" SortExpression="LastName" />
                                    <asp:BoundField DataField="CustomerID" HeaderText="Price" />
                                </Columns>
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView>
                        </div>


                        <%-- Tab: Milestones --%>
                        <div class="tab-pane fade in" id="Milestones">
                            <div>
                                <asp:CheckBoxList runat="server" ID="Milestone_List" AutoPostBack="true" Font-Bold="true" Font-Size="Large" CellSpacing="1" CellPadding="1" OnSelectedIndexChanged="Stone">
                                    <asp:ListItem>Signed Contract</asp:ListItem>
                                    <asp:ListItem>Deposit Received $$$$$</asp:ListItem>
                                    <asp:ListItem>Physical Folder</asp:ListItem>
                                    <asp:ListItem>PPO Folder / Scans</asp:ListItem>
                                    <asp:ListItem>Sub-Copy Plan</asp:ListItem>
                                    <asp:ListItem>Tile Selections</asp:ListItem>
                                    <asp:ListItem>Permit Applied</asp:ListItem>
                                    <asp:ListItem>Permit Received</asp:ListItem>
                                    <asp:ListItem>Pre Site Checklist</asp:ListItem>
                                    <asp:ListItem>Install Permit Box & Bins</asp:ListItem>
                                    <asp:ListItem>Remove Fence</asp:ListItem>
                                    <asp:ListItem>Cut & Cap Sprinkler Lines</asp:ListItem>
                                    <asp:ListItem>Strip Sod / Form Pool</asp:ListItem>
                                    <asp:ListItem>Dig Wall Footer</asp:ListItem>
                                    <asp:ListItem>Wall Footer Inspection</asp:ListItem>
                                    <asp:ListItem>Pour Wall Footer</asp:ListItem>
                                    <asp:ListItem>Install Block Retaining Wall</asp:ListItem>
                                    <asp:ListItem>Block Wall Inspection</asp:ListItem>
                                    <asp:ListItem>Pour Block Wall</asp:ListItem>
                                    <asp:ListItem>Dig Date</asp:ListItem>
                                    <asp:ListItem>Steel</asp:ListItem>
                                    <asp:ListItem>Excavation Payment Due $$$$$</asp:ListItem>
                                    <asp:ListItem>Excavation Payment Received $$$$$</asp:ListItem>
                                    <asp:ListItem>Steel Inspection</asp:ListItem>
                                    <asp:ListItem>Pre-Plumbing</asp:ListItem>
                                    <asp:ListItem>Shoot Shell</asp:ListItem>
                                    <asp:ListItem>Shell Payment Due $$$$$</asp:ListItem>
                                    <asp:ListItem>Shell Payment Received $$$$$</asp:ListItem>
                                    <asp:ListItem>Deck Grade</asp:ListItem>
                                    <asp:ListItem>Plumbing</asp:ListItem>
                                    <asp:ListItem>Set Skimmer / Auto Fill</asp:ListItem>
                                    <asp:ListItem>Install Auto-fill</asp:ListItem>
                                    <asp:ListItem>Drain Line / Chase Line</asp:ListItem>
                                    <asp:ListItem>Tile</asp:ListItem>
                                    <asp:ListItem>Remove Existing Lanai</asp:ListItem>
                                    <asp:ListItem>Install Waterfall</asp:ListItem>
                                    <asp:ListItem>Form Concrete Deck</asp:ListItem>
                                    <asp:ListItem>Tamp / Water Pack</asp:ListItem>
                                    <asp:ListItem>Form Paver Footer</asp:ListItem>
                                    <asp:ListItem>Termite Treat</asp:ListItem>
                                    <asp:ListItem>Deck Inspection</asp:ListItem>
                                    <asp:ListItem>Pour Deck</asp:ListItem>
                                    <asp:ListItem>Pour Paver Footer</asp:ListItem>
                                    <asp:ListItem>Install Pavers</asp:ListItem>
                                    <asp:ListItem>Schedule for Solar</asp:ListItem>
                                    <asp:ListItem>Deck Payment Due $$$$$</asp:ListItem>
                                    <asp:ListItem>Deck Payment Received $$$$$</asp:ListItem>
                                    <asp:ListItem>Rock Work</asp:ListItem>
                                    <asp:ListItem>Texture Deck / Paint</asp:ListItem>
                                    <asp:ListItem>Screen Enclosure</asp:ListItem>
                                    <asp:ListItem>Equipment Set / Set up Sod Install info w - Customer</asp:ListItem>
                                    <asp:ListItem>Electric</asp:ListItem>
                                    <asp:ListItem>Alarms</asp:ListItem>
                                    <asp:ListItem>Baby Fence</asp:ListItem>
                                    <asp:ListItem>Electric Inspection / Set up Sod Install Info w - Customer</asp:ListItem>
                                    <asp:ListItem>Plaster Pool</asp:ListItem>
                                    <asp:ListItem>Water Truck Fill - Up</asp:ListItem>
                                    <asp:ListItem>Install Solar</asp:ListItem>
                                    <asp:ListItem>Final Grade / Cleanup</asp:ListItem>
                                    <asp:ListItem>Fire Up</asp:ListItem>
                                    <asp:ListItem>Addendum Work Completed</asp:ListItem>
                                    <asp:ListItem>Addendum Payments Due $$$$$</asp:ListItem>
                                    <asp:ListItem>All Addendum Payments Received $$$$$</asp:ListItem>
                                    <asp:ListItem>Fill Up Payment Due $$$$$</asp:ListItem>
                                    <asp:ListItem>Fill Up Payment Received $$$$$</asp:ListItem>
                                    <asp:ListItem>Replace Fence</asp:ListItem>
                                    <asp:ListItem>Final Clean Pressure Wash</asp:ListItem>
                                    <asp:ListItem>Final Paint After Sod</asp:ListItem>
                                    <asp:ListItem>Walkthru / Punchlist</asp:ListItem>
                                    <asp:ListItem>Punlist Items COMPLETED</asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>


                        <%-- Tab: Warranties --%>
                        <div class="tab-pane fade in" id="Warranties">
                            <asp:GridView ID="GridWarranties" runat="server" CssClass="Grid" AllowSorting="True" ForeColor="#333333" GridLines="Both" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Company" HeaderText="Company" ItemStyle-Width="10%">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="ProductName" HeaderText="Product Name">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="ModelNumber" HeaderText="Modeul Number">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="PartNumber" HeaderText="Part Number">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="SerialNumber" HeaderText="Serial Number">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="DateOfInstall" HeaderText="Date of Install" ItemStyle-Width="8%">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="FireUpDate" HeaderText="Fire Up Date" ItemStyle-Width="8%">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="WarrantyLength" HeaderText="Warranty Length" ItemStyle-Width="8%">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                    <asp:BoundField ControlStyle-CssClass="form-control" DataField="Installer" HeaderText="Installer" ItemStyle-Width="8%">
                                        <ControlStyle CssClass="form-control" />
                                    </asp:BoundField>
                                </Columns>
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:WatersidePortal_dbConnectionString %>" SelectCommand="SELECT * from [Warranties]"></asp:SqlDataSource>
                            <br />
                            <br />
                            <br />
                            <p>
                                Company:
                               
                                <asp:TextBox runat="server" Width="20%" ID="Company" />
                            </p>
                            <p>
                                Product Name:
                               
                                <asp:TextBox runat="server" Width="20%" ID="ProductName" />
                            </p>
                            <p>
                                Model Number:
                               
                                <asp:TextBox runat="server" Width="20%" ID="ModelNumber" />
                            </p>
                            <p>
                                Part Number:
                               
                                <asp:TextBox runat="server" Width="20%" ID="PartNumber" />
                            </p>
                            <p>
                                Serial Number:
                               
                                <asp:TextBox runat="server" Width="20%" ID="SerialNumber" />
                            </p>
                            <p>
                                Date of Install:
                               
                                <asp:TextBox TextMode="Date" runat="server" ID="DateOfInstall" />
                            </p>
                            <p>
                                Fire Up Date:
                               
                                <asp:TextBox TextMode="Date" runat="server" ID="FireUpDate" />
                            </p>
                            <p>
                                Warranty Length:
                               
                                <asp:TextBox runat="server" Width="20%" ID="WarrantyLength" />
                            </p>
                            <p>
                                Installer:
                               
                                <asp:TextBox runat="server" Width="20%" ID="Installer" />
                            </p>
                            <br />
                            <br />
                            <asp:Button runat="server" Text="Add Warranty" BackColor="#03a9f4" ForeColor="#FFFFFF" OnClick="AddWarranty" />
                        </div>
                    </div>

                </div>
                <div style="float: right; padding: 5px; background-color: #FFFFFF; border: 1px solid #e0e0e0; margin: 0;">
                    <asp:Button runat="server" Text="Exit" ForeColor="#FFFFFF" BackColor="#E34A3F" Width="160px" Height="40px" OnClick="Exit" />
                </div>
            </div>
        </section>
    </section>

    <script type="text/javascript">
        if (window.location.href.split('?').length > 1 && window.location.href.split('?')[1].split('&').length > 0) {
            document.getElementById(window.location.href.split('?')[1].split('&')[1]).classList.add('active');
            document.getElementById(window.location.href.split('?')[1].split('&')[1] + "Tab").className = 'active';
        }
    </script>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScriptPage" runat="server">
</asp:Content>

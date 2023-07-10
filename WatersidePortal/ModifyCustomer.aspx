﻿<%@ Page Title="" MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/Shared/MasterPages/SiteLayout.Master" AutoEventWireup="true" CodeBehind="ModifyCustomer.aspx.cs" Inherits="WatersidePortal.ModifyCustomer" %>

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

        button {
            margin: 0 auto;
            display: block;
        }

        .warrantyInputPadding {
            position: relative;
            margin-top: 5px;
            margin-bottom: 5px;
            width: 300px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
    <asp:HiddenField ID="TabName" runat="server" />
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

    <asp:ScriptManager ID="asmTextOnly" runat="server" />

    <section id="main-content">
        <section class="wrapper site-min-height">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <br />
                    <h4 class="title">Customer Management for
                        <asp:Label runat="server" ID="CustomerName" Font-Size="Large" />
                    </h4>
                </div>

                <div class="panel-body">
                    <asp:Label runat="server" ID="name" Font-Bold="true" Font-Size="Large"></asp:Label>

                    <%-- User update success message --%>
                    <div id="divSuccess" class="panel panel-success" runat="server" visible="false">
                        <div id="divSuccessMessage" class="panel-heading" runat="server"></div>
                    </div>

                    <%-- User update failure message --%>
                    <div id="divFailure" class="panel panel-error" runat="server" visible="false">
                        <div id="divFailureMessage" class="panel-heading" runat="server"></div>
                    </div>


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
                            <li id="ManageTab">
                                <a title="Manage_Tab" role="tab" href="#Manage" data-toggle="tab" onclick="tab('Manage');">Manage Bid Proposals
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
                                                        ValidationGroup="UserInfo" Display="Dynamic" ErrorMessage="*Required" runat="server" ForeColor="Red" /></td>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="ftbeFirstName" runat="server"
                                                    TargetControlID="TextBox_FirstName" ValidChars="AaBbCcDdEdFeGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz" />
                                            </tr>

                                            <%-- Last Name --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label1" AssociatedControlID="TextBox_LastName" Text="*Last Name:" runat="server" /></td>
                                                <td style="border: none;">
                                                    <asp:TextBox ID="TextBox_LastName" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="TextBox_LastName"
                                                        ValidationGroup="UserInfo" Display="Dynamic" ErrorMessage="*Required" runat="server" ForeColor="Red" /></td>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="ftbeLastName" runat="server"
                                                    TargetControlID="TextBox_LastName" ValidChars="AaBbCcDdEdFeGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz" />
                                            </tr>

                                            <%-- Address --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label2" AssociatedControlID="TextBox_Address" Text="*Address:" runat="server" />
                                                </td>
                                                <td style="border: none;">
                                                    <asp:TextBox ID="TextBox_Address" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorAddress" ControlToValidate="TextBox_Address"
                                                        ValidationGroup="UserInfo" Display="Dynamic" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>

                                            <%-- City --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label3" AssociatedControlID="TextBox_City" Text="*City:" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_City" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorCity" ControlToValidate="TextBox_City"
                                                        ValidationGroup="UserInfo" Display="Dynamic" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>

                                            <%-- State --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label4" AssociatedControlID="DropDownListState" Text="*State:" runat="server" /></td>
                                                <td>
                                                    <asp:DropDownList ID="DropDownListState" runat="server">
                                                        <asp:ListItem Value="Select">Select</asp:ListItem>
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
                                                    <asp:RequiredFieldValidator InitialValue="Select" ID="RequiredFieldValidator15" Display="Dynamic"
                                                        runat="server" ControlToValidate="DropDownListState" ForeColor="Red"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>

                                            <%-- Zip --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label5" AssociatedControlID="TextBox_Zip" Text="*Zip Code:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Zip" runat="server" placeholder="00000-0000"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvZip" ControlToValidate="TextBox_Zip" Display="Dynamic"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required" ForeColor="Red" />
                                                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="TextBox_Zip"
                                                        MaskType="Number" Mask="99999-9999" MessageValidatorTip="true"
                                                        ClearMaskOnLostFocus="False"></ajaxToolkit:MaskedEditExtender>
                                                </td>
                                            </tr>

                                            <%-- Phone --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label6" AssociatedControlID="TextBox_Telephone" Text="*Primary Phone:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Telephone" runat="server" placeholder="000-000-0000"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvPhone" ControlToValidate="TextBox_Telephone"
                                                        Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="TextBox_Telephone"
                                                        MaskType="Number" Mask="999-999-9999" MessageValidatorTip="true"
                                                        ClearMaskOnLostFocus="False"></ajaxToolkit:MaskedEditExtender>
                                                </td>
                                            </tr>

                                            <%-- Alt Phone --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label7" AssociatedControlID="TextBox_Alternate_Telephone" Text="Alternate Telephone:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Alternate_Telephone" runat="server" placeholder="000-000-0000"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="TextBox_Alternate_Telephone"
                                                        MaskType="Number" Mask="999-999-9999" MessageValidatorTip="true"
                                                        ClearMaskOnLostFocus="False"></ajaxToolkit:MaskedEditExtender>
                                                </td>
                                            </tr>

                                            <%-- Email --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label8" AssociatedControlID="TextBox_Email_Address" Text="*Email:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Email_Address" runat="server" placeholder="myemila@domain.com"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvEmail" ControlToValidate="TextBox_Email_Address" Display="Dynamic"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required" ForeColor="Red" />
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox_Email_Address"
                                                        ValidationGroup="UserInfo" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a valid email address formatted as (name@domain.com)"
                                                        ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$">
                                                    </asp:RegularExpressionValidator>
                                                </td>
                                            </tr>

                                            <%-- Alt Email --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label9" AssociatedControlID="TextBox_Email_Address" Text="Alternate Email Address:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Alternate_Email" runat="server" placeholder="myemail@domain.com"></asp:TextBox></td>
                                            </tr>

                                            <%-- Left: BUTTON - Copy Customer to Job Site Address --%>
                                            <tr>
                                                <td>
                                                    <asp:Button runat="server" ID="same_above" class="btn btn-primary" OnClick="copy" Font-Size="Small" AutoPostBack="true" Text="Jobsite Info same as Above" CausesValidation="false" /></td>
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
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TextBox_Job_Address" Display="Dynamic"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" /></td>
                                            </tr>

                                            <%-- Job Site City --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label11" AssociatedControlID="TextBox_Job_City" Text="*City:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Job_City" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TextBox_Job_City" Display="Dynamic"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" /></td>
                                            </tr>

                                            <%-- Job Site Permitting City/County --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label12" AssociatedControlID="DropDownListState" Text="*Permitting City/County:" runat="server" /></td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="Permit" Width="170">
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
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator InitialValue="Select" ID="RequiredFieldValidator4" Display="Dynamic"
                                                        runat="server" ControlToValidate="Permit" ForeColor="Red"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>

                                            <%-- Job Site Zip Code --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label13" AssociatedControlID="TextBox_Job_Zip" Text="*Zip Code:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Job_Zip" runat="server" placeholder="00000-0000"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvZipCode" ControlToValidate="TextBox_Job_Zip" Display="Dynamic"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required" ForeColor="Red" />
                                                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="TextBox_Job_Zip"
                                                        MaskType="Number" Mask="99999-9999" MessageValidatorTip="true"
                                                        ClearMaskOnLostFocus="False"></ajaxToolkit:MaskedEditExtender>
                                                </td>
                                            </tr>

                                            <%-- Job Site ARB/HOA/Subdivision --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label14" AssociatedControlID="arb" Text="*ARB / HOA / Subdiv:" runat="server" /></td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="arb" Width="170">
                                                        <asp:ListItem Value="Select">Select</asp:ListItem>
                                                        <asp:ListItem Value="Grand">Grand Haven</asp:ListItem>
                                                        <asp:ListItem Value="PalmCoast">Palm Coast Plantation</asp:ListItem>
                                                        <asp:ListItem Value="Plantation">Plantation Bay</asp:ListItem>
                                                        <asp:ListItem Value="Ocean">Ocean Hammock</asp:ListItem>
                                                        <asp:ListItem Value="Dunes">Hammock Dunes</asp:ListItem>
                                                        <asp:ListItem Value="Shores">The Shores</asp:ListItem>
                                                        <asp:ListItem Value="Hidden">Hidden Lakes</asp:ListItem>
                                                        <asp:ListItem Value="North">North Shore</asp:ListItem>
                                                        <asp:ListItem Value="Polo">Polo Club</asp:ListItem>
                                                        <asp:ListItem Value="Island">Island Estates</asp:ListItem>
                                                        <asp:ListItem Value="Tuscana">Tuscana</asp:ListItem>
                                                        <asp:ListItem Value="Other">Other</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator InitialValue="Select" ID="Req_ID"
                                                        runat="server" ControlToValidate="arb" ForeColor="Red"
                                                        Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>

                                            <%-- Job Site Lot Number --%>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="label15" AssociatedControlID="TextBox_Lot" Text="Lot Number:" runat="server" /></td>
                                                <td>
                                                    <asp:TextBox ID="TextBox_Lot" runat="server"></asp:TextBox>
                                                </td>
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
                                            <tr style="width: 20px; height: 30px">
                                                <td>
                                                    <asp:Label runat="server">General Private Notes</asp:Label>
                                                    <asp:TextBox runat="server" ID="Notes" Width="500px" Height="450px" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                                <td></td>
                                            </tr>

                                            <%-- Minimum Access Space --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Minimum Access Space: </asp:Label>
                                                    <asp:TextBox ID="Min_Access_F" runat="server" TextMode="Number" Text="0" Width="40"></asp:TextBox>
                                                    ft.
                                                    <asp:TextBox ID="Min_Access_I" runat="server" TextMode="Number" Text="0" Width="40"></asp:TextBox>
                                                    in.
                                                <br />
                                                    <asp:RequiredFieldValidator ID="rfvMinAccessFeet" ControlToValidate="Min_Access_F"
                                                        Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="* Minimum Access Space Feet Required" runat="server" ForeColor="Red" />
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="rfvMinAccessInches" ControlToValidate="Min_Access_I" Display="Dynamic"
                                                        ValidationGroup="UserInfo" ErrorMessage="* Minimum Access Space Inches Required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>

                                            <%-- Jobsite Distance from HQ --%>
                                            <tr>
                                                <td width="300px">
                                                    <asp:Label runat="server">*Jobsite Distance From HQ (mins): </asp:Label></td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="drop_distance">
                                                        <asp:ListItem Value="Select">Select</asp:ListItem>
                                                        <asp:ListItem Value="34">0-34</asp:ListItem>
                                                        <asp:ListItem Value="45">35-45</asp:ListItem>
                                                        <asp:ListItem Value="60">46-60</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator InitialValue="Select" ID="rfvJobSiteDistanceFromHQ" Display="Dynamic"
                                                        runat="server" ControlToValidate="drop_distance" ForeColor="Red"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>

                                            <%-- Referral to be Paid --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Referral Fee To Be Paid: </asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="Referral" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                    <asp:RequiredFieldValidator ID="rfvReferral" ControlToValidate="Referral"
                                                        Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>
                                            <%-- Referral to be Paid Details --%>
                                            <asp:Panel runat="server" ID="Referral_Div" Style="margin-left: 30px" Visible="false">

                                                <%-- Amount --%>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Amount: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="Referral_Amount" TextMode="Number" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="Referral_Amount"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server"
                                                            TargetControlID="Referral_Amount" ValidChars="1234567890" />
                                                    </td>
                                                </tr>

                                                <%-- Full Name --%>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Full Name: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="Referral_Full" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="Referral_Full"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                    </td>
                                                </tr>

                                                <%-- Address --%>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Address: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="Referral_Address" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="Referral_Address"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                    </td>
                                                </tr>

                                                <%-- City --%>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*City: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="Referral_City" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="Referral_City"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                    </td>
                                                </tr>

                                                <%-- State--%>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*State: </asp:Label></td>
                                                    <td>
                                                        <asp:DropDownList ID="Referral_State" runat="server">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
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
                                                        <asp:RequiredFieldValidator InitialValue="Select" ID="RequiredFieldValidator5" Display="Dynamic"
                                                            runat="server" ControlToValidate="Referral_State" ForeColor="Red"
                                                            ValidationGroup="UserInfo" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>

                                                <%-- Zip Code--%>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Zip Code: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="Referral_Zip" runat="server" placeholder="00000-0000"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="Referral_Zip"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server"
                                                            TargetControlID="Referral_Zip" ValidChars="1234567890()-" />
                                                    </td>
                                                </tr>
                                            </asp:Panel>

                                            <%-- New Home Construction Project: RB Toggle --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*New Home Construction Project: </asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="New_Home" Name="New_Home" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                    <asp:RequiredFieldValidator ID="rfvNewHome" ControlToValidate="New_Home"
                                                        Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>
                                            <%-- New Home Construction: Builder Name--%>
                                            <asp:Panel runat="server" ID="Home_Div" Style="margin-left: 30px" Visible="false">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Builder Name: </asp:Label></td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="New_Home_Builder" OnSelectedIndexChanged="onChanged" AutoPostBack="true">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Other">Other</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator InitialValue="Select" ID="rfvBuilderName" Display="Dynamic"
                                                            runat="server" ControlToValidate="New_Home_Builder" ForeColor="Red"
                                                            ValidationGroup="UserInfo" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <%-- New Home Construction Project: Builder Referral Fee: Fee Amount --%>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Builder Referral Fee Amount: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="Builder_Amount" Width="125"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="Builder_Amount"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="Builder_Amount"
                                                            MaskType="Number" Mask="9,999.99"
                                                            ClearMaskOnLostFocus="True" InputDirection="RightToLeft"
                                                            AcceptNegative="Left"
                                                            DisplayMoney="Left"></ajaxToolkit:MaskedEditExtender>
                                                    </td>
                                                </tr>
                                                <%-- New Home Construction Project: Homeowner Fee Amount --%>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Homeowner Fee Amount: </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="Homeowner_Amount" Width="125"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="Homeowner_Amount"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="Homeowner_Amount"
                                                            MaskType="Number" Mask="9,999.99"
                                                            ClearMaskOnLostFocus="True" InputDirection="RightToLeft"
                                                            AcceptNegative="Left"
                                                            DisplayMoney="Left"></ajaxToolkit:MaskedEditExtender>
                                                    </td>
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
                                                    </asp:RadioButtonList>
                                                    <asp:RequiredFieldValidator ID="rfvAccessLetter" ControlToValidate="Permission_Letter"
                                                        Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                </td>
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
                                                    </asp:RadioButtonList>
                                                    <asp:RequiredFieldValidator ID="rfvHomeownerFurnish" ControlToValidate="Homeowner_Furnish"
                                                        Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>

                                            <%-- Homeowner To Furnish Surveys: Furnished Surveys --%>
                                            <asp:Panel runat="server" ID="Survey_Panel" Style="margin-left: 30px" Visible="false">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Furnished Surveys: </asp:Label></td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="Surveys_Selection">
                                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                                            <asp:ListItem Value="Initial">Initial</asp:ListItem>
                                                            <asp:ListItem Value="Final">Final</asp:ListItem>
                                                            <asp:ListItem Value="Both">Both</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator InitialValue="Select" ID="RequiredFieldValidator13"
                                                            runat="server" ControlToValidate="Surveys_Selection" ForeColor="Red"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                                    </td>
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
                                                    </asp:RadioButtonList>
                                                    <asp:RequiredFieldValidator ID="rfvExistingFence" ControlToValidate="Existing_Fence"
                                                        Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>

                                            <%-- Existing Septic Tank --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Existing Septic Tank:  </asp:Label></td>

                                                <td>
                                                    <asp:RadioButtonList runat="server" ID="Septic_Tank" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                        <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                        <asp:ListItem Value="No">No</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                    <asp:RequiredFieldValidator ID="rfvSepticTank" ControlToValidate="Septic_Tank"
                                                        Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                </td>
                                            </tr>

                                            <%-- Existing Septic Tank: Septic on Survey --%>
                                            <asp:Panel runat="server" ID="Septic_Panel" Style="margin-left: 30px" Visible="false">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server">*Septic On The Survey: </asp:Label></td>
                                                    <td>
                                                        <asp:RadioButtonList runat="server" ID="Septic_Buttons" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="onChanged">
                                                            <asp:ListItem Value="Yes">Yes&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                                            <asp:ListItem Value="No">No</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ControlToValidate="Septic_Buttons"
                                                            Display="Dynamic" ValidationGroup="UserInfo" ErrorMessage="*Required" runat="server" ForeColor="Red" />
                                                    </td>
                                                </tr>
                                            </asp:Panel>

                                            <%-- Waterfill Type --%>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server">*Waterfill type: </asp:Label></td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="DropDownList2">
                                                        <asp:ListItem Value="Select">Select</asp:ListItem>
                                                        <asp:ListItem Value="CityWater">City Water</asp:ListItem>
                                                        <asp:ListItem Value="WellWater">Well Water</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator InitialValue="Select" ID="rfvWaterfillType" Display="Dynamic"
                                                        runat="server" ControlToValidate="DropDownList2" ForeColor="Red"
                                                        ValidationGroup="UserInfo" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>

                                            <%-- Form Buttons --%>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <asp:Button ID="Button1" runat="server" Text="Save Changes" class="btn btn-primary" OnClick="Save" CausesValidation="true" ValidationGroup="UserInfo" />
                                                </td>
                                            </tr>

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>


                        <%-- Tab: Create Bid Proposal --%>
                        <div class="tab-pane fade in" id="Create">
                            <p>
                                Bid Proposal Description: 
                                <asp:TextBox runat="server" ID="bid_prop_desc" Width="50%"></asp:TextBox>
                            </p>
                            <br />

                            <div class="panel panel-primary" style="max-width: 40%;">
                                <div class="panel-heading">
                                    Select the Pool Type below to create a new Bid Proposal
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
                            <%--<asp:Button Width="40%" runat="server" Text="Continue Project" ID="ContinueButton" ForeColor="#2196f3" BackColor="White" OnClick="Continue" />--%>
                        </div>


                        <%-- Tab: Manage Bid Proposals --%>
                        <asp:HiddenField ID="CustomerId" runat="server" />
                        <div class="tab-pane fade in" id="Manage">
                            <h4>Bid Proposals</h4>
                            <p>
                                <asp:GridView ID="GridView_Items" runat="server" CssClass="table table-striped table-bordered table-hover" AllowSorting="True" AutoGenerateColumns="False" OnRowEditing="GridView_Items_RowEditing" OnSelectedIndexChanged="Selected">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" ItemStyle-Width="2%" ItemStyle-CssClass="centered">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" CssClass="centered" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField ControlStyle-CssClass="form-control" DataField="ProjectID" HeaderText="Id (Dev Only)" ItemStyle-Width="12%">
                                            <ControlStyle CssClass="form-control" />
                                        </asp:BoundField>

                                        <asp:BoundField ControlStyle-CssClass="form-control" DataField="ProjectType" HeaderText="Bid Proposal Type" ItemStyle-Width="12%">
                                            <ControlStyle CssClass="form-control" />
                                        </asp:BoundField>
                                        <asp:BoundField ControlStyle-CssClass="form-control" DataField="ProjectName" HeaderText="Bid Proposal Name">
                                            <ControlStyle CssClass="form-control" />
                                        </asp:BoundField>
                                        <asp:BoundField ControlStyle-CssClass="form-control" DataField="ProjectDescription" HeaderText="Bid Proposal Description">
                                            <ControlStyle CssClass="form-control" />
                                        </asp:BoundField>
                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Date Created" ItemStyle-Width="12%">
                                            <ControlStyle CssClass="form-control" />
                                        </asp:BoundField>
                                        <asp:BoundField ControlStyle-CssClass="form-control" HeaderText="Date Last Edited" ItemStyle-Width="12%">
                                            <ControlStyle CssClass="form-control" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <br />

                                <%-- Recall Bid Proposal Form Buttons --%>
                                <p>
                                    <asp:Button runat="server" ID="btnRecall" Text="Recall Bid Proposal" class="btn btn-primary" OnClick="RecallBid" CausesValidation="False" />
                                    <asp:Button runat="server" ID="btnDuplicate" Text="Duplicate Bid Proposal Version" class="btn btn-primary" OnClick="DuplicateBid" CausesValidation="False" />
                                    <asp:Button runat="server" ID="btnSaveMaster" Text="Save As Custom Master Bid" class="btn btn-primary" OnClick="SaveMaster" CausesValidation="False" />
                                </p>
                                <p>
                                </p>
                            </p>
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
                                        <asp:Label Font-Bold="True" runat="server" ID="label_signed" ForeColor="Red">&nbsp;Signed Design</asp:Label>
                                        <asp:Image ID="warning_signed" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_contract" ForeColor="Red">&nbsp;Signed Contract</asp:Label>
                                        <asp:Image ID="warning_contract" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_explanation" ForeColor="Red">&nbsp;Signed Customer Explanation</asp:Label>
                                        <asp:Image ID="warning_explanation" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_sub" ForeColor="Red">&nbsp;Sub Copy Design</asp:Label>
                                        <asp:Image ID="warning_sub" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_survey" ForeColor="Red">&nbsp;Survey Without Pool</asp:Label>
                                        <asp:Image ID="warning_survey" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_mosaic" ForeColor="#9e9e9e" Visible="false">&nbsp;Mosaic Tile Disclaimer</asp:Label>
                                        <asp:Image ID="warning_mosaic" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_contingency" ForeColor="#9e9e9e" Visible="false">&nbsp;Contingency</asp:Label>
                                        <asp:Image ID="warning_contingency" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                </div>
                                <div class="panel-body" style="border: 1px solid #000;">
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_project" ForeColor="Red">&nbsp;Project / Commission Breakdown</asp:Label>
                                        <asp:Image ID="warning_project" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_addendumcomm" ForeColor="#9e9e9e" Visible="false">&nbsp;Addendum Commissions</asp:Label>
                                        <asp:Image ID="warning_addendumcomm" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_tiless" ForeColor="#9e9e9e" Visible="false">&nbsp;Tile Selection Sheet</asp:Label>
                                        <asp:Image ID="warning_titless" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                </div>
                                <div class="panel-body" style="border: 1px solid #000;">
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_tss" ForeColor="Red">&nbsp;Tile Selection Sheet</asp:Label>
                                        <asp:Image ID="warning_tss" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_access" ForeColor="Red">&nbsp;Access Permission Letter</asp:Label>
                                        <asp:Image ID="warning_access" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_surveypool" ForeColor="Red">&nbsp;Survey With Pool</asp:Label>
                                        <asp:Image ID="warning_surveypool" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_tdh" ForeColor="Red">&nbsp;Total Dynamic Head</asp:Label>
                                        <asp:Image ID="warning_tdh" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_warranty" ForeColor="Red">&nbsp;Warranty Deed</asp:Label>
                                        <asp:Image ID="warning_warranty" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_easement" ForeColor="#9e9e9e" Visible="false">&nbsp;Easement Encroachment Form</asp:Label>
                                        <asp:Image ID="warning_easement" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_contingency_release" ForeColor="#9e9e9e" Visible="false">&nbsp;Contingency Release Letter</asp:Label>
                                        <asp:Image ID="warning_contingency_release" runat="server" ImageUrl="../Content/Images/warning.png" Width="23px" CssClass="hidden-phone" Visible="False" />
                                    </p>
                                    <p>
                                        <asp:Label Font-Bold="True" runat="server" ID="label_arb" ForeColor="#9e9e9e" Visible="false">&nbsp;ARB Approval Letter</asp:Label>
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
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="Label20" Text="Add Note" Font-Size="Large" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox runat="server" TextMode="MultiLine" ID="historyNote" Height="70px" Width="1200px"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;&nbsp;</td>
                                        <td>
                                            <asp:Button runat="server" ID="history_button" Text="Add Note" BackColor="#03a9f4" ForeColor="White" Height="40px" OnClick="addNote"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <br />
                            <br />

                            <%-- Customer History Items --%>
                            <asp:Label runat="server" ID="CustomerHistoryTitle" Text="Customer History Notes" Font-Size="Large" />
                            <asp:Panel runat="server" ID="customer_history">
                            </asp:Panel>
                        </div>


                        <%-- Tab: Addendums --%>
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
                                    <asp:ListItem>&nbsp;Signed Contract</asp:ListItem>
                                    <asp:ListItem>&nbsp;Deposit Received $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Physical Folder</asp:ListItem>
                                    <asp:ListItem>&nbsp;PPO Folder / Scans</asp:ListItem>
                                    <asp:ListItem>&nbsp;Sub-Copy Plan</asp:ListItem>
                                    <asp:ListItem>&nbsp;Tile Selections</asp:ListItem>
                                    <asp:ListItem>&nbsp;Permit Applied</asp:ListItem>
                                    <asp:ListItem>&nbsp;Permit Received</asp:ListItem>
                                    <asp:ListItem>&nbsp;Pre Site Checklist</asp:ListItem>
                                    <asp:ListItem>&nbsp;Install Permit Box & Bins</asp:ListItem>
                                    <asp:ListItem>&nbsp;Remove Fence</asp:ListItem>
                                    <asp:ListItem>&nbsp;Cut & Cap Sprinkler Lines</asp:ListItem>
                                    <asp:ListItem>&nbsp;Strip Sod / Form Pool</asp:ListItem>
                                    <asp:ListItem>&nbsp;Dig Wall Footer</asp:ListItem>
                                    <asp:ListItem>&nbsp;Wall Footer Inspection</asp:ListItem>
                                    <asp:ListItem>&nbsp;Pour Wall Footer</asp:ListItem>
                                    <asp:ListItem>&nbsp;Install Block Retaining Wall</asp:ListItem>
                                    <asp:ListItem>&nbsp;Block Wall Inspection</asp:ListItem>
                                    <asp:ListItem>&nbsp;Pour Block Wall</asp:ListItem>
                                    <asp:ListItem>&nbsp;Dig Date</asp:ListItem>
                                    <asp:ListItem>&nbsp;Steel</asp:ListItem>
                                    <asp:ListItem>&nbsp;Excavation Payment Due $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Excavation Payment Received $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Steel Inspection</asp:ListItem>
                                    <asp:ListItem>&nbsp;Pre-Plumbing</asp:ListItem>
                                    <asp:ListItem>&nbsp;Shoot Shell</asp:ListItem>
                                    <asp:ListItem>&nbsp;Shell Payment Due $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Shell Payment Received $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Deck Grade</asp:ListItem>
                                    <asp:ListItem>&nbsp;Plumbing</asp:ListItem>
                                    <asp:ListItem>&nbsp;Set Skimmer / Auto Fill</asp:ListItem>
                                    <asp:ListItem>&nbsp;Install Auto-fill</asp:ListItem>
                                    <asp:ListItem>&nbsp;Drain Line / Chase Line</asp:ListItem>
                                    <asp:ListItem>&nbsp;Tile</asp:ListItem>
                                    <asp:ListItem>&nbsp;Remove Existing Lanai</asp:ListItem>
                                    <asp:ListItem>&nbsp;Install Waterfall</asp:ListItem>
                                    <asp:ListItem>&nbsp;Form Concrete Deck</asp:ListItem>
                                    <asp:ListItem>&nbsp;Tamp / Water Pack</asp:ListItem>
                                    <asp:ListItem>&nbsp;Form Paver Footer</asp:ListItem>
                                    <asp:ListItem>&nbsp;Termite Treat</asp:ListItem>
                                    <asp:ListItem>&nbsp;Deck Inspection</asp:ListItem>
                                    <asp:ListItem>&nbsp;Pour Deck</asp:ListItem>
                                    <asp:ListItem>&nbsp;Pour Paver Footer</asp:ListItem>
                                    <asp:ListItem>&nbsp;Install Pavers</asp:ListItem>
                                    <asp:ListItem>&nbsp;Schedule for Solar</asp:ListItem>
                                    <asp:ListItem>&nbsp;Deck Payment Due $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Deck Payment Received $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Rock Work</asp:ListItem>
                                    <asp:ListItem>&nbsp;Texture Deck / Paint</asp:ListItem>
                                    <asp:ListItem>&nbsp;Screen Enclosure</asp:ListItem>
                                    <asp:ListItem>&nbsp;Equipment Set / Set up Sod Install info w - Customer</asp:ListItem>
                                    <asp:ListItem>&nbsp;Electric</asp:ListItem>
                                    <asp:ListItem>&nbsp;Alarms</asp:ListItem>
                                    <asp:ListItem>&nbsp;Baby Fence</asp:ListItem>
                                    <asp:ListItem>&nbsp;Electric Inspection / Set up Sod Install Info w - Customer</asp:ListItem>
                                    <asp:ListItem>&nbsp;Plaster Pool</asp:ListItem>
                                    <asp:ListItem>&nbsp;Water Truck Fill - Up</asp:ListItem>
                                    <asp:ListItem>&nbsp;Install Solar</asp:ListItem>
                                    <asp:ListItem>&nbsp;Final Grade / Cleanup</asp:ListItem>
                                    <asp:ListItem>&nbsp;Fire Up</asp:ListItem>
                                    <asp:ListItem>&nbsp;Addendum Work Completed</asp:ListItem>
                                    <asp:ListItem>&nbsp;Addendum Payments Due $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;All Addendum Payments Received $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Fill Up Payment Due $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Fill Up Payment Received $$$$$</asp:ListItem>
                                    <asp:ListItem>&nbsp;Replace Fence</asp:ListItem>
                                    <asp:ListItem>&nbsp;Final Clean Pressure Wash</asp:ListItem>
                                    <asp:ListItem>&nbsp;Final Paint After Sod</asp:ListItem>
                                    <asp:ListItem>&nbsp;Walkthru / Punchlist</asp:ListItem>
                                    <asp:ListItem>&nbsp;Punlist Items COMPLETED</asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>


                        <%-- Tab: Warranties --%>
                        <%-- Warranties Grid --%>
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

                            <%-- Warranties Form --%>
                            <div class="col-md-12">
                                <div class="form-horizontal">

                                    <div class="row">
                                        <label for="Company" class="col-sm-2 control-label">*Company</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" ID="Company" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="rfvWarrantyCompany" ControlToValidate="Company"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label for="ProductName" class="col-sm-2 control-label">*Product Name: </label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" ID="ProductName" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator16" ControlToValidate="ProductName"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label for="ModelNumber" class="col-sm-2 control-label">*Model Number: </label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" ID="ModelNumber" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator17" ControlToValidate="ModelNumber"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label for="PartNumber" class="col-sm-2 control-label">*Part Number: </label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" ID="PartNumber" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator18" ControlToValidate="PartNumber"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label for="SerialNumber" class="col-sm-2 control-label">*Serial Number: </label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" ID="SerialNumber" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator19" ControlToValidate="SerialNumber"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label for="DateOfInstall" class="col-sm-2 control-label">*Date of Install: </label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" TextMode="Date" ID="DateOfInstall" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator20" ControlToValidate="DateOfInstall"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label for="FireUpDate" class="col-sm-2 control-label">*Fire Up Date: </label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" TextMode="Date" ID="FireUpDate" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator21" ControlToValidate="FireUpDate"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label for="WarrantyLength" class="col-sm-2 control-label">*Warranty Length: </label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" ID="WarrantyLength" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator22" ControlToValidate="WarrantyLength"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label for="Installer" class="col-sm-2 control-label">*Installer: </label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" ID="Installer" CssClass="warrantyInputPadding" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator23" ControlToValidate="Installer"
                                                ValidationGroup="Warranties" Display="Dynamic" ErrorMessage="*Required" ForeColor="Red" />
                                        </div>
                                    </div>
                                    <br />
                                    <br />

                                    <%-- Add Warranty - ValidationGroup: Warranties --%>
                                    <div class="row">
                                        <asp:Button runat="server" Text="Add Warranty" class="col-sm-2 btn btn-primary" OnClick="AddWarranty" CausesValidation="true" ValidationGroup="Warranties" />
                                        <div class="col-sm-10">
                                            &nbsp;
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <br />
                            <br />
                        </div>
                    </div>

                </div>
                <div style="float: right; padding: 5px; background-color: #FFFFFF; border: 1px solid #e0e0e0; margin: 0;">
                    <asp:Button runat="server" Text="Exit" class="btn btn-primary" Width="160px" Height="40px" OnClick="Exit" CausesValidation="False" />
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

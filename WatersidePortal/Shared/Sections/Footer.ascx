<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="BlackFlib1.Shared.Sections.Footer" %>
<footer class="site-footer">
    <div class="text-center">
        <% Response.Write(DateTime.Now.Year); %> - Rubicon Technical Services, LLC
        <a href="#top" class="go-top">
            <i class="fa fa-angle-up">
            </i>
        </a>
    </div>
</footer>
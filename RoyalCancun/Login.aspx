<%@ Page Title="Login/Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="RoyalCancun.Login" %>

<%@ Register Src="~/UserControls/Login/LoginForm.ascx" TagPrefix="uc4" TagName="LoginForm" %>
<%@ Register Src="~/UserControls/Login/SignUp.ascx" TagPrefix="uc5" TagName="SignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <script src="Scripts/jquery-ui.js"></script>
    <div>
        <div id="loginTabs">
            <ul>
              <li><a href="#logintab">LOGIN</a></li>
              <li><a href="#signuptab">REGISTER</a></li>
            </ul>
            <div id="logintab">
              <uc4:LoginForm runat="server" id="LoginForm" />
            </div>
            <div id="signuptab">
              <uc5:SignUp runat="server" ID="SignUp" />
            </div>
        </div>
    </div>
    <script>
        $(function () {
            $("#loginTabs").tabs();
        });
    </script>
</asp:Content>

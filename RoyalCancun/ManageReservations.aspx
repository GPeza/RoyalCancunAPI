<%@ Page Title="Reservation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageReservations.aspx.cs" Inherits="RoyalCancun.ManageReservations" %>
<%@ Register Src="~/UserControls/ReservationManagement/PlaceReservation.ascx" TagPrefix="uc1" TagName="PlaceReservation" %>
<%@ Register Src="~/UserControls/ReservationManagement/ChangeReservation.ascx" TagPrefix="uc2" TagName="ChangeReservation" %>
<%@ Register Src="~/UserControls/ReservationManagement/MyReservations.ascx" TagPrefix="uc3" TagName="MyReservations" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <script src="Scripts/jquery-ui.js"></script>
    <div class="modalBackground PlaceReservationModal modalHidden" id="PlaceReservationModalBackground"></div>
    <div class="modalContainer  PlaceReservationModal modalHidden" id="PlaceReservationModal">
        <uc1:PlaceReservation runat="server" ID="PlaceReservation" />
    </div>
    <div class="modalBackground ChangeReservationModal modalHidden" id="ChangeReservationModalground"></div>
    <div class="modalContainer ChangeReservationModal modalHidden" id="ChangeReservationModal">
        <uc2:ChangeReservation runat="server" id="ChangeReservation" />
    </div>
    <uc3:MyReservations runat="server" id="MyReservations" />
</asp:Content>

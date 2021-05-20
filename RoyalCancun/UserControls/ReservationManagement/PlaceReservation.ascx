<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PlaceReservation.ascx.cs" Inherits="RoyalCancun.ReservationManagement.PlaceReservation" %>
<div class="row">
    <div>
        <div class="centered"><label>Please select the dates for your reservation</label></div>
        <div class="form-group">
            <label>From</label>
            <input type="text" name="dateStart" id="newReservation_startDate" autocomplete="off" class="form-control" readonly="readonly"/>
            <label>To</label>
            <input type="text" name="dateEnd" id="newReservation_endDate" autocomplete="off" class="form-control" readonly="readonly"/>
        </div>
        <div class="form-group">
            <button type="button" class="btn btn-success" id="newReservation_SubmitButton">Place Reservation</button>
        </div>
        <div class="tinyNote">
            *Your stay can’t be longer than 3 days.
            <br />
            *The room can’t be reserved more than 30 days in advance.
        </div>
    </div>
</div>

<script>
    var curDate = new Date();
    var curDateString = curDate.getFullYear() + "-" + String(curDate.getMonth() + 1).padStart(2, '0') + "-" + String(curDate.getDate()).padStart(2, '0');
    var ocupiedDates;
    $(function () {
        $("#newReservation_SubmitButton").on("click", function () {
            placeReservation();
        });
    });

    function placeReservation() {
        var startDate = $("#newReservation_startDate").val();
        var endDate = $("#newReservation_endDate").val();
        if (startDate != "" && endDate != "") {
            $.ajax({
                type: 'POST',
                url: 'ManageReservations.aspx/CreateReservation',
                data: '{ startDate: "' + startDate + '", endDate: "' + endDate + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    var res = response.d.replace('\"', '').split(';');
                    if (res[0] == 1) {
                        alert(res[1].slice(0, -1));
                        $(".PlaceReservationModal").fadeOut()
                        $("#newReservation_startDate").val("");
                        $("#newReservation_endDate").val("");
                        reloadReservations();
                    } else {
                        alert(res[1].slice(0, -1));
                        $("#newReservation_startDate").val("");
                        $("#newReservation_endDate").val("");
                    }
                },
                error: function (error) {
                    alert(error);
                }
            });
        } else {
            if (startDate == "" && endDate != "") {
                alert("Please select a valid start date for your reservation");
            }
            else {
                if (startDate != "" && endDate == "") {
                    alert("Please select a valid end date for your reservation");
                }
                else {
                    alert("Please select valid dates for your reservation");
                }
            }
        }
    }
    function loadOcupiedDates() {
        $.ajax({
            type: 'POST',
            url: 'ManageReservations.aspx/GetOcupiedDatesNewReservation',
            data: '{ date: "' + curDateString + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                ocupiedDates = response.d.split(',');
            },
            error: function (error) {
                alert(error);
            }
        });

        $("#newReservation_startDate")
            .datepicker({
                dateFormat: "yy/mm/dd",
                minDate: +1,
                maxDate: "+30D",
                numberOfMonths: 2,
                beforeShowDay: function (date) {
                    var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    return [ocupiedDates.indexOf(string) == -1]
                }
            });
        $("#newReservation_startDate").on("change", function () {
            var year = parseInt($(this).val().split("/")[0]);
            var month = parseInt($(this).val().split("/")[1]);
            var day = parseInt($(this).val().split("/")[2]);
            $("#newReservation_endDate").val("");

            var minDate = new Date(year, month - 1, day);
            $("#newReservation_endDate").datepicker("option", "minDate", minDate);

            var middleDate = new Date(year, month - 1, day + 1);
            var strMiddleDate = middleDate.getFullYear() + "-" + String(middleDate.getMonth() + 1).padStart(2, '0') + "-" + String(middleDate.getDate()).padStart(2, '0');
            var maxDate = new Date(year, month - 1, day + 2);
            var strMaxDate = maxDate.getFullYear() + "-" + String(maxDate.getMonth() + 1).padStart(2, '0') + "-" + String(maxDate.getDate()).padStart(2, '0');

            if (ocupiedDates.includes(strMiddleDate)) $("#newReservation_endDate").datepicker("option", "maxDate", minDate);
            else if (ocupiedDates.includes(strMaxDate)) $("#newReservation_endDate").datepicker("option", "maxDate", middleDate);
            else $("#newReservation_endDate").datepicker("option", "maxDate", maxDate);

        });
        $("#newReservation_endDate")
            .datepicker({
                dateFormat: "yy/mm/dd",
                minDate: +2,
                maxDate: "+30D",
                numberOfMonths: 2,
                beforeShowDay: function (date) {
                    var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    return [ocupiedDates.indexOf(string) == -1]
                }
            });
    }
</script>
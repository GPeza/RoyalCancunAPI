<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangeReservation.ascx.cs" Inherits="RoyalCancun.UserControls.ReservationManagement.ChangeReservation" %>
<div class="row">
    <div>
        <div class="centered"><label>Please selecty the new dates for your reservation</label></div>
        <div class="form-group">
            <label>From</label>
            <input type="text" name="dateStart" id="changeReservation_startDate" autocomplete="off" class="form-control" readonly="readonly"/>
            <label>To</label>
            <input type="text" name="dateEnd" id="changeReservation_endDate" autocomplete="off" class="form-control" readonly="readonly"/>
        </div>
        <div class="form-group">
            <input type="hidden" id="idReservationHolder"/>
            <button type="button" class="btn btn-success" id="ChangeReservation_SubmitButton">Change Reservation</button>
        </div>
    </div>
</div>

<script>
    $(function () {
        $("#ChangeReservation_SubmitButton").on("click", function () {
            changeReservation();
        });
    });

    function changeReservation() {
        var idReservation = $("#idReservationHolder").val();
        var startDate = $("#changeReservation_startDate").val();
        var endDate = $("#changeReservation_endDate").val();
        if (startDate != "" && endDate != "") {
            $.ajax({
                type: 'POST',
                url: 'ManageReservations.aspx/ChangeReservations',
                data: '{ idReservation: "' + idReservation+'", startDate: "' + startDate + '", endDate: "' + endDate + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    var res = response.d.replace('\"', '').split(';');
                    if (res[0] == 1) {
                        alert(res[1].slice(0, -1));
                        $(".ChangeReservationModal").fadeOut()
                        $("#changeReservation_startDate").val("");
                        $("#changeReservation_endDate").val("");
                        reloadReservations();
                    } else {
                        alert(res[1].slice(0, -1));
                        $("#changeReservation_startDate").val("");
                        $("#changeReservation_endDate").val("");
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
    function loadOcupiedDatesChange(idReservation) {
        $.ajax({
            type: 'POST',
            url: 'ManageReservations.aspx/GetOcupiedDatesChangeReservation',
            data: '{ date: "' + curDateString + '", idReservation: "'+idReservation+'" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                ocupiedDates = response.d.split(',');
            },
            error: function (error) {
                alert(error);
            }
        });

        $("#changeReservation_startDate")
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
        $("#changeReservation_startDate").on("change", function () {
            var year = parseInt($(this).val().split("/")[0]);
            var month = parseInt($(this).val().split("/")[1]);
            var day = parseInt($(this).val().split("/")[2]);
            $("#changeReservation_endDate").val("");

            var minDate = new Date(year, month - 1, day);
            $("#changeReservation_endDate").datepicker("option", "minDate", minDate);

            var middleDate = new Date(year, month - 1, day + 1);
            var strMiddleDate = middleDate.getFullYear() + "-" + String(middleDate.getMonth() + 1).padStart(2, '0') + "-" + String(middleDate.getDate()).padStart(2, '0');
            var maxDate = new Date(year, month - 1, day + 2);
            var strMaxDate = maxDate.getFullYear() + "-" + String(maxDate.getMonth() + 1).padStart(2, '0') + "-" + String(maxDate.getDate()).padStart(2, '0');

            if (ocupiedDates.includes(strMiddleDate)) $("#changeReservation_endDate").datepicker("option", "maxDate", minDate);
            else if (ocupiedDates.includes(strMaxDate)) $("#changeReservation_endDate").datepicker("option", "maxDate", middleDate);
            else $("#changeReservation_endDate").datepicker("option", "maxDate", maxDate);

        });
        $("#changeReservation_endDate")
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
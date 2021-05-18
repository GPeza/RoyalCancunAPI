<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyReservations.ascx.cs" Inherits="RoyalCancun.UserControls.ReservationManagement.MyReservations" %>
<h2>My Reservations</h2>
<div class="row">
    <div class="">
        <div class="col col-xs-2 col-xs-offset-9">
            <button type="button" class="btn btn-success" id="btnPlaceReservation">Place Reservation</button>
        </div>
    </div>
</div>
<div class="row">
    <div class="col col-xs-10 col-xs-offset-1">
        <table id="myReservationTable">
            <tr>
                <th>Room</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Actions</th>
            </tr>
            <tr>

            </tr>
        </table>
    </div>
</div>
<script>
    $(function () {
        reloadReservations();
    });

    function reloadReservations() {
        $.ajax({
            type: 'POST',
            url: 'ManageReservations.aspx/GetUserReservations',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var res = response.d.replace('"', '');
                updateReservationTable(res);
            },
            error: function (error) {
                alert(error);
            }
        });

        $("#btnPlaceReservation").on("click", function () {
            $(".PlaceReservationModal").fadeIn();
            loadOcupiedDates();
        });
        $("#PlaceReservationModalBackground").on("click", function () {
            $(".PlaceReservationModal").fadeOut()
            $("#newReservation_startDate").val("");
            $("#newReservation_endDate").val("");
        });
        $("#ChangeReservationModalground").on("click", function () {
            $(".ChangeReservationModal").fadeOut()
            $("#changeReservation_startDate").val("");
            $("#changeReservation_endDate").val("");
            $("#idReservationHolder").val("");
        });
    }

    function updateReservationTable(res) {
        var html = '<tr><th>Room</th><th>Start Date</th><th>End Date</th><th>Actions</th></tr>';
        if (res == "\"") {
            html += '<tr class="trWhite center"><td colspan="4" class="noReservationsTable">You have no reservations yet</td></tr>';
            $("#myReservationTable").empty();
            $("#myReservationTable").append(html);
        } else {
            var values = res.split('|');
            for (var x = 0; x < values.length - 1; x++) {
                var value = values[x].split(';');
                if (x % 2 == 0) {
                    html += '<tr class="trWhite">';
                } else {
                    html += '<tr class="trColor">';
                }
                html += '<td>' + value[2] + '</td>';
                html += '<td>' + value[3].substring(0, 10) + '</td>';
                html += '<td>' + value[4].substring(0, 10) + '</td>';
                html += '<td>';
                if (value[5] != "0") {
                    if (value[0] != "0") {
                        html += '<button type="button" class="btn btn-info btnChangeReservation" value="' + value[1] + '">Change Reservation</button>';
                    }
                    html += '<button type = "button" class="btn btn-danger btnCancelReservation" value = "' + value[1] + '" > Cancel Reservation</button>';
                } else {
                    html += '<span class="cancelledReservationMessage">Cancelled</span>'
                }
                html += '</td>';
                html += '</tr>';
            }
            $("#myReservationTable").empty();
            $("#myReservationTable").append(html);

            $(".btnChangeReservation").on("click", function () {
                var idReservation = $(this).val();
                //alert(idReservation);
                $(".ChangeReservationModal").fadeIn();
                loadOcupiedDatesChange(idReservation);
                $("#idReservationHolder").val(idReservation)
            });
            $(".btnCancelReservation").on("click", function () {
                var idReservation = $(this).val();
                cancelReservation(idReservation);
            });
        }
    }

    function cancelReservation(idReservation) {
        $.ajax({
            type: 'POST',
            url: 'ManageReservations.aspx/CancelReservation',
            data: '{ idReservation: "' + idReservation + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var res = response.d.replace('\"', '').split(';');
                if (res[0] == 1) {
                    alert(res[1].slice(0, -1));
                    reloadReservations();
                } else {
                    alert(res[1].slice(0, -1));
                }
            },
            error: function (error) {
                alert(error);
            }
        });
    }
</script>
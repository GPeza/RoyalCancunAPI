<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RoyalCancun._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row" id="wellcomeMessage">
        <span>Wellcome to the Royal Cancún experience!</span>
    </div>
    <br/>
    <div class="row homeBigMessageContainer">
        <hr />
        <span class="homeBigMessage">We are your best option in Cancun</span>
        <hr />
    </div>
    <div class="row homeBigMessageContainer">
        <span class="homeBigMessage">Discover the last room in Cancun</span>
    </div>
    <div class="slideshow-container">
        <div class="mySlides">
          <div class="numbertext">1 / 5</div>
          <img src="res/imgRoyal/room1.jpg" style="width:100%">
        </div>
        <div class="mySlides">
          <div class="numbertext">2 / 5</div>
          <img src="res/imgRoyal/room2.jpg" style="width:100%">
        </div>
        <div class="mySlides">
          <div class="numbertext">3 / 5</div>
          <img src="res/imgRoyal/room3.jpg" style="width:100%">
        </div>
        <div class="mySlides">
          <div class="numbertext">4 / 5</div>
          <img src="res/imgRoyal/room4.jpg" style="width:100%">
        </div>
        <div class="mySlides">
          <div class="numbertext">5 / 5</div>
          <img src="res/imgRoyal/room5.jpg" style="width:100%">
        </div>
        <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
        <a class="next" onclick="plusSlides(1)">&#10095;</a>
    </div>
    <br>
    <div style="text-align:center">
      <span class="dot" onclick="currentSlide(1)"></span> 
      <span class="dot" onclick="currentSlide(2)"></span> 
      <span class="dot" onclick="currentSlide(3)"></span> 
      <span class="dot" onclick="currentSlide(4)"></span> 
      <span class="dot" onclick="currentSlide(5)"></span> 
    </div>
    <hr />
    <div class="row homeBigMessageContainer">
        <span class="homeBigMessage">Check our availability</span>
    </div>
    <div id="homeCalendarContainer"></div>
    <br />
    <div class="tinyNote">
            *Your stay can’t be longer than 3 days.
            <br />
            *The room can’t be reserved more than 30 days in advance.
        </div>

    <script>

        var today = new Date();
        today = new Date(today.getFullYear(), today.getMonth(), today.getDate());
        var ocupiedDates;
        $(function () {
            $.ajax({
                type: 'POST',
                url: 'ManageReservations.aspx/GetOcupiedDatesNewReservation',
                data: '{ date: "' + DateToString(today) + '" }',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    ocupiedDates = response.d.split(',');
                    SetCallendar();
                },
                error: function (error) {
                    alert(error);
                }
            });
        });
        var slideIndex = 1;
        showSlides(slideIndex);

        function plusSlides(n) {
          showSlides(slideIndex += n);
        }

        function currentSlide(n) {
          showSlides(slideIndex = n);
        }

        function showSlides(n) {
          var i;
          var slides = document.getElementsByClassName("mySlides");
          var dots = document.getElementsByClassName("dot");
          if (n > slides.length) {slideIndex = 1}    
          if (n < 1) {slideIndex = slides.length}
          for (i = 0; i < slides.length; i++) {
              slides[i].style.display = "none";  
          }
          for (i = 0; i < dots.length; i++) {
              dots[i].className = dots[i].className.replace(" active", "");
          }
          slides[slideIndex-1].style.display = "block";  
          dots[slideIndex-1].className += " active";
        }

        function SetCallendar() {
            var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
            var tomorrow = new Date(today.getFullYear(), today.getMonth(), today.getDate()+1);
            var lastDay = new Date(today.getFullYear(), today.getMonth(), today.getDate()+30);



            var calendarHTML = "<table class='homeCalendarTable'><caption>" + GetMonthName(today)+"</caption><tr> <th>Mon</th> <th>Tue</th> <th>Wed</th> <th>Thu</th> <th>Fri</th> <th>Sat</th> <th>Sun</th></tr>";
            if (firstDay.getDay > 1) {
                calendarHTML += "<tr>"
            }

            for (x = 1; x < firstDay.getDay(); x++) {
                calendarHTML += "<td class='pastDate'></td>";
            }

            for (var tabDate = firstDay; tabDate < today; tabDate.setDate(tabDate.getDate() + 1)) {
                if (tabDate.getDay() == 1) {
                    calendarHTML += "<tr>"
                }
                calendarHTML += "<td class='pastDate'>" + tabDate.getDate() + "</td>";
                if (tabDate.getDay() == 7) {
                    calendarHTML += "</tr>"
                }
            }

            if (today.getDay() == 1) {
                calendarHTML += "<tr>"
            }
            calendarHTML += "<td class='curDate'>" + today.getDate() + "</td>";
            if (today.getDay() == 7) {
                calendarHTML += "</tr>"
            }

            for (var tabDate = tomorrow; tabDate < lastDay; tabDate.setDate(tabDate.getDate() + 1)) {
                var stringDate = DateToString(tabDate);

                if (tabDate.getDate() == 1) {
                    calendarHTML += "</table><table class='homeCalendarTable'><caption>" + GetMonthName(tabDate) + "</caption><tr> <th>Mon</th> <th>Tue</th> <th>Wed</th> <th>Thu</th> <th>Fri</th> <th>Sat</th> <th>Sun</th></tr>";
                    if (tabDate.getDay > 1) {
                        calendarHTML += "<tr>"
                    }

                    for (x = 1; x < tabDate.getDay(); x++) {
                        calendarHTML += "<td class='pastDate'></td>";
                    }
                }

                if (tabDate.getDay() == 1) {
                    calendarHTML += "<tr>"
                }
                if (ocupiedDates.indexOf(stringDate) == -1) {
                    calendarHTML += "<td class='freeDate'>" + tabDate.getDate() + "</td>";
                } else {
                    calendarHTML += "<td class='ocupiedDate'>" + tabDate.getDate() + "</td>";
                }
                if (tabDate.getDay() == 7) {
                    calendarHTML += "</tr>"
                }
            }

            calendarHTML += "</table>"

            $("#homeCalendarContainer").empty();
            $("#homeCalendarContainer").append(calendarHTML);
        }

        function DateToString(date) {
            var stringDate = date.getFullYear() + "-" + String(date.getMonth() + 1).padStart(2, '0') + "-" + String(date.getDate()).padStart(2, '0');
            return stringDate;
        }
        function GetMonthName(date) {
            const monthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
            ];
            const d = date
            return (monthNames[d.getMonth()]);
        }


    </script>
</asp:Content>

![Image](https://gpezatest.com/Logo_RC_web_sm.png)
# RoyalCancunAPI

This project has been developed as a part of a recruitment process.

*Scenario* 
* This project should manage the very last hotel room in the last hotel in Cancun.
* Using this project you should be able to:
  * Verify the room availability.
  * Place a reservation.
    * A reservation can only be made 30 days in advance maximum.
    * A stay cannot be longer than 3 days.
  * Change a reservation.
  * Cancel a reservation.
* The project data management should be made by API calls.


## Getting started🚀

1. In order to test this project you must download it from the repo [Git Page]: https://github.com/GPeza/RoyalCancunAPI
2. By downloading this repo, you’ll find a **C#** solution with **two** built in projects:
    * RoyalCancun
    * RoyalCancunAPI\
***IMPORTANT: Both projects are needed to run tests.***\
![Image](https://gpezatest.com/solution1.PNG)

### Requirements 📋

* To run this solution you'll only need VisualStudio 2019

## Built with 🛠️

This project was made using:
* C# 
* .Net Core
* HTML5
* JavasCript
* CSS3

The next frameworks and libraries were used:
* [JQuery](https://jquery.com/) - Javascript framework. It was used to optimize the Javascript code.
* [JQueryUI](https://jqueryui.com/) - CSS3 & Javascript (uses JQuery as base). It was used to create smother and smartest UI.
* [Bootstrap](https://getbootstrap.com/) - CSS3 & Javascript. It was used to modernize the UI and make it responsive.

Resourses:
* [Libre Baskerville](https://fonts.google.com/specimen/Libre+Baskerville) - Font familly.

## Tests 📌
* To begin the test we will need to load the solution (With the two projects).\
![Image](https://gpezatest.com/RC_images/solution1.PNG)\
* In order to run them simultaniously, we need to start them manually
***IMPORTANT:* The *RoyalCancunAPI* project should be always ran before *RoyalCancun*.**\
![Image](https://gpezatest.com/RC_images/solution2.PNG) \
***IMPORTANT:* As this is a localhost test, once the project *RoyalCancunAPI* is executed, you'll need to update the port on:**
  * **RoyalCancun/Controllers/APIControllers.cs  line 14 on the instruction**
  ```
  #private string url = @"https://localhost:44384/RoyalCancunAPI/";
  ```
  \
![Image](https://gpezatest.com/solution3.PNG)
\
* After starting both projects, we will be reviewing *RoyalCancun* project.
* The first page you will found will be the home page. [DEMO](https://gpezatest.com/RC_Home.gif).
  * Here you can view the room availavility.
* To be able to place a reservation, you'll need to login or register, therefor you can choos the option on the menu.
* On the login page, you can choose to login to your account or creating a new one. [DEMO](https://gpezatest.com/RC_Login.gif)
* Once loged in you can go to a page on the menu called Reservations.
* On the Reservations page you can admin your reservations. [DEMO](https://gpezatest.com/RC_Reservations.gif)
  * To crean a reservation:
    * Pick the *Place Reservation* button.
    * A modal window will be displayed.
    * Use the integrated calendars to pick a valid date, the calendar will limitate the ocupied dates and follow the limitations (Limitations explained on Scenario).
    * If your order was placed correctly, you'll see a new entry on "My Reservations" table.
  * To change a reservation:
    * Pick the "Change Reservation" of the desired entry on "My Reservations" table.
    * A modal window will be displayed.
    * Use the integrated calendars to pick a new valid date, the calendar will limitate the ocupied dates and follow the limitations (Limitations explained on Scenario).
    * If your order was placed correctly, you'll see an update on the selected entry on "My Reservations" table.
  * To cancel a reservation:
    * Pick the "Cancel Reservation" of the desired entry on "My Reservations" table.
    * The reservation will be cancelated.
    * You'll see an update on the selected entry on "My Reservations" table.


## Author ✒️

* **Gustavo Daniel Peza Méndez** - *Development & Documentation* - [GPeza](https://github.com/GPeza)

## Thanks 🎁

*Special thanks to the Alten team for this opportunity and your time*



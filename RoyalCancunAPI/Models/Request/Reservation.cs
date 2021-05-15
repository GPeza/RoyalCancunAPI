using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RoyalCancunAPI.Models.Request
{
    public class Reservation
    {
        public int idReservation { get; set; }
        public int idRoom { get; set; }
        public int idUser { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public int reservationStatus { get; set; }
    }
}
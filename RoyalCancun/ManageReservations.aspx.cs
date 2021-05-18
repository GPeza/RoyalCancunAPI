using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Services;
using RoyalCancun.Controllers;
using System.Threading.Tasks;
using System.Web;

namespace RoyalCancun
{
    public partial class ManageReservations : System.Web.UI.Page
    {
        int sessionUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["idUser"] = 1;
            if (Session["idUser"] is null)
            {
                Response.Redirect("Default.aspx");
            }
            else {
                sessionUser = Convert.ToInt32(Session["idUser"]) + 1;
            }
        }

        [WebMethod]
        public static string GetOcupiedDatesNewReservation(string date)
        {
            APICalls api = new APICalls();
            return api.GetOcupiedDates(0, date).Result;
        }

        [WebMethod]
        public static string GetOcupiedDatesChangeReservation(string date, int idReservation)
        {
            APICalls api = new APICalls();
            return api.GetOcupiedDates(idReservation, date).Result;
        }


        [WebMethod(EnableSession = true)]
        public static string GetUserReservations()
        {
            APICalls api = new APICalls();
            int sessionUser = Convert.ToInt32(HttpContext.Current.Session["idUser"]);
            return api.GetUserReservations(sessionUser).Result;
        }

        [WebMethod(EnableSession = true)]
        public static string CreateReservation(string startDate, string endDate)
        {
            APICalls api = new APICalls();
            int sessionUser = Convert.ToInt32(HttpContext.Current.Session["idUser"]);
            return api.CreateReservation(sessionUser, startDate, endDate).Result;
        }
        [WebMethod(EnableSession = true)]
        public static string ChangeReservations(int idReservation, string startDate, string endDate)
        {
            APICalls api = new APICalls();
            int sessionUser = Convert.ToInt32(HttpContext.Current.Session["idUser"]);
            return api.ChangeReservation(sessionUser, idReservation,startDate, endDate).Result;
        }
        [WebMethod(EnableSession = true)]
        public static string CancelReservation(int idReservation)
        {
            APICalls api = new APICalls();
            int sessionUser = Convert.ToInt32(HttpContext.Current.Session["idUser"]);
            return api.CancelReservation(sessionUser, idReservation).Result;
        }
    }
}
using System;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class GetOcupiedDatesController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post(RoyalCancunAPI.Models.Request.Reservation r)
        {
            try
            {
                MySQLController my = new MySQLController();
                string cadena = "";
                foreach (string date in my.getOcupiedDates(r.idReservation,r.startDate)) {
                    cadena += date + ",";
                }
                cadena = cadena.Remove(cadena.Length - 1, 1);
                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
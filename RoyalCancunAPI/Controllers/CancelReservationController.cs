using System;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class CancelReservationController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post(RoyalCancunAPI.Models.Request.Reservation r)
        {
            try
            {
                MySQLController my = new MySQLController();
                string cadena = "";
                string date = my.cancelReservation(r.idReservation);
               
                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
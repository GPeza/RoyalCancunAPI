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
                cadena = my.cancelReservation(r.idRoom, r.idUser, r.idReservation);
               
                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
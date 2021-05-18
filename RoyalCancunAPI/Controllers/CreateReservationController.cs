using System;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class CreateReservationController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post(RoyalCancunAPI.Models.Request.Reservation r)
        {
            try
            {
                MySQLController my = new MySQLController();
                string cadena = "";
                cadena = my.createReservation(r.idRoom, r.idUser, r.startDate, r.endDate);

                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
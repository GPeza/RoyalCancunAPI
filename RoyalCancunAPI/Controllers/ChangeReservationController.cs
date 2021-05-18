using System;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class ChangeReservationController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post(RoyalCancunAPI.Models.Request.Reservation r)
        {
            try
            {
                MySQLController my = new MySQLController();
                string cadena = "";
                cadena = my.changeReservation(r.idRoom, r.idUser,r.idReservation, r.startDate, r.endDate);

                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
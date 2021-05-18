using System;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class GetUserReservationsController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post(RoyalCancunAPI.Models.Request.Reservation r)
        {
            try
            {
                MySQLController my = new MySQLController();
                string cadena = my.geUserReservations(r.idUser);
                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
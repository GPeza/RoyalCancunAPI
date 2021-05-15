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
                foreach (string date in my.getOcupiedDates(r.startDate)) {
                    cadena += date + ",";
                }
                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
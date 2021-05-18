using System;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class testDBController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post()
        {
            try
            {
                MySQLController my = new MySQLController();
                string cadena = my.testConnection();

                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
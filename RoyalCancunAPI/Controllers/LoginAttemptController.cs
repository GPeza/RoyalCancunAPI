using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class LoginAttemptController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post(RoyalCancunAPI.Models.Request.User u)
        {
            try
            {
                MySQLController my = new MySQLController();
                string cadena = "";
                cadena = my.loginAttempt(u.userName, u.pw);

                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
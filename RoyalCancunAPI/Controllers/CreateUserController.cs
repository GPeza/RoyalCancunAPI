using System;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class CreateUserController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post(RoyalCancunAPI.Models.Request.User u)
        {
            try
            {
                MySQLController my = new MySQLController();
                string cadena = "";
                cadena = my.createUser(u.userName, u.name, u.lastName, u.pw);

                return Ok(cadena);
            }
            catch (Exception e)
            {
                return Ok(e);
            }

        }
    }
}
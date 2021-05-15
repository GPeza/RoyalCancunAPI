using System;
using System.Web.Http;

namespace RoyalCancunAPI.Controllers
{
    public class RoyalCancunController : ApiController
    {
        [HttpPost]
        public IHttpActionResult Post(RoyalCancunAPI.Models.Request.TestRequest tr)
        {
            try {
                return Ok(tr.tst);
            } catch (Exception e) {
                return Ok(e);
            }
            
        }
    }
}
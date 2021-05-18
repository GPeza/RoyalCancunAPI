using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace RoyalCancun.Controllers
{
    public class Functions
    {
        public string getOcupiedDates()
        {
            string response = "";
            try
            {
                APICalls api = new APICalls();
                var dt = DateTime.Now.ToString("yyyy-MM-dd");
                response = api.GetOcupiedDates(0,dt).Result.Replace("\"", ""); ;

            }
            catch (Exception ex)
            {
                response = ex.ToString();
            }
            return response;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RoyalCancunAPI.Models.Request
{
    public class User
    {
        public int iduser { get; set; }
        public string userName { get; set; }
        public string name { get; set; }
        public string lastName { get; set; }
        public string phone { get; set; }
        public string pw { get; set; }

    }
}
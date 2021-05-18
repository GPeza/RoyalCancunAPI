using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RoyalCancun.Models
{
    public class User
    {
        public int iduser { get; set; }
        public string username { get; set; }
        public string name { get; set; }
        public string lastname { get; set; }
        public string pw { get; set; }

        public User(int iduser, string username, string name, string lastname)
        {
            this.iduser = iduser;
            this.username = username;
            this.name = name;
            this.lastname = lastname;
        }
    }
}
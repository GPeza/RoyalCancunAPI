using System;
using System.Web.Services;
using RoyalCancun.Controllers;
using System.Web;

namespace RoyalCancun
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string GetUserData()
        {
            string response = "0";
            if (HttpContext.Current.Session["idUser"] != null)
            {
                response = "1;";
                response += HttpContext.Current.Session["idUser"] + ";";
                response += HttpContext.Current.Session["username"] + ";";
                response += HttpContext.Current.Session["name"] + ";";
                response += HttpContext.Current.Session["lastName"];
                return response;
            }
            else
            {
                return response;
            }
        }

        [WebMethod]
        public static string LoginAttempt(string username, string pw)
        {
            APICalls api = new APICalls();
            string res = api.LoginAttempt(username, pw).Result.Trim('\\').Trim('"'); 
            var values = res.Split(';');
            if (values[0] == "1") {
                HttpContext.Current.Session["idUser"] = values[1];
                HttpContext.Current.Session["username"] = values[2];
                HttpContext.Current.Session["name"] = values[3];
                HttpContext.Current.Session["lastName"] = values[4];
                //HttpContext.Current.Response.Redirect("~");
            }
            return values[0];
        }

        [WebMethod]
        public static string SignUpUser(string username, string name, string lastName, string pw)
        {
            APICalls api = new APICalls();
            string res = api.SignUpUser(username, name, lastName, pw).Result.Trim('\\').Trim('"');
            var values = res.Split(';');
            if (values[0] == "1")
            {
                HttpContext.Current.Session["idUser"] = values[1];
                HttpContext.Current.Session["username"] = username;
                HttpContext.Current.Session["name"] = name;
                HttpContext.Current.Session["lastName"] = lastName;
                return values[0];
            }
            return res;
        }
    }
}
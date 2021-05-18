using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Net.Http;

namespace RoyalCancun.Controllers
{
    
    public class APICalls
    {
        private string url = @"https://localhost:44384/RoyalCancunAPI/";

        private HttpClient httpClient;

        public string LoginAttempt(string username, string pw)
        {
            string function = string.Format("{0}Login?username={1}&&pw={2}", url, username, pw);
            string result = "";
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(function);
            request.AutomaticDecompression = DecompressionMethods.GZip;

            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (Stream stream = response.GetResponseStream())
            using (StreamReader reader = new StreamReader(stream))
            {
                result = reader.ReadToEnd();
            }
            return result;
        }

        public async Task<string> GetOcupiedDates(int idReservation, string date)
        {
            using (var httpClient = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "idReservation", idReservation.ToString() },
                    { "startDate", date }
                };

                var content = new FormUrlEncodedContent(values);

                var uri = string.Format("{0}getOcupiedDates", url);

                var response = await httpClient.PostAsync(uri, content).ConfigureAwait(continueOnCapturedContext: false); 

                var responseString = await response.Content.ReadAsStringAsync();

                responseString = responseString.Replace("\"", "");
                return responseString;
            }
        }

        public async Task<string> GetUserReservations(int idUser)
        {
            using (var httpClient = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "idUser", idUser.ToString() }
                };

                var content = new FormUrlEncodedContent(values);

                var uri = string.Format("{0}GetUserReservations", url);

                var response = await httpClient.PostAsync(uri, content).ConfigureAwait(continueOnCapturedContext: false);

                var responseString = await response.Content.ReadAsStringAsync();

                return responseString;
            }
        }

        public async Task<string> CreateReservation(int idUser, string startDate, string endDate)
        {
            using (var httpClient = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "idRoom", "1" },
                    { "idUser", idUser.ToString() },
                    { "startDate", startDate },
                    { "endDate", endDate }
                };

                var content = new FormUrlEncodedContent(values);

                var uri = string.Format("{0}CreateReservation", url);

                var response = await httpClient.PostAsync(uri, content).ConfigureAwait(continueOnCapturedContext: false);

                var responseString = await response.Content.ReadAsStringAsync();

                return responseString;
            }
        }
        
        public async Task<string> CancelReservation(int idUser, int idReservation)
        {
            using (var httpClient = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "idRoom", "1" },
                    { "idUser", idUser.ToString() },
                    { "idReservation", idReservation.ToString() }
                };

                var content = new FormUrlEncodedContent(values);

                var uri = string.Format("{0}CancelReservation", url);

                var response = await httpClient.PostAsync(uri, content).ConfigureAwait(continueOnCapturedContext: false);

                var responseString = await response.Content.ReadAsStringAsync();

                return responseString;
            }
        }

        public async Task<string> ChangeReservation(int idUser, int idReservation, string startDate, string endDate)
        {
            using (var httpClient = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "idRoom", "1" },
                    { "idUser", idUser.ToString() },
                    { "idReservation", idReservation.ToString() },
                    { "startDate", startDate },
                    { "endDate", endDate }
                };

                var content = new FormUrlEncodedContent(values);

                var uri = string.Format("{0}ChangeReservation", url);

                var response = await httpClient.PostAsync(uri, content).ConfigureAwait(continueOnCapturedContext: false);

                var responseString = await response.Content.ReadAsStringAsync();

                return responseString;
            }
        }
    }
}

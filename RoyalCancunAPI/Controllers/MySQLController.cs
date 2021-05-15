using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;

namespace RoyalCancunAPI.Controllers
{
    public class MySQLController
    {
        MySqlConnection connection;
        public MySQLController()
        {
            connection = new MySqlConnection("datasource=localhost;port=3306;username=root;password=root");
        private void startConnection()
        {
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        private void endConnection()
        {
            try
            {
                if (connection.State == ConnectionState.Open)
                {
                    connection.Close();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        public List<string> getOcupiedDates(string date)
        {
            List<string> ocupiedDates = new List<string>();
            try
            {


                startConnection();
                var stm = string.Format("CALL cancun_palace.getOcupiedDates(\"{0}\");", date);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ocupiedDates.Add(rdr.GetString(1));
                    ocupiedDates.Add(rdr.GetString(2));
                }
                endConnection();
            }
            catch (Exception e)
            {
                throw (e);
            }
            return ocupiedDates;
        }

        public string createReservation(int idRoom, int idUser, string startDate, string endDate)
        {
            string response = "";
            try
            {
                startConnection();
                var stm = string.Format("CALL cancun_palace.createReservation({0},{1},\"{2}\", \"{3}\");", idRoom, idUser, startDate, endDate);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0);
                    response += rdr.GetString(1);
                }
                endConnection();
            }
            catch (Exception e)
            {
                response = e.ToString();
            }
            return response;
        }

        public string changeReservation(int idReservation, string startDate, string endDate)
        {
            string response = "";
            try
            {
                startConnection();
                var stm = string.Format("CALL cancun_palace.changeReservation({0},\"{1}\", \"{2}\");", idReservation, startDate, endDate);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0);
                    response += rdr.GetString(1);
                }
                endConnection();
            }
            catch (Exception e)
            {
                response = e.ToString();
            }
            return response;
        }

        public string cancelReservation(int idReservation)
        {
            string response = "";
            try
            {
                startConnection();
                var stm = string.Format("CALL cancun_palace.cancelReservation({0});", idReservation);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0);
                    response += rdr.GetString(1);
                }
                endConnection();
            }
            catch (Exception e)
            {
                response = e.ToString();
            }
            return response;
        }
        public string createUser(string userName, string name, string lastname, string phone, string pw)
        {
            string response = "";
            try
            {
                startConnection();
                var stm = string.Format("CALL cancun_palace.createUser({0},{1},{2},{3},{4});", userName, name, lastname, phone, pw);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0);
                    response += rdr.GetString(1);
                }
                endConnection();
            }
            catch (Exception e)
            {
                response = e.ToString();
            }
            return response;
        }

        public string loginAttempt(string userName, string pw)
        {
            string response = "";
            try
            {
                startConnection();
                var stm = string.Format("CALL cancun_palace.loginAttempt({0},{1});", userName, pw);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0);
                    response += rdr.GetString(1);
                }
                endConnection();
            }
            catch (Exception e)
            {
                response = e.ToString();
            }
            return response;
        }


    }
}
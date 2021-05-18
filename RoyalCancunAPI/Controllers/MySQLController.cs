using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;
using RoyalCancunAPI.Business;

namespace RoyalCancunAPI.Controllers
{
    public class MySQLController
    {
        MySqlConnection connection;
        public MySQLController()
        {
            try
            {
                connection = new MySqlConnection("datasource=sql487.main-hosting.eu;port=3306;username=u434370356_gpeza_root;password=9QXh2zYn8ktrdPG!R5Fs");
            }
            catch (Exception e) { 
            
            }
        }
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

        public string testConnection()
        {
            string result = "";
            try {
                startConnection();
                if (connection.State == ConnectionState.Open)
                {
                    result = "connected";
                }
                else {
                    result = "disconnected";
                }
                endConnection();
            } 
            catch (Exception e) {
                result = e.ToString();
            }
            return result;
        }

        public List<string> getOcupiedDates(int idReservation,string date)
        {
            List<string> ocupiedDates = new List<string>();
            Functions f = new Functions();
            try
            {


                startConnection();
                var stm = string.Format("CALL u434370356_royal_cancun.getOcupiedDates({0},\"{1}\");", idReservation,date);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if(rdr.GetInt32(0) == 1)
                    ocupiedDates.AddRange(f.getMiddleDates(rdr.GetString(1), rdr.GetString(2)));
                }
                endConnection();
            }
            catch (Exception e)
            {
                throw (e);
            }
            return ocupiedDates;
        }

        public string geUserReservations(int idUser)
        {
            string response = "";
            Functions f = new Functions();
            try
            {


                startConnection();
                var stm = string.Format("CALL u434370356_royal_cancun.getUserReservations({0});", idUser);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0) + ";"; //Actual
                    response += rdr.GetInt32(1) + ";"; //IdReservation
                    response += rdr.GetString(2) + ";";//Room.Description
                    response += rdr.GetString(3) + ";";//StartDate
                    response += rdr.GetString(4) + ";";//EndDate
                    response += rdr.GetString(5) + "|";//ReservationStatus
                }
                endConnection();
            }
            catch (Exception e)
            {
                throw (e);
            }
            return response;
        }

        public string createReservation(int idRoom, int idUser, string startDate, string endDate)
        {
            string response = "";
            try
            {
                startConnection();
                var stm = string.Format("CALL u434370356_royal_cancun.createReservation({0},{1},\"{2}\", \"{3}\");", idRoom, idUser, startDate, endDate);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0) + ";";
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

        public string changeReservation(int idRoom, int idUser, int idReservation, string startDate, string endDate)
        {
            string response = "";
            try
            {
                startConnection();
                var stm = string.Format("CALL u434370356_royal_cancun.changeReservation({0},{1},{2},\"{3}\", \"{4}\");", idRoom, idUser, idReservation, startDate, endDate);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0) + ";";
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

        public string cancelReservation(int idRoom, int idUser, int idReservation)
        {
            string response = "";
            try
            {
                startConnection();
                var stm = string.Format("CALL u434370356_royal_cancun.cancelReservation({0},{1},{2});", idRoom, idUser, idReservation);
                var cmd = new MySqlCommand(stm, connection);

                MySqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    response += rdr.GetInt32(0) + ";";
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
                var stm = string.Format("CALL u434370356_royal_cancun.createUser({0},{1},{2},{3},{4});", userName, name, lastname, phone, pw);
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
                var stm = string.Format("CALL u434370356_royal_cancun.loginAttempt({0},{1});", userName, pw);
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
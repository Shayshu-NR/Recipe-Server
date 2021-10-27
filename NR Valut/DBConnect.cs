using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace DBConnect
{
    class DBConnect
    {
        private MySqlConnection connect;
        private string server;
        private string database;
        private string uid;
        private string password;

        public DBConnect()
        {
            Initialize();
        }

        private void Initialize()
        {
            server = "localhost";
            database = "nr_vault";
            uid = "root";
            password = "mysql";
            string connectionString = "SERVER=" + server + ";" + "DATABASE=" + database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";
            connect = new MySqlConnection(connectionString);
        }

        private bool OpenConnection()
        {
            try
            {
                connect.Open();
                return true;
            }
            catch (MySqlException e)
            {
                return false;
            }
        }

        private bool CloseConnection()
        {
            try
            {
                connect.Close();

                // Closed connection sucessfully
                return true;
            }
            catch (MySqlException e)
            {
                // Failed to close connection
                return false;
            }
        }

        public bool Insert()
        {
            try
            {
                if (this.OpenConnection())
                {
                    MySqlCommand cmd = new MySqlCommand(query, connect);
                    int res = cmd.ExecuteNonQuery();
                    this.CloseConnection();

                    return res;
                }

                return 0;
            }
            catch (MySqlException e)
            {
                return 0;
            }
        }

        public int Update(string table, List<string> columns, List<string> values, List<string> whereCol, List<string> whereVal, List<string> whereOp)
        {
            try
            {
                if (this.OpenConnection() && columns.Count == values.Count && columns.Count > 0 && values.Count > 0)
                {
                    // Create Update query
                    string query = "UPDATE " + table + " SET ";

                    var updateData = columns.Zip(values, (c, v) => new { columns = c, values = v });
                    foreach (var data in updateData)
                    {
                        query += data.columns + " = '" + data.values + "', ";
                    }

                    query = query.TrimEnd(new Char[] { ' ', ',' });
                    query += " WHERE ";

                    var whereData = whereCol.Zip(whereVal, (c, v) => new { whereCol = c, whereVal = v });
                    var i = 0;
                    foreach (var data in whereData)
                    {
                        query += data.whereCol + whereOp[i] + " " + data.whereVal + " ";
                        i++;
                    }

                    MySqlCommand cmd = new MySqlCommand(query, connect);
                    int res = cmd.ExecuteNonQuery();
                    this.CloseConnection();

                    return res;
                }

                return 0;
            }
            catch (MySqlException e)
            {
                return 0;
            }
        }

        public int Update(string query)
        {
            try
            {
                if (this.OpenConnection())
                {
                    MySqlCommand cmd = new MySqlCommand(query, connect);
                    int res = cmd.ExecuteNonQuery();
                    this.CloseConnection();

                    return res;
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public void Delete()
        {

        }

        public DataTable Select(string query)
        {
            try
            {
                if (this.OpenConnection())
                {
                    MySqlCommand cmd = new MySqlCommand(query, connect);

                    MySqlDataReader dataReader = cmd.ExecuteReader();

                    DataTable data = new DataTable();
                    data.Load(dataReader);

                    dataReader.Close();
                    this.CloseConnection();

                    return data;
                }
                else
                {
                    //Failed to connect to server
                    return new DataTable();
                }
            }
            catch (MySqlException e)
            {
                return new DataTable();
            }
        }

        public int Count(string query)
        {
            DataTable colCount = Select(query);

            if (colCount.Rows.Count > 0)
            {
                return Int32.Parse(colCount.Rows[0].ItemArray[0].ToString());
            }

            return 0;
        }

        public bool CheckLogin(string hashVal, string username)
        {
            string query = "SELECT COUNT(*) AS FoundUsers FROM Users WHERE hash = '" + hashVal + "' AND username = '" + username + "'";

            return Count(query) == 1;
        }
    }
}
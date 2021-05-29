using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace NR_Valut
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static string Login(string username, string password){
            string query = "SELECT username, password, type FROM users WHERE username= '" + username + "' AND password='" + password + "'";
            DBConnect db = new DBConnect();
            List<string>[] dbResp = db.Select(query, 3, new List<string>(new[] { "username", "password", "type" }));
            try
            {
                string respUsername = dbResp[0][0];
                string respPassword = dbResp[1][0];
                string respType = dbResp[2][0];

                // If no exception is caught then the user logged in sucessfully...
                return "{\"Success\" : \"Login sucessful\"}";
            }
            catch (ArgumentOutOfRangeException excp)
            {
                return "{\"Error\" : \"Login failed\"}";
            }
        }

        [WebMethod]
        public static string getUserInfo(string username, string password){
            return "";
        }

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
                catch(MySqlException e)
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
                        return true;
                    }

                    return false;
                }
                catch(MySqlException e)
                {
                    return false;
                }
            }

            public void Update()
            {

            }

            public void Delete()
            {

            }

            public List<string>[] Select(string query, int rowSize, List<string> requestedInfo)
            {
                try
                {
                    if (this.OpenConnection() || rowSize != requestedInfo.Count)
                    {
                        MySqlCommand cmd = new MySqlCommand(query, connect);

                        MySqlDataReader dataReader = cmd.ExecuteReader();

                        List<string>[] data = new List<string>[rowSize];

                        /*
                         data = [[id], [name] ... [rowSize]]
                         */
                        for(int i = 0; i < rowSize; i++)
                        {
                            data[i] = new List<string>();
                        }

                        // Store all the info
                        while (dataReader.Read())
                        {
                            for(int i = 0; i < rowSize; i++)
                            {
                                
                                data[i].Add(dataReader[requestedInfo[i]] + "");
                                
                            }
                        }

                        dataReader.Close();
                        this.CloseConnection();

                        return data;
                    }
                    else
                    {
                        //Failed to connect to server
                        return new List<string>[0];
                    }
                }
                catch(MySqlException e)
                {
                    return new List<string>[0];
                }
            }

            public int Count()
            {
                return 0;
            }
        }
    }
}
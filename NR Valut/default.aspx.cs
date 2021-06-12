using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Text.Json;

namespace NR_Valut
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["loggedIn"] != null)
            {

            }
        }

        [WebMethod]
        public static string Login(string username, string password)
        {
            string query = "SELECT * FROM  users U LEFT JOIN  user_types UT ON U.type = UT.typeid LEFT JOIN  user_info UI ON U.id = UI.iduser_info WHERE U.username= '" + username + "' AND U.password='" + password + "'";
            DBConnect db = new DBConnect();
            List<string> wantedFields = new List<string>(new[] { "id", "username", "password", "datecreated", "lastlogin", "user_type", "user_permision", "recipe_permision", "photo_permision", "email", "verified", "birthday", "language", "phone_number" });
            int size = wantedFields.Count();
            List<string>[] dbResp = db.Select(query, size, wantedFields);
            try
            {
                string respUsername = dbResp[0][0];
                string respPassword = dbResp[1][0];
                string respType = dbResp[2][0];

                // If no exception is caught then the user logged in sucessfully...
                // Make sure to set cookies for later...
                var response = HttpContext.Current.Response;
                if (response.Cookies["userName"] != null)
                {
                    response.Cookies["userName"].Value = respUsername;
                }
                else
                {
                    var userNameCookie = new HttpCookie("userName");
                    userNameCookie.Value = respUsername;
                    response.Cookies.Add(userNameCookie);
                }

                if (response.Cookies["loggedIn"] != null)
                {
                    response.Cookies["loggedIn"].Value = "True";
                }
                else
                {
                    var loggedInCookie = new HttpCookie("loggedIn");
                    loggedInCookie.Value = "True";
                    response.Cookies.Add(loggedInCookie);
                }

                // Send back profile information
                userInfo details = new userInfo(dbResp);
                string jsonResponse = JsonSerializer.Serialize(details);

                // Update the last login date...


                return "{\"Success\" : \"Login sucessful\", \"Info\" : " + jsonResponse   + "}";
            }
            catch (ArgumentOutOfRangeException excp)
            {
                var response = HttpContext.Current.Response;
                if (response.Cookies["userName"] != null)
                {
                    response.Cookies["userName"].Value = "";
                }
                else
                {
                    var userNameCookie = new HttpCookie("userName");
                    userNameCookie.Value = "";
                    response.Cookies.Add(userNameCookie);
                }

                if (response.Cookies["loggedIn"] != null)
                {
                    response.Cookies["loggedIn"].Value = "False";
                }
                else
                {
                    var loggedInCookie = new HttpCookie("loggedIn");
                    loggedInCookie.Value = "False";
                    response.Cookies.Add(loggedInCookie);
                }

                return "{\"Error\" : \"Login failed\"}";
            }
        }

        [WebMethod]
        public static string getUserInfo(string username, string password)
        {
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
                        return true;
                    }

                    return false;
                }
                catch (MySqlException e)
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
                        for (int i = 0; i < rowSize; i++)
                        {
                            data[i] = new List<string>();
                        }

                        // Store all the info
                        while (dataReader.Read())
                        {
                            for (int i = 0; i < rowSize; i++)
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
                catch (MySqlException e)
                {
                    return new List<string>[0];
                }
            }

            public int Count()
            {
                return 0;
            }
        }

        class userInfo
        {
            public string id { get; set; }
            public string username { get; set; }
            public string datecreated { get; set; }
            public string lastlogin { get; set; }
            public string user_type { get; set; }
            public string user_permision { get; set; }
            public string recipe_permision { get; set; }
            public string photo_permision { get; set; }
            public string email { get; set; }
            public string verified { get; set; }
            public string birthday { get; set; }
            public string language { get; set; }
            public string phone_number { get; set; }

            public userInfo(List<string>[] values)
            {
                var vProperties = GetType().GetProperties();
                int i = 0;
                foreach (var props in vProperties)
                {
                    if (props.CanWrite
                     && props.PropertyType.IsPublic
                     && props.PropertyType == typeof(String))
                    {
                        props.SetValue(this, values[i][0], null);
                    }
                    i++;
                }
            }

        }
    }
}
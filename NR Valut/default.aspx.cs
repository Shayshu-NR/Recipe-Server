using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Text.Json;
using Constants;

namespace NR_Valut
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

           
        }

        [WebMethod]
        public static string Login(string username, string password)
        {
            string query = Constants.Query.LoginQuery(username, password);
            DBConnect db = new DBConnect();
            List<string> wantedFields = new List<string>(new[] { "id", "username", "password", "datecreated", "lastlogin", "user_type", "user_permission", "recipe_permission", "photo_permission", "email", "verified", "birthday", "language", "phone_number" });
            int size = wantedFields.Count();
            List<string>[] dbResp = db.Select(query, size, wantedFields);
            try
            {
                string respUsername = dbResp[1][0];
                string respPassword = dbResp[2][0];
                string respType = dbResp[5][0];

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
                List<string> goodToSend = dbResp.Select(s => s[0]).ToList();
                goodToSend.RemoveAt(2);
                userInfo details = new userInfo(goodToSend);
                string jsonResponse = JsonSerializer.Serialize(details);

                //Update the last login date...
                if (db.Update(
                    "users",
                    new List<string>(new[] { "lastlogin" }),
                    new List<string>(new[] { DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") }),
                    new List<string>(new[] { "id" }),
                    new List<string>(new[] { details.id }),
                    new List<string>(new[] { "" })
                ))
                {

                    return "{\"Success\" : \"Login sucessful\", \"Info\" : " + jsonResponse + "}";
                }

                return "{\"Error\" : \"Login failed\"}";

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

            public bool Update(string table, List<string> columns, List<string> values, List<string> whereCol, List<string> whereVal, List<string> whereOp)
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
                            query += data.whereCol + " = '" + data.whereVal + "'" + whereOp[i] + " ";
                            i++;
                        }

                        MySqlCommand cmd = new MySqlCommand(query, connect);
                        cmd.ExecuteNonQuery();
                        this.CloseConnection();

                        return true;
                    }

                    return false;
                }
                catch (MySqlException e)
                {
                    return false;
                }
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
            public string user_permission { get; set; }
            public string recipe_permission { get; set; }
            public string photo_permission { get; set; }
            public string email { get; set; }
            public string verified { get; set; }
            public string birthday { get; set; }
            public string language { get; set; }
            public string phone_number { get; set; }

            public userInfo(List<string> values)
            {
                var vProperties = GetType().GetProperties();
                int i = 0;
                foreach (var props in vProperties)
                {
                    if (props.CanWrite
                     && props.PropertyType.IsPublic
                     && props.PropertyType == typeof(String))
                    {
                        props.SetValue(this, values[i], null);
                    }
                    i++;
                }
            }
        }
    }
}
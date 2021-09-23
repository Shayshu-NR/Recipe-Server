using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Text.Json;
using Newtonsoft;
using System.Data;
using Newtonsoft.Json;
using HashLib;
using System.Text;

namespace NR_Valut
{
    public partial class _default : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            DBConnect db = new DBConnect();

            if(Request.Cookies["password"] != null && Request.Cookies["userName"] != null && Request.Cookies["loggedIn"] != null)
            {
                try
                {
                    bool res = db.CheckLogin(Request.Cookies["password"].Value, Request.Cookies["userName"].Value);
                    switch (res)
                    {
                        case true:
                            DataTable userInfo = AutoLogin(Request.Cookies["userName"].Value, Request.Cookies["password"].Value);

                            try
                            {
                                userID.InnerHtml = userInfo.Rows[0]["id"].ToString();
                                registerDate.InnerHtml = userInfo.Rows[0]["datecreated"].ToString();
                                lastActive.InnerHtml = userInfo.Rows[0]["lastlogin"].ToString();
                                userRole.InnerHtml = userInfo.Rows[0]["user_type"].ToString();
                                birthday.InnerHtml = userInfo.Rows[0]["birthday"].ToString();
                                phone.InnerHtml = userInfo.Rows[0]["phone_number"].ToString();
                                Email.InnerHtml = userInfo.Rows[0]["email"].ToString();
                                infoName.InnerHtml = userInfo.Rows[0]["name"].ToString();
                                userName.InnerHtml = userInfo.Rows[0]["username"].ToString();
                                verifiedCheck.InnerHtml = userInfo.Rows[0]["verified"].ToString();

                                userPermissions.InnerHtml = getPermissionDiv(userInfo.Rows[0]["user_permission"].ToString(), "Users");
                                userRecipes.InnerHtml = getPermissionDiv(userInfo.Rows[0]["recipe_permission"].ToString(), "Recipes");
                                userPhotos.InnerHtml = getPermissionDiv(userInfo.Rows[0]["photo_permission"].ToString(), "Photos");
                            }
                            catch(Exception ex)
                            {
                                Response.Write(ex.Message);
                                return;
                            }

                            return;

                        default:
                            loginContainer.InnerHtml = @"
                            <div class='row justify-content-center align-items-center'>
                                    <form class='col-md-5 card p-3' id='login'>
                                        <h1 class='h3 mb-3 font-weight-normal'>
                                        Login
                                        </h1>

                                        <input type = 'username' class='form-control' placeholder='Username' id='username' required='' autofocus=''>

                                        <br>
                                        <div class='input-group'>
                                        <input type = 'password' class='form-control current-password' placeholder='Password' id='password'
                                            required=''>
                                        <span class='input-group-btn'>
                                            <button class='form-control reveal' type='button'>
                                            <i class='fa fa-eye' aria-hidden='true'></i>
                                            </button>
                                        </span>
                                        </div>
                                        <br>
                                        <button class='btn btn-lg btn-primary btn-block' type='submit'>Sign in</button>
                                    </form>
                            </div>";
                            return;
                    }
                }
                catch
                {
                    return;
                }
            }

            loginContainer.InnerHtml = @"
                            <div class='row justify-content-center align-items-center'>
                                    <form class='col-md-5 card p-3' id='login'>
                                        <h1 class='h3 mb-3 font-weight-normal'>
                                        Login
                                        </h1>

                                        <input type = 'username' class='form-control' placeholder='Username' id='username' required='' autofocus=''>

                                        <br>
                                        <div class='input-group'>
                                        <input type = 'password' class='form-control current-password' placeholder='Password' id='password'
                                            required=''>
                                        <span class='input-group-btn'>
                                            <button class='form-control reveal' type='button'>
                                            <i class='fa fa-eye' aria-hidden='true'></i>
                                            </button>
                                        </span>
                                        </div>
                                        <br>
                                        <button class='btn btn-lg btn-primary btn-block' type='submit'>Sign in</button>
                                    </form>
                            </div>";

        }

        [WebMethod]
        public static string Login(string username, string password)
        {
            Query dbQuery = new Query();

            string query = dbQuery.LoginQuery(username, password);
            DBConnect db = new DBConnect();
            DataTable dbResp = db.Select(query);

            try
            {
                string respUsername = dbResp.Rows[0]["username"].ToString();
                string respPassword = dbResp.Rows[0]["password"].ToString();

                // If no exception is caught then the user logged in sucessfully...
                // Make sure to set cookies for later...
                var response = HttpContext.Current.Response;
                IHash hash = HashFactory.Crypto.CreateMD5();
                var expectedVal = hash.ComputeString(respUsername + respPassword, Encoding.ASCII);
                db.Update(dbQuery.UpdateHash(respUsername, respPassword, expectedVal.ToString()));

                if (response.Cookies["password"] != null)
                {
                    response.Cookies["password"].Value = expectedVal.ToString();
                }
                else
                {
                    var passCookie = new HttpCookie("password");
                    passCookie.Value = expectedVal.ToString();
                    response.Cookies.Add(passCookie);
                }

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
                dbResp.Columns.Remove("password");
                string jsonResponse = JsonConvert.SerializeObject(dbResp);

                //Update the last login date...
                if (db.Update(
                    "users",
                    new List<string>(new[] { "lastlogin" }),
                    new List<string>(new[] { DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") }),
                    new List<string>(new[] { "id" }),
                    new List<string>(new[] { "'" + dbResp.Rows[0]["id"].ToString() + "'"}),
                    new List<string>(new[] { "=" })
                ) > 0)
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

                if(colCount.Rows.Count > 0)
                {
                    return  Int32.Parse(colCount.Rows[0].ItemArray[0].ToString());
                }

                return 0;
            }

            public bool CheckLogin(string hashVal, string username)
            {
                string query = "SELECT COUNT(*) AS FoundUsers FROM Users WHERE hash = '" + hashVal + "' AND username = '" + username + "'";

                return Count(query) == 1;
            }
        }

        public DataTable AutoLogin(string username, string password)
        {
            Query dbQuery = new Query();

            string query = dbQuery.LoginQuery(username, password, true);
            DBConnect db = new DBConnect();
            DataTable dbResp = db.Select(query);

            return dbResp;
        }

        class Query
        {
            public string LoginQuery(string username, string password, bool hash = false)
            {
                return @"
                SELECT 
                    id, 
                    username,
                    name,
                    password, 
                    datecreated, 
                    lastlogin, 
                    user_type, 
                    user_permission, 
                    recipe_permission, 
                    photo_permission,
                    email, 
                    verified, 
                    birthday, 
                    language, 
                    phone_number 
                FROM  users U 
                LEFT JOIN  user_types UT 
                ON U.type = UT.typeid 
                LEFT JOIN  user_info UI 
                ON U.id = UI.iduser_info
                WHERE U.username= '" + username + "' AND " + (hash ? "U.hash" : "U.password") + "='" + password + "'";
            }

            public string UpdateHash(string username, string password, string hash)
            {
                return @"
                UPDATE Users 
                Set hash = '" + hash + @"' 
                WHERE username= '" + username + "' AND password='" + password + "'";
            }
        }

        public string getPermissionDiv(string permission, string sectionName)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<td>" + sectionName + "</td>");

            char[] RWDPermissions = permission.ToCharArray();
            Dictionary<string, string> div =  new Dictionary<string, string>()
                {
                    {"R", "<td><span class=''></span></td>" },
                    {"W", "<td><span class=''></span></td>" },
                    {"D", "<td><span class=''></span></td>" }
                };

            foreach(char c in RWDPermissions)
            {
                try
                {
                    div[c.ToString()] = "<td><span class='fa fa-check text-primary'></span></td>";
                }
                catch
                {
                    
                }
            }
            
            foreach(KeyValuePair<string, string> entry in div)
            {
                sb.Append(entry.Value);
            }

            return sb.ToString();
        }
    }
}
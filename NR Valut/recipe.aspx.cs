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
using System.IO;

namespace NR_Valut
{
    public partial class recipe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string NewRecipeLayout(string name, string structure)
        {
            DBConnect query = new DBConnect();
            string cmd = "INSERT INTO recipe_layouts (layout_name, layout_structure, layout_lastmodified) VALUES ('" + name + "', '" + structure + "', '" + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + "')";
            int res = query.Insert(cmd);

            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("log.txt")))
            {
                Log(cmd, w);
            }

            using (StreamReader r = File.OpenText(HttpContext.Current.Server.MapPath("log.txt")))
            {
                DumpLog(r);
            }

            return "{\"Success\" : " + "\"" + res.ToString() + "\"" + "}";
        }

        public static void Log(string logMessage, TextWriter w)
        {
            w.Write("\r\nLog Entry : ");
            w.WriteLine(DateTime.Now.ToLongDateString());
            w.WriteLine("  :");
            w.WriteLine(logMessage);
            w.WriteLine("-------------------------------");
        }

        public static void DumpLog(StreamReader r)
        {
            string line;
            while ((line = r.ReadLine()) != null)
            {
                Console.WriteLine(line);
            }
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

            public int Insert(string query)
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


        class recipeLayout
        {
            List<recipeComponents> components { get; set; }
        }

        class recipeComponents
        {
            string type { get; set; }
            string subtype { get; set; }
            string label { get; set; }
            string name { get; set; }
            bool access { get; set; }
            bool required { get; set; }
            bool inline { get; set; }
            bool toggle { get; set; }
            List<checkboxValues> values { get; set; }
        }

        class checkboxValues
        {
            string label { get; set; }
            string value { get; set; }
            bool selected { get; set; }
        }

    }
}
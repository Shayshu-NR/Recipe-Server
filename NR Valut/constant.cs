using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Constants
{
    public class Query
    {
        public static string LoginQuery(string username, string password, bool hash = false)
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

        public static string UpdateHash(string username, string password, string hash)
        {
            return @"
                UPDATE Users 
                Set hash = '" + hash + @"' 
                WHERE username= '" + username + "' AND password='" + password + "'";
        }
    }
}


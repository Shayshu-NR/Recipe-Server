using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Constants
{
    public class Query
    {
        public static string LoginQuery(string username, string password)
        {
            return "SELECT id, username, password, datecreated, lastlogin, user_type, user_permision, recipe_permision, photo_permision, email, verified, birthday, language, phone_number FROM  users U LEFT JOIN  user_types UT ON U.type = UT.typeid LEFT JOIN  user_info UI ON U.id = UI.iduser_info WHERE U.username= '" + username + "' AND U.password='" + password + "'";
        }
    }
}


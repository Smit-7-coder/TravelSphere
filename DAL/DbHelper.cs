using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace TravelSphere.DAL
{
    public class DbHelper
    {
        protected readonly string connectionString;

        public DbHelper()
        {
            connectionString = ConfigurationManager
                .ConnectionStrings["TravelSphereDB"]
                .ConnectionString;
        }
    }
}
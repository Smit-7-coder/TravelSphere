using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace TravelSphere
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager
                        .ConnectionStrings["TravelSphereDB"]
                        .ConnectionString;
            using(SqlConnection con = new SqlConnection(cs))
            {
                try
                {
                    con.Open();
                    Response.Write("Databse Connected");
                }
                catch(Exception ex)
                {
                    Response.Write("Connection failed: " + ex.Message);
                }
            }
        }
    }
}
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class Home : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPopularDestinations();

                LoadPopularPackages();
            }
        }


        // =========================================
        // LOAD POPULAR DESTINATIONS
        // =========================================

        private void LoadPopularDestinations()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT TOP 3
                        DestinationId,
                        DestinationName,
                        State,
                        Description,
                        Image
                    FROM Destinations
                    WHERE IsPopular = 1
                    AND IsActive = 1
                    ORDER BY DestinationId";


                SqlCommand cmd = new SqlCommand(query, con);


                SqlDataAdapter da = new SqlDataAdapter(cmd);


                DataTable dt = new DataTable();


                da.Fill(dt);


                rptDestinations.DataSource = dt;

                rptDestinations.DataBind();
            }
        }



        // =========================================
        // LOAD POPULAR PACKAGES
        // =========================================

        private void LoadPopularPackages()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT TOP 3
                        P.PackageId,
                        P.PackageName,
                        P.Description,
                        P.DurationDays,
                        P.AdultPrice,
                        P.PackageImage,

                        D.DestinationName,
                        D.State

                    FROM Packages P

                    INNER JOIN Destinations D
                        ON P.DestinationId = D.DestinationId

                    WHERE P.IsPopular = 1
                    AND P.IsActive = 1

                    ORDER BY P.PackageId";


                SqlCommand cmd = new SqlCommand(query, con);


                SqlDataAdapter da = new SqlDataAdapter(cmd);


                DataTable dt = new DataTable();


                da.Fill(dt);


                rptPackages.DataSource = dt;

                rptPackages.DataBind();
            }
        }
    }
}
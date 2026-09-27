using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class Home : System.Web.UI.Page
    {
        private string connectionString =
            ConfigurationManager
                .ConnectionStrings["TravelSphereDB"]
                .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPopularDestinations();
                LoadPopularPackages();
            }
        }

        private void LoadPopularDestinations()
        {
            string query = @"
                SELECT TOP 6
                    DestinationId,
                    DestinationName,
                    State,
                    Description,
                    Image
                FROM Destinations
                WHERE IsPopular = 1
                AND IsActive = 1
                ORDER BY DestinationId";

            DataTable destinations =
                GetData(query);

            rptDestinations.DataSource =
                destinations;

            rptDestinations.DataBind();
        }

        private void LoadPopularPackages()
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

            DataTable packages =
                GetData(query);

            rptPackages.DataSource =
                packages;

            rptPackages.DataBind();
        }

        private DataTable GetData(string query)
        {
            DataTable table =
                new DataTable();

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    using (SqlDataAdapter adapter =
                           new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(table);
                    }
                }
            }

            return table;
        }
    }
}
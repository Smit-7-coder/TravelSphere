using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class DestinationDetails : System.Web.UI.Page
    {
        private string connectionString =
            ConfigurationManager
                .ConnectionStrings["TravelSphereDB"]
                .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];

                if (string.IsNullOrEmpty(id))
                {
                    Response.Redirect("Home.aspx");
                    return;
                }

                int destinationId;

                if (!int.TryParse(id, out destinationId))
                {
                    Response.Redirect("Home.aspx");
                    return;
                }

                LoadDestination(destinationId);
                LoadPackages(destinationId);
            }
        }

        private void LoadDestination(int destinationId)
        {
            string query = @"
                SELECT
                    DestinationName,
                    State,
                    DestinationType,
                    Description,
                    Image
                FROM Destinations
                WHERE DestinationId = @DestinationId";

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@DestinationId",
                        destinationId);

                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblDestinationName.Text =
                                reader["DestinationName"].ToString();

                            lblState.Text =
                                reader["State"].ToString();

                            lblType.Text =
                                reader["DestinationType"].ToString();

                            lblDescription.Text =
                                reader["Description"].ToString();

                            imgDestination.ImageUrl =
                                "~/Assets/images/" +
                                reader["Image"].ToString();
                        }
                    }
                }
            }
        }

        private void LoadPackages(int destinationId)
        {
            string query = @"
                SELECT
                    PackageId,
                    PackageName,
                    Description,
                    DurationDays,
                    AdultPrice,
                    PackageImage
                FROM Packages
                WHERE DestinationId = @DestinationId
                AND IsActive = 1";

            DataTable packages =
                new DataTable();

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@DestinationId",
                        destinationId);

                    using (SqlDataAdapter adapter =
                           new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(packages);
                    }
                }
            }

            rptPackages.DataSource = packages;
            rptPackages.DataBind();
        }
    }
}
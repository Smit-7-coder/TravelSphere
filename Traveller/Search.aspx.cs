using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class Search : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;

        // Delegate for a search operation
        private delegate void SearchMethod(string searchText);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllResults();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim();

            if (string.IsNullOrEmpty(searchText))
            {
                LoadAllResults();
                lblMessage.Text = "";
                return;
            }

            SearchMethod searchDestination = SearchDestinations;
            SearchMethod searchPackage = SearchPackages;

            searchDestination(searchText);
            searchPackage(searchText);
        }

        private void LoadAllResults()
        {
            LoadDestinations("");
            LoadPackages("");
        }

        private void SearchDestinations(string searchText)
        {
            string query = @"
                SELECT
                    DestinationId,
                    DestinationName,
                    State,
                    Description,
                    Image
                FROM Destinations
                WHERE IsActive = 1
                AND
                (
                    DestinationName LIKE @Search
                    OR State LIKE @Search
                    OR Description LIKE @Search
                )
                ORDER BY DestinationName";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Search",
                        "%" + searchText + "%"
                    );

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        rptDestinations.DataSource = dt;
                        rptDestinations.DataBind();

                        if (dt.Rows.Count == 0)
                        {
                            lblMessage.Text = "No destinations found.";
                        }
                    }
                }
            }
        }

        private void SearchPackages(string searchText)
        {
            string query = @"
                SELECT
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

                WHERE P.IsActive = 1

                AND
                (
                    P.PackageName LIKE @Search
                    OR P.Description LIKE @Search
                    OR D.DestinationName LIKE @Search
                    OR D.State LIKE @Search
                )

                ORDER BY P.PackageName";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Search",
                        "%" + searchText + "%"
                    );

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        rptPackages.DataSource = dt;
                        rptPackages.DataBind();
                    }
                }
            }
        }

        private void LoadDestinations(string searchText)
        {
            SearchDestinations(searchText);
        }

        private void LoadPackages(string searchText)
        {
            SearchPackages(searchText);
        }
    }
}
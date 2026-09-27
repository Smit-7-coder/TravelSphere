using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class PackageDetails : System.Web.UI.Page
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

                int packageId;

                if (!int.TryParse(id, out packageId))
                {
                    Response.Redirect("Home.aspx");
                    return;
                }

                LoadPackage(packageId);
                LoadItinerary(packageId);
            }
        }

        private void LoadPackage(int packageId)
        {
            string query = @"
                SELECT
                    P.PackageImage,
                    P.PackageName,
                    P.Description,
                    P.DurationDays,
                    P.AdultPrice,
                    P.ChildPrice,
                    P.TransportType,
                    P.HotelName,
                    P.RoomType,
                    P.MealsIncluded,
                    P.BestSeason,
                    D.DestinationName,
                    D.State
                FROM Packages P
                INNER JOIN Destinations D
                    ON P.DestinationId = D.DestinationId
                WHERE P.PackageId = @PackageId";

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@PackageId",
                        packageId);

                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            imgPackage.ImageUrl =
                                "~/Assets/images/" +
                                reader["PackageImage"].ToString();

                            lblPackageName.Text =
                                reader["PackageName"].ToString();

                            lblDestination.Text =
                                reader["DestinationName"].ToString()
                                + ", " +
                                reader["State"].ToString();

                            lblDescription.Text =
                                reader["Description"].ToString();

                            lblDuration.Text =
                                reader["DurationDays"].ToString()
                                + " Days";

                            lblAdultPrice.Text =
                                Convert.ToDecimal(
                                    reader["AdultPrice"]
                                ).ToString("N0");

                            lblChildPrice.Text =
                                Convert.ToDecimal(
                                    reader["ChildPrice"]
                                ).ToString("N0");

                            lblTransport.Text =
                                reader["TransportType"].ToString();

                            lblHotel.Text =
                                reader["HotelName"].ToString();

                            lblRoomType.Text =
                                reader["RoomType"].ToString();

                            lblMeals.Text =
                                reader["MealsIncluded"].ToString();

                            lblSeason.Text =
                                reader["BestSeason"].ToString();
                        }
                    }
                }
            }
        }

        private void LoadItinerary(int packageId)
        {
            string query = @"
                SELECT
                    ItineraryId,
                    PackageId,
                    DayNumber,
                    Title,
                    Description
                FROM PackageItinerary
                WHERE PackageId = @PackageId
                ORDER BY DayNumber";

            DataTable itinerary =
                new DataTable();

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@PackageId",
                        packageId);

                    using (SqlDataAdapter adapter =
                           new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(itinerary);
                    }
                }
            }

            rptItinerary.DataSource = itinerary;
            rptItinerary.DataBind();
        }

        protected void btnBookNow_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "Booking.aspx?id=" +
                Request.QueryString["id"]);
        }
    }
}
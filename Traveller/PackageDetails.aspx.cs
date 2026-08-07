using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class PackageDetails : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int packageId = Convert.ToInt32(Request.QueryString["id"]);

                    LoadPackage(packageId);

                    LoadItinerary(packageId);
                }
                else
                {
                    Response.Redirect("Home.aspx");
                }
            }
        }

        private void LoadPackage(int packageId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT
                    P.*,
                    D.DestinationName,
                    D.State
                FROM Packages P
                INNER JOIN Destinations D
                    ON P.DestinationId = D.DestinationId
                WHERE P.PackageId=@PackageId";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@PackageId", packageId);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    imgPackage.ImageUrl =
                        "~/Assets/images/" + reader["PackageImage"].ToString();

                    lblPackageName.Text = reader["PackageName"].ToString();

                    lblDestination.Text =
                        reader["DestinationName"] + ", " +
                        reader["State"];

                    lblDescription.Text = reader["Description"].ToString();

                    lblDuration.Text =
                        reader["DurationDays"] + " Days";

                    lblAdultPrice.Text =
                        Convert.ToDecimal(reader["AdultPrice"]).ToString("N0");

                    lblChildPrice.Text =
                        Convert.ToDecimal(reader["ChildPrice"]).ToString("N0");

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

                reader.Close();
            }
        }

        private void LoadItinerary(int packageId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT *
                FROM PackageItinerary
                WHERE PackageId=@PackageId
                ORDER BY DayNumber";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@PackageId", packageId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rptItinerary.DataSource = dt;

                rptItinerary.DataBind();
            }
        }

        protected void btnBookNow_Click(object sender, EventArgs e)
        {
            Response.Redirect(
                "Booking.aspx?id=" + Request.QueryString["id"]);
        }
    }
}
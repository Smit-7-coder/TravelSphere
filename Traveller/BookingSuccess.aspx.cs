using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class BookingSuccess : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int bookingId;

                if (!int.TryParse(Request.QueryString["id"], out bookingId))
                {
                    Response.Redirect("Home.aspx");
                    return;
                }

                LoadBooking(bookingId);
            }
        }

        private void LoadBooking(int bookingId)
        {
            string query = @"
                SELECT
                    B.BookingId,
                    B.BookingDate,
                    B.TravelDate,
                    B.NumberOfPersons,
                    B.TotalAmount,
                    B.BookingStatus,
                    B.PaymentStatus,

                    P.PackageName,

                    D.DestinationName,
                    D.State

                FROM Bookings B

                INNER JOIN Packages P
                    ON B.PackageId = P.PackageId

                INNER JOIN Destinations D
                    ON P.DestinationId = D.DestinationId

                WHERE B.BookingId = @BookingId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BookingId", bookingId);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            DisplayBookingDetails(reader);
                        }
                        else
                        {
                            Response.Redirect("Home.aspx");
                        }
                    }
                }
            }
        }

        private void DisplayBookingDetails(SqlDataReader reader)
        {
            // Booking ID
            lblBookingId.Text =
                reader["BookingId"].ToString();

            // Package
            lblPackageName.Text =
                reader["PackageName"].ToString();

            // Destination
            lblDestination.Text =
                reader["DestinationName"].ToString()
                + ", "
                + reader["State"].ToString();

            // Travel Date
            DateTime travelDate =
                Convert.ToDateTime(reader["TravelDate"]);

            lblTravelDate.Text =
                travelDate.ToString("dd MMM yyyy");

            // Number of Persons
            lblPersons.Text =
                reader["NumberOfPersons"].ToString();

            // Booking Date
            DateTime bookingDate =
                Convert.ToDateTime(reader["BookingDate"]);

            lblBookingDate.Text =
                bookingDate.ToString("dd MMM yyyy, hh:mm tt");

            // Booking Status
            lblBookingStatus.Text =
                reader["BookingStatus"].ToString();

            // Payment Status
            lblPaymentStatus.Text =
                reader["PaymentStatus"].ToString();

            // Total Amount
            decimal totalAmount =
                Convert.ToDecimal(reader["TotalAmount"]);

            lblTotalAmount.Text =
                totalAmount.ToString("N0");
        }
    }
}
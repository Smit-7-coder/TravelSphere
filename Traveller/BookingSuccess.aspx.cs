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
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("Home.aspx");
                    return;
                }


                if (!int.TryParse(
                    Request.QueryString["id"],
                    out int bookingId))
                {
                    Response.Redirect("Home.aspx");
                    return;
                }


                LoadBooking(bookingId);
            }
        }


        // ==========================================
        // LOAD BOOKING
        // ==========================================

        private void LoadBooking(int bookingId)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
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


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@BookingId",
                    bookingId);


                con.Open();


                SqlDataReader reader =
                    cmd.ExecuteReader();


                if (reader.Read())
                {
                    // ==========================================
                    // BOOKING ID
                    // ==========================================

                    lblBookingId.Text =
                        reader["BookingId"].ToString();


                    // ==========================================
                    // PACKAGE
                    // ==========================================

                    lblPackageName.Text =
                        reader["PackageName"].ToString();


                    // ==========================================
                    // DESTINATION
                    // ==========================================

                    lblDestination.Text =
                        reader["DestinationName"].ToString()
                        + ", "
                        + reader["State"].ToString();


                    // ==========================================
                    // TRAVEL DATE
                    // ==========================================

                    DateTime travelDate =
                        Convert.ToDateTime(
                            reader["TravelDate"]);


                    lblTravelDate.Text =
                        travelDate.ToString(
                            "dd MMM yyyy");


                    // ==========================================
                    // NUMBER OF PERSONS
                    // ==========================================

                    lblPersons.Text =
                        reader["NumberOfPersons"].ToString();


                    // ==========================================
                    // BOOKING DATE
                    // ==========================================

                    DateTime bookingDate =
                        Convert.ToDateTime(
                            reader["BookingDate"]);


                    lblBookingDate.Text =
                        bookingDate.ToString(
                            "dd MMM yyyy, hh:mm tt");


                    // ==========================================
                    // BOOKING STATUS
                    // ==========================================

                    lblBookingStatus.Text =
                        reader["BookingStatus"].ToString();


                    // ==========================================
                    // PAYMENT STATUS
                    // ==========================================

                    lblPaymentStatus.Text =
                        reader["PaymentStatus"].ToString();


                    // ==========================================
                    // TOTAL AMOUNT
                    // ==========================================

                    decimal totalAmount =
                        Convert.ToDecimal(
                            reader["TotalAmount"]);


                    lblTotalAmount.Text =
                        totalAmount.ToString("N0");
                }
                else
                {
                    Response.Redirect("Home.aspx");
                }


                reader.Close();
            }
        }
    }
}
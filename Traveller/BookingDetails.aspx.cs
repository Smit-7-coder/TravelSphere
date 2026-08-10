using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class BookingDetails : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings[
                "TravelSphereDB"
            ].ConnectionString;


        // ==========================================
        // PAGE LOAD
        // ==========================================

        protected void Page_Load(
            object sender,
            EventArgs e)
        {
            if (!IsUserLoggedIn())
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }


            if (!IsPostBack)
            {
                LoadBookingDetails();
            }
        }


        // ==========================================
        // CHECK USER LOGIN
        // ==========================================

        private bool IsUserLoggedIn()
        {
            return Session["UserId"] != null;
        }


        // ==========================================
        // LOAD BOOKING DETAILS
        // ==========================================

        private void LoadBookingDetails()
        {
            // ==========================================
            // GET BOOKING ID
            // ==========================================

            if (!int.TryParse(
                Request.QueryString["id"],
                out int bookingId))
            {
                ShowBookingNotFound();

                return;
            }


            // ==========================================
            // GET USER ID
            // ==========================================

            int userId =
                Convert.ToInt32(
                    Session["UserId"]);


            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                // ==========================================
                // BOOKING QUERY
                // ==========================================

                string query = @"
                    SELECT
                        B.BookingId,
                        B.BookingDate,
                        B.TravelDate,
                        B.NumberOfPersons,
                        B.SpecialRequest,
                        B.PackageAmount,
                        B.TaxAmount,
                        B.TotalAmount,
                        B.BookingStatus,
                        B.PaymentStatus,

                        P.PackageName,
                        P.PackageImage,
                        P.DurationDays,
                        P.AdultPrice,
                        P.ChildPrice,
                        P.Description,

                        D.DestinationName,
                        D.State

                    FROM Bookings B

                    INNER JOIN Packages P
                        ON B.PackageId =
                           P.PackageId

                    INNER JOIN Destinations D
                        ON P.DestinationId =
                           D.DestinationId

                    WHERE B.BookingId = @BookingId
                    AND B.UserId = @UserId";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@BookingId",
                    bookingId);


                cmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);


                con.Open();


                SqlDataReader reader =
                    cmd.ExecuteReader();


                if (reader.Read())
                {
                    // ==========================================
                    // PACKAGE IMAGE
                    // ==========================================

                    imgPackage.ImageUrl =
                        "~/Assets/images/"
                        + reader[
                            "PackageImage"
                        ].ToString();


                    // ==========================================
                    // PACKAGE NAME
                    // ==========================================

                    lblPackageName.Text =
                        reader[
                            "PackageName"
                        ].ToString();


                    // ==========================================
                    // DESTINATION
                    // ==========================================

                    lblDestination.Text =
                        reader[
                            "DestinationName"
                        ].ToString()
                        + ", "
                        + reader[
                            "State"
                        ].ToString();


                    // ==========================================
                    // DESCRIPTION
                    // ==========================================

                    lblPackageDescription.Text =
                        reader[
                            "Description"
                        ].ToString();


                    // ==========================================
                    // DURATION
                    // ==========================================

                    lblDuration.Text =
                        reader[
                            "DurationDays"
                        ].ToString()
                        + " Days";


                    // ==========================================
                    // ADULT PRICE
                    // ==========================================

                    lblAdultPrice.Text =
                        Convert.ToDecimal(
                            reader[
                                "AdultPrice"
                            ]).ToString("N0");


                    // ==========================================
                    // CHILD PRICE
                    // ==========================================

                    lblChildPrice.Text =
                        Convert.ToDecimal(
                            reader[
                                "ChildPrice"
                            ]).ToString("N0");


                    // ==========================================
                    // BOOKING ID
                    // ==========================================

                    lblBookingId.Text =
                        reader[
                            "BookingId"
                        ].ToString();


                    // ==========================================
                    // BOOKING DATE
                    // ==========================================

                    lblBookingDate.Text =
                        Convert.ToDateTime(
                            reader[
                                "BookingDate"
                            ]).ToString(
                                "dd MMM yyyy, hh:mm tt");


                    // ==========================================
                    // TRAVEL DATE
                    // ==========================================

                    DateTime travelDate =
                        Convert.ToDateTime(
                            reader[
                                "TravelDate"
                            ]);


                    lblTravelDate.Text =
                        travelDate.ToString(
                            "dd MMM yyyy");


                    // ==========================================
                    // NUMBER OF PERSONS
                    // ==========================================

                    lblNumberOfPersons.Text =
                        reader[
                            "NumberOfPersons"
                        ].ToString();


                    lblTravellerCount.Text =
                        reader[
                            "NumberOfPersons"
                        ].ToString()
                        + " Travellers";


                    // ==========================================
                    // BOOKING STATUS
                    // ==========================================

                    string bookingStatus =
                        reader[
                            "BookingStatus"
                        ].ToString();


                    lblBookingStatus.Text =
                        bookingStatus;


                    // ==========================================
                    // PAYMENT STATUS
                    // ==========================================

                    string paymentStatus =
                        reader[
                            "PaymentStatus"
                        ].ToString();


                    lblPaymentStatus.Text =
                        paymentStatus;


                    // ==========================================
                    // PACKAGE AMOUNT
                    // ==========================================

                    lblPackageAmount.Text =
                        Convert.ToDecimal(
                            reader[
                                "PackageAmount"
                            ]).ToString("N0");


                    // ==========================================
                    // TAX
                    // ==========================================

                    lblTaxAmount.Text =
                        Convert.ToDecimal(
                            reader[
                                "TaxAmount"
                            ]).ToString("N0");


                    // ==========================================
                    // TOTAL AMOUNT
                    // ==========================================

                    lblTotalAmount.Text =
                        Convert.ToDecimal(
                            reader[
                                "TotalAmount"
                            ]).ToString("N0");


                    // ==========================================
                    // SPECIAL REQUEST
                    // ==========================================

                    string specialRequest =
                        reader[
                            "SpecialRequest"
                        ].ToString();


                    if (string.IsNullOrWhiteSpace(
                        specialRequest))
                    {
                        pnlSpecialRequest.Visible =
                            false;

                        pnlNoSpecialRequest.Visible =
                            true;
                    }
                    else
                    {
                        pnlSpecialRequest.Visible =
                            true;

                        pnlNoSpecialRequest.Visible =
                            false;

                        lblSpecialRequest.Text =
                            Server.HtmlEncode(
                                specialRequest);
                    }


                    // ==========================================
                    // CHECK CANCELLATION ELIGIBILITY
                    // ==========================================

                    CheckCancellationEligibility(
                        travelDate,
                        bookingStatus);


                    // ==========================================
                    // SHOW BOOKING
                    // ==========================================

                    pnlBooking.Visible =
                        true;

                    pnlError.Visible =
                        false;
                }
                else
                {
                    ShowBookingNotFound();

                    reader.Close();

                    return;
                }


                reader.Close();
            }


            // ==========================================
            // LOAD TRAVELLERS
            // ==========================================

            LoadTravellers(bookingId);
        }


        // ==========================================
        // CHECK CANCELLATION ELIGIBILITY
        // ==========================================

        private void CheckCancellationEligibility(
            DateTime travelDate,
            string bookingStatus)
        {
            // ==========================================
            // DEFAULT
            // ==========================================

            pnlCancelBooking.Visible =
                false;


            lblCancelMessage.Text =
                "";


            // ==========================================
            // ALREADY CANCELLED
            // ==========================================

            if (bookingStatus.Equals(
                "Cancelled",
                StringComparison.OrdinalIgnoreCase))
            {
                lblCancelMessage.Text =
                    "This booking has already been cancelled.";

                return;
            }


            // ==========================================
            // ALREADY COMPLETED
            // ==========================================

            if (bookingStatus.Equals(
                "Completed",
                StringComparison.OrdinalIgnoreCase))
            {
                lblCancelMessage.Text =
                    "This trip has already been completed.";

                return;
            }


            // ==========================================
            // TRAVEL DATE HAS ARRIVED OR PASSED
            // ==========================================

            if (travelDate.Date <= DateTime.Today)
            {
                lblCancelMessage.Text =
                    "Cancellation is no longer available because the travel date has arrived or has passed.";

                return;
            }


            // ==========================================
            // CANCELLATION ALLOWED
            // ==========================================

            pnlCancelBooking.Visible =
                true;


            lblCancelMessage.Text =
                "You can cancel this booking before "
                + travelDate.ToString("dd MMM yyyy")
                + ".";
        }


        // ==========================================
        // CANCEL BOOKING
        // ==========================================

        protected void btnCancelBooking_Click(
            object sender,
            EventArgs e)
        {
            // ==========================================
            // CHECK LOGIN
            // ==========================================

            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }


            // ==========================================
            // GET BOOKING ID
            // ==========================================

            if (!int.TryParse(
                Request.QueryString["id"],
                out int bookingId))
            {
                ShowBookingNotFound();

                return;
            }


            // ==========================================
            // GET USER ID
            // ==========================================

            int userId =
                Convert.ToInt32(
                    Session["UserId"]);


            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                // ==========================================
                // CHECK BOOKING
                // ==========================================

                string checkQuery = @"
                    SELECT
                        TravelDate,
                        BookingStatus
                    FROM Bookings
                    WHERE BookingId = @BookingId
                    AND UserId = @UserId";


                SqlCommand checkCmd =
                    new SqlCommand(
                        checkQuery,
                        con);


                checkCmd.Parameters.AddWithValue(
                    "@BookingId",
                    bookingId);


                checkCmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);


                con.Open();


                SqlDataReader reader =
                    checkCmd.ExecuteReader();


                if (!reader.Read())
                {
                    reader.Close();

                    ShowBookingNotFound();

                    return;
                }


                DateTime travelDate =
                    Convert.ToDateTime(
                        reader["TravelDate"]);


                string bookingStatus =
                    reader["BookingStatus"].ToString();


                reader.Close();


                // ==========================================
                // CHECK ALREADY CANCELLED
                // ==========================================

                if (bookingStatus.Equals(
                    "Cancelled",
                    StringComparison.OrdinalIgnoreCase))
                {
                    lblCancelMessage.Text =
                        "This booking has already been cancelled.";

                    pnlCancelBooking.Visible =
                        false;

                    return;
                }


                // ==========================================
                // CHECK COMPLETED
                // ==========================================

                if (bookingStatus.Equals(
                    "Completed",
                    StringComparison.OrdinalIgnoreCase))
                {
                    lblCancelMessage.Text =
                        "This trip has already been completed.";

                    pnlCancelBooking.Visible =
                        false;

                    return;
                }


                // ==========================================
                // CHECK TRAVEL DATE
                // ==========================================

                if (travelDate.Date <= DateTime.Today)
                {
                    lblCancelMessage.Text =
                        "Cancellation is no longer available because the travel date has arrived or has passed.";

                    pnlCancelBooking.Visible =
                        false;

                    return;
                }


                // ==========================================
                // CANCEL BOOKING
                // ==========================================

                string cancelQuery = @"
                    UPDATE Bookings

                    SET BookingStatus = 'Cancelled'

                    WHERE BookingId = @BookingId
                    AND UserId = @UserId
                    AND TravelDate > @Today
                    AND BookingStatus NOT IN
                        ('Cancelled', 'Completed')";


                SqlCommand cancelCmd =
                    new SqlCommand(
                        cancelQuery,
                        con);


                cancelCmd.Parameters.AddWithValue(
                    "@BookingId",
                    bookingId);


                cancelCmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);


                cancelCmd.Parameters.AddWithValue(
                    "@Today",
                    DateTime.Today);


                int rowsAffected =
                    cancelCmd.ExecuteNonQuery();


                // ==========================================
                // SUCCESS
                // ==========================================

                if (rowsAffected > 0)
                {
                    pnlCancelBooking.Visible =
                        false;


                    lblCancelMessage.Text =
                        "Your booking has been cancelled successfully.";


                    lblBookingStatus.Text =
                        "Cancelled";
                }
                else
                {
                    lblCancelMessage.Text =
                        "Unable to cancel the booking. Please try again.";
                }
            }
        }


        // ==========================================
        // LOAD TRAVELLERS
        // ==========================================

        private void LoadTravellers(
            int bookingId)
        {
            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                string query = @"
                    SELECT
                        TravellerId,
                        BookingId,
                        TravellerName,
                        Age,
                        Gender

                    FROM BookingTravellers

                    WHERE BookingId = @BookingId

                    ORDER BY TravellerId ASC";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@BookingId",
                    bookingId);


                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);


                DataTable dt =
                    new DataTable();


                da.Fill(dt);


                // ==========================================
                // BIND TRAVELLERS
                // ==========================================

                rptTravellers.DataSource =
                    dt;


                rptTravellers.DataBind();


                // ==========================================
                // TRAVELLER COUNT
                // ==========================================

                if (dt.Rows.Count > 0)
                {
                    lblTravellerCount.Text =
                        dt.Rows.Count.ToString()
                        + " Travellers";
                }
                else
                {
                    lblTravellerCount.Text =
                        "No Traveller Details";
                }
            }
        }


        // ==========================================
        // BOOKING NOT FOUND
        // ==========================================

        private void ShowBookingNotFound()
        {
            pnlBooking.Visible =
                false;


            pnlError.Visible =
                true;
        }
    }
}
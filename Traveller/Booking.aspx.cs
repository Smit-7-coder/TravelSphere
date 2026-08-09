using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class Booking : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;


        int packageId;


        // ==========================================
        // PAGE LOAD
        // ==========================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(
                Request.QueryString["id"],
                out packageId))
            {
                Response.Redirect("Home.aspx");

                return;
            }


            if (!IsPostBack)
            {
                LoadPackage(packageId);


                // ==========================================
                // GET USER DETAILS FROM SESSION
                // ==========================================

                if (Session["UserId"] != null)
                {
                    LoadUserDetails();
                }
                else
                {
                    Response.Redirect(
                        "~/Account/Login.aspx");

                    return;
                }
            }
        }


        // ==========================================
        // LOAD USER DETAILS
        // ==========================================

        private void LoadUserDetails()
        {
            int userId =
                Convert.ToInt32(
                    Session["UserId"]);


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        FullName,
                        Email,
                        Phone
                    FROM Users
                    WHERE UserId = @UserId";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);


                con.Open();


                SqlDataReader reader =
                    cmd.ExecuteReader();


                if (reader.Read())
                {
                    txtFullName.Text =
                        reader["FullName"].ToString();


                    txtEmail.Text =
                        reader["Email"].ToString();


                    txtPhone.Text =
                        reader["Phone"].ToString();
                }


                reader.Close();
            }
        }


        // ==========================================
        // LOAD PACKAGE
        // ==========================================

        private void LoadPackage(int packageId)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        P.PackageName,
                        P.PackageImage,
                        P.DurationDays,
                        P.AdultPrice,
                        P.ChildPrice,
                        D.DestinationName,
                        D.State
                    FROM Packages P
                    INNER JOIN Destinations D
                        ON P.DestinationId =
                           D.DestinationId
                    WHERE P.PackageId = @PackageId
                    AND P.IsActive = 1";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@PackageId",
                    packageId);


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
                        + reader["PackageImage"].ToString();


                    // ==========================================
                    // PACKAGE NAME
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
                    // DURATION
                    // ==========================================

                    lblDuration.Text =
                        reader["DurationDays"].ToString()
                        + " Days";


                    // ==========================================
                    // ADULT PRICE
                    // ==========================================

                    decimal adultPrice =
                        Convert.ToDecimal(
                            reader["AdultPrice"]);


                    // ==========================================
                    // CHILD PRICE
                    // ==========================================

                    decimal childPrice =
                        Convert.ToDecimal(
                            reader["ChildPrice"]);


                    lblAdultPrice.Text =
                        adultPrice.ToString("N0");


                    lblChildPrice.Text =
                        childPrice.ToString("N0");


                    // ==========================================
                    // PRICE SUMMARY
                    // ==========================================

                    lblAdultSummary.Text =
                        adultPrice.ToString("N0");


                    lblChildSummary.Text =
                        childPrice.ToString("N0");


                    // ==========================================
                    // INITIAL TOTAL
                    // ==========================================

                    lblTotalAmount.Text =
                        adultPrice.ToString("N0");
                }
                else
                {
                    Response.Redirect("Home.aspx");
                }


                reader.Close();
            }
        }


        // ==========================================
        // CONFIRM BOOKING
        // ==========================================

        protected void btnConfirmBooking_Click(
            object sender,
            EventArgs e)
        {
            // ==========================================
            // CHECK PAGE VALIDATION
            // ==========================================

            if (!Page.IsValid)
            {
                return;
            }


            // ==========================================
            // CHECK USER LOGIN
            // ==========================================

            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }


            int userId =
                Convert.ToInt32(
                    Session["UserId"]);


            // ==========================================
            // CHECK TRAVEL DATE
            // ==========================================

            if (!DateTime.TryParse(
                txtTravelDate.Text,
                out DateTime travelDate))
            {
                lblMessage.Text =
                    "Please select a valid travel date.";

                return;
            }


            // ==========================================
            // CHECK PAST DATE
            // ==========================================

            if (travelDate.Date < DateTime.Today)
            {
                lblMessage.Text =
                    "Travel date cannot be in the past.";

                return;
            }


            // ==========================================
            // GET ADULTS
            // ==========================================

            if (!int.TryParse(
                txtAdults.Text,
                out int adults))
            {
                lblMessage.Text =
                    "Please enter a valid number of adults.";

                return;
            }


            // ==========================================
            // GET CHILDREN
            // ==========================================

            if (!int.TryParse(
                txtChildren.Text,
                out int children))
            {
                lblMessage.Text =
                    "Please enter a valid number of children.";

                return;
            }


            // ==========================================
            // VALIDATE ADULTS
            // ==========================================

            if (adults < 1)
            {
                lblMessage.Text =
                    "At least one adult is required.";

                return;
            }


            // ==========================================
            // VALIDATE CHILDREN
            // ==========================================

            if (children < 0)
            {
                lblMessage.Text =
                    "Number of children cannot be negative.";

                return;
            }


            // ==========================================
            // TOTAL TRAVELLERS
            // ==========================================

            int numberOfPersons =
                adults + children;


            // ==========================================
            // GET PACKAGE PRICE
            // ==========================================

            decimal adultPrice = 0;

            decimal childPrice = 0;


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string priceQuery = @"
                    SELECT
                        AdultPrice,
                        ChildPrice
                    FROM Packages
                    WHERE PackageId = @PackageId
                    AND IsActive = 1";


                SqlCommand priceCmd =
                    new SqlCommand(
                        priceQuery,
                        con);


                priceCmd.Parameters.AddWithValue(
                    "@PackageId",
                    packageId);


                con.Open();


                SqlDataReader priceReader =
                    priceCmd.ExecuteReader();


                if (priceReader.Read())
                {
                    adultPrice =
                        Convert.ToDecimal(
                            priceReader["AdultPrice"]);


                    childPrice =
                        Convert.ToDecimal(
                            priceReader["ChildPrice"]);
                }
                else
                {
                    priceReader.Close();

                    lblMessage.Text =
                        "Package not found.";

                    return;
                }


                priceReader.Close();
            }


            // ==========================================
            // CALCULATE PACKAGE AMOUNT
            // ==========================================

            decimal packageAmount =
                (adultPrice * adults)
                +
                (childPrice * children);


            // ==========================================
            // TAX
            // ==========================================

            decimal taxAmount = 0;


            // ==========================================
            // TOTAL AMOUNT
            // ==========================================

            decimal totalAmount =
                packageAmount + taxAmount;


            // ==========================================
            // BOOKING ID
            // ==========================================

            int bookingId = 0;


            // ==========================================
            // DATABASE TRANSACTION
            // ==========================================

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                SqlTransaction transaction =
                    con.BeginTransaction();


                bool transactionCompleted = false;


                try
                {
                    // ==========================================
                    // INSERT BOOKING
                    // ==========================================

                    string bookingQuery = @"
                        INSERT INTO Bookings
                        (
                            UserId,
                            PackageId,
                            BookingDate,
                            TravelDate,
                            NumberOfPersons,
                            SpecialRequest,
                            PackageAmount,
                            TaxAmount,
                            TotalAmount,
                            BookingStatus,
                            PaymentStatus
                        )
                        VALUES
                        (
                            @UserId,
                            @PackageId,
                            @BookingDate,
                            @TravelDate,
                            @NumberOfPersons,
                            @SpecialRequest,
                            @PackageAmount,
                            @TaxAmount,
                            @TotalAmount,
                            @BookingStatus,
                            @PaymentStatus
                        );

                        SELECT SCOPE_IDENTITY();
                    ";


                    SqlCommand bookingCmd =
                        new SqlCommand(
                            bookingQuery,
                            con,
                            transaction);


                    bookingCmd.Parameters.AddWithValue(
                        "@UserId",
                        userId);


                    bookingCmd.Parameters.AddWithValue(
                        "@PackageId",
                        packageId);


                    bookingCmd.Parameters.AddWithValue(
                        "@BookingDate",
                        DateTime.Now);


                    bookingCmd.Parameters.AddWithValue(
                        "@TravelDate",
                        travelDate.Date);


                    bookingCmd.Parameters.AddWithValue(
                        "@NumberOfPersons",
                        numberOfPersons);


                    bookingCmd.Parameters.AddWithValue(
                        "@SpecialRequest",
                        txtSpecialRequest.Text.Trim());


                    bookingCmd.Parameters.AddWithValue(
                        "@PackageAmount",
                        packageAmount);


                    bookingCmd.Parameters.AddWithValue(
                        "@TaxAmount",
                        taxAmount);


                    bookingCmd.Parameters.AddWithValue(
                        "@TotalAmount",
                        totalAmount);


                    bookingCmd.Parameters.AddWithValue(
                        "@BookingStatus",
                        "Pending");


                    bookingCmd.Parameters.AddWithValue(
                        "@PaymentStatus",
                        "Pending");


                    bookingId =
                        Convert.ToInt32(
                            bookingCmd.ExecuteScalar());


                    // ==========================================
                    // INSERT TRAVELLERS
                    // ==========================================

                    for (
                        int i = 1;
                        i <= numberOfPersons;
                        i++)
                    {
                        string travellerName =
                            Request.Form[
                                "TravellerName_" + i];


                        string travellerAgeText =
                            Request.Form[
                                "TravellerAge_" + i];


                        string travellerGender =
                            Request.Form[
                                "TravellerGender_" + i];


                        // ==========================================
                        // VALIDATE NAME
                        // ==========================================

                        if (string.IsNullOrWhiteSpace(
                            travellerName))
                        {
                            throw new Exception(
                                "Please enter the name of Traveller "
                                + i
                                + ".");
                        }


                        // ==========================================
                        // VALIDATE AGE
                        // ==========================================

                        if (!int.TryParse(
                            travellerAgeText,
                            out int travellerAge))
                        {
                            throw new Exception(
                                "Please enter a valid age for Traveller "
                                + i
                                + ".");
                        }


                        if (
                            travellerAge < 1 ||
                            travellerAge > 120)
                        {
                            throw new Exception(
                                "Please enter a valid age for Traveller "
                                + i
                                + ".");
                        }


                        // ==========================================
                        // VALIDATE GENDER
                        // ==========================================

                        if (string.IsNullOrWhiteSpace(
                            travellerGender))
                        {
                            throw new Exception(
                                "Please select gender for Traveller "
                                + i
                                + ".");
                        }


                        // ==========================================
                        // INSERT TRAVELLER
                        // ==========================================

                        string travellerQuery = @"
                            INSERT INTO BookingTravellers
                            (
                                BookingId,
                                TravellerName,
                                Age,
                                Gender
                            )
                            VALUES
                            (
                                @BookingId,
                                @TravellerName,
                                @Age,
                                @Gender
                            )";


                        SqlCommand travellerCmd =
                            new SqlCommand(
                                travellerQuery,
                                con,
                                transaction);


                        travellerCmd.Parameters.AddWithValue(
                            "@BookingId",
                            bookingId);


                        travellerCmd.Parameters.AddWithValue(
                            "@TravellerName",
                            travellerName.Trim());


                        travellerCmd.Parameters.AddWithValue(
                            "@Age",
                            travellerAge);


                        travellerCmd.Parameters.AddWithValue(
                            "@Gender",
                            travellerGender);


                        travellerCmd.ExecuteNonQuery();
                    }


                    // ==========================================
                    // COMMIT TRANSACTION
                    // ==========================================

                    transaction.Commit();


                    transactionCompleted = true;
                }
                catch (Exception ex)
                {
                    // ==========================================
                    // ROLLBACK TRANSACTION
                    // ==========================================

                    if (!transactionCompleted)
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch
                        {
                            // Ignore rollback error.
                        }
                    }


                    lblMessage.Text =
                        ex.Message;


                    return;
                }
            }


            // ==========================================
            // SAVE BOOKING ID
            // ==========================================

            Session["BookingId"] =
                bookingId;


            // ==========================================
            // REDIRECT AFTER TRANSACTION IS CLOSED
            // ==========================================

            Response.Redirect(
                "BookingSuccess.aspx?id="
                + bookingId);
        }
    }
}
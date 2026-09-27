using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class Booking : System.Web.UI.Page
    {
        private string connectionString =
            ConfigurationManager
                .ConnectionStrings["TravelSphereDB"]
                .ConnectionString;

        private int packageId;

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

                if (Session["UserId"] == null)
                {
                    Response.Redirect(
                        "~/Account/Login.aspx");

                    return;
                }

                LoadUserDetails();
            }
        }

        private void LoadUserDetails()
        {
            int userId =
                Convert.ToInt32(Session["UserId"]);

            string query = @"
                SELECT
                    FullName,
                    Email,
                    Phone
                FROM Users
                WHERE UserId = @UserId";

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@UserId",
                        userId);

                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtFullName.Text =
                                reader["FullName"].ToString();

                            txtEmail.Text =
                                reader["Email"].ToString();

                            txtPhone.Text =
                                reader["Phone"].ToString();
                        }
                    }
                }
            }
        }

        private void LoadPackage(int packageId)
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
                    ON P.DestinationId = D.DestinationId
                WHERE P.PackageId = @PackageId
                AND P.IsActive = 1";

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
                            decimal adultPrice =
                                Convert.ToDecimal(
                                    reader["AdultPrice"]);

                            decimal childPrice =
                                Convert.ToDecimal(
                                    reader["ChildPrice"]);

                            imgPackage.ImageUrl =
                                "~/Assets/images/" +
                                reader["PackageImage"].ToString();

                            lblPackageName.Text =
                                reader["PackageName"].ToString();

                            lblDestination.Text =
                                reader["DestinationName"].ToString()
                                + ", " +
                                reader["State"].ToString();

                            lblDuration.Text =
                                reader["DurationDays"].ToString()
                                + " Days";

                            lblAdultPrice.Text =
                                adultPrice.ToString("N0");

                            lblChildPrice.Text =
                                childPrice.ToString("N0");

                            lblAdultSummary.Text =
                                adultPrice.ToString("N0");

                            lblChildSummary.Text =
                                childPrice.ToString("N0");

                            lblTotalAmount.Text =
                                adultPrice.ToString("N0");
                        }
                        else
                        {
                            Response.Redirect("Home.aspx");
                        }
                    }
                }
            }
        }

        protected void btnConfirmBooking_Click(
            object sender,
            EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }

            int userId =
                Convert.ToInt32(Session["UserId"]);

            DateTime travelDate;

            if (!DateTime.TryParse(
                txtTravelDate.Text,
                out travelDate))
            {
                lblMessage.Text =
                    "Please select a valid travel date.";

                return;
            }

            if (travelDate.Date < DateTime.Today)
            {
                lblMessage.Text =
                    "Travel date cannot be in the past.";

                return;
            }

            int adults;

            if (!int.TryParse(
                txtAdults.Text,
                out adults))
            {
                lblMessage.Text =
                    "Please enter a valid number of adults.";

                return;
            }

            int children;

            if (!int.TryParse(
                txtChildren.Text,
                out children))
            {
                lblMessage.Text =
                    "Please enter a valid number of children.";

                return;
            }

            if (adults < 1)
            {
                lblMessage.Text =
                    "At least one adult is required.";

                return;
            }

            if (children < 0)
            {
                lblMessage.Text =
                    "Number of children cannot be negative.";

                return;
            }

            int numberOfPersons =
                adults + children;

            decimal adultPrice;
            decimal childPrice;

            if (!GetPackagePrices(
                packageId,
                out adultPrice,
                out childPrice))
            {
                lblMessage.Text =
                    "Package not found.";

                return;
            }

            decimal packageAmount =
                (adultPrice * adults) +
                (childPrice * children);

            decimal taxAmount = 0;

            decimal totalAmount =
                packageAmount + taxAmount;

            int bookingId;

            if (!SaveBooking(
                userId,
                packageId,
                travelDate,
                numberOfPersons,
                packageAmount,
                taxAmount,
                totalAmount,
                out bookingId))
            {
                return;
            }

            Session["BookingId"] = bookingId;

            Response.Redirect(
                "BookingSuccess.aspx?id=" +
                bookingId);
        }

        private bool GetPackagePrices(
            int packageId,
            out decimal adultPrice,
            out decimal childPrice)
        {
            adultPrice = 0;
            childPrice = 0;

            string query = @"
                SELECT
                    AdultPrice,
                    ChildPrice
                FROM Packages
                WHERE PackageId = @PackageId
                AND IsActive = 1";

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
                        if (!reader.Read())
                        {
                            return false;
                        }

                        adultPrice =
                            Convert.ToDecimal(
                                reader["AdultPrice"]);

                        childPrice =
                            Convert.ToDecimal(
                                reader["ChildPrice"]);

                        return true;
                    }
                }
            }
        }

        private bool SaveBooking(
            int userId,
            int packageId,
            DateTime travelDate,
            int numberOfPersons,
            decimal packageAmount,
            decimal taxAmount,
            decimal totalAmount,
            out int bookingId)
        {
            bookingId = 0;

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();

                SqlTransaction transaction =
                    con.BeginTransaction();

                try
                {
                    bookingId = InsertBooking(
                        con,
                        transaction,
                        userId,
                        packageId,
                        travelDate,
                        numberOfPersons,
                        packageAmount,
                        taxAmount,
                        totalAmount);

                    InsertTravellers(
                        con,
                        transaction,
                        bookingId,
                        numberOfPersons);

                    transaction.Commit();

                    return true;
                }
                catch (Exception ex)
                {
                    try
                    {
                        transaction.Rollback();
                    }
                    catch
                    {
                        // Ignore rollback error.
                    }

                    lblMessage.Text =
                        ex.Message;

                    return false;
                }
            }
        }

        private int InsertBooking(
            SqlConnection con,
            SqlTransaction transaction,
            int userId,
            int packageId,
            DateTime travelDate,
            int numberOfPersons,
            decimal packageAmount,
            decimal taxAmount,
            decimal totalAmount)
        {
            string query = @"
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

                SELECT SCOPE_IDENTITY();";

            using (SqlCommand cmd =
                   new SqlCommand(
                       query,
                       con,
                       transaction))
            {
                cmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);

                cmd.Parameters.AddWithValue(
                    "@PackageId",
                    packageId);

                cmd.Parameters.AddWithValue(
                    "@BookingDate",
                    DateTime.Now);

                cmd.Parameters.AddWithValue(
                    "@TravelDate",
                    travelDate.Date);

                cmd.Parameters.AddWithValue(
                    "@NumberOfPersons",
                    numberOfPersons);

                cmd.Parameters.AddWithValue(
                    "@SpecialRequest",
                    txtSpecialRequest.Text.Trim());

                cmd.Parameters.AddWithValue(
                    "@PackageAmount",
                    packageAmount);

                cmd.Parameters.AddWithValue(
                    "@TaxAmount",
                    taxAmount);

                cmd.Parameters.AddWithValue(
                    "@TotalAmount",
                    totalAmount);

                cmd.Parameters.AddWithValue(
                    "@BookingStatus",
                    "Pending");

                cmd.Parameters.AddWithValue(
                    "@PaymentStatus",
                    "Pending");

                return Convert.ToInt32(
                    cmd.ExecuteScalar());
            }
        }

        private void InsertTravellers(
            SqlConnection con,
            SqlTransaction transaction,
            int bookingId,
            int numberOfPersons)
        {
            for (int i = 1;
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

                if (string.IsNullOrWhiteSpace(
                    travellerName))
                {
                    throw new Exception(
                        "Please enter the name of Traveller "
                        + i + ".");
                }

                int travellerAge;

                if (!int.TryParse(
                    travellerAgeText,
                    out travellerAge))
                {
                    throw new Exception(
                        "Please enter a valid age for Traveller "
                        + i + ".");
                }

                if (travellerAge < 1 ||
                    travellerAge > 120)
                {
                    throw new Exception(
                        "Please enter a valid age for Traveller "
                        + i + ".");
                }

                if (string.IsNullOrWhiteSpace(
                    travellerGender))
                {
                    throw new Exception(
                        "Please select gender for Traveller "
                        + i + ".");
                }

                string query = @"
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

                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con,
                           transaction))
                {
                    cmd.Parameters.AddWithValue(
                        "@BookingId",
                        bookingId);

                    cmd.Parameters.AddWithValue(
                        "@TravellerName",
                        travellerName.Trim());

                    cmd.Parameters.AddWithValue(
                        "@Age",
                        travellerAge);

                    cmd.Parameters.AddWithValue(
                        "@Gender",
                        travellerGender);

                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
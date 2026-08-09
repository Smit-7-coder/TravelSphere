using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class MyTrips : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("~/Account/Login.aspx");
                    return;
                }

                LoadUpcomingTrips();

                LoadPreviousTrips();
            }
        }


        // ==========================================
        // UPCOMING TRIPS
        // ==========================================

        private void LoadUpcomingTrips()
        {
            int userId =
                Convert.ToInt32(Session["UserId"]);


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        B.BookingId,
                        B.TravelDate,
                        B.NumberOfPersons,
                        B.TotalAmount,
                        B.BookingStatus,

                        P.PackageName,
                        P.PackageImage,

                        D.DestinationName,
                        D.State

                    FROM Bookings B

                    INNER JOIN Packages P
                        ON B.PackageId = P.PackageId

                    INNER JOIN Destinations D
                        ON P.DestinationId = D.DestinationId

                    WHERE B.UserId = @UserId
                    AND B.TravelDate >= CAST(GETDATE() AS DATE)

                    ORDER BY B.TravelDate ASC";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);


                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);


                DataTable dt =
                    new DataTable();


                da.Fill(dt);


                rptUpcomingTrips.DataSource = dt;

                rptUpcomingTrips.DataBind();


                if (dt.Rows.Count == 0)
                {
                    pnlUpcomingEmpty.Visible = true;
                }
                else
                {
                    pnlUpcomingEmpty.Visible = false;
                }
            }
        }


        // ==========================================
        // PREVIOUS TRIPS
        // ==========================================

        private void LoadPreviousTrips()
        {
            int userId =
                Convert.ToInt32(Session["UserId"]);


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        B.BookingId,
                        B.TravelDate,
                        B.NumberOfPersons,
                        B.TotalAmount,
                        B.BookingStatus,

                        P.PackageName,
                        P.PackageImage,

                        D.DestinationName,
                        D.State

                    FROM Bookings B

                    INNER JOIN Packages P
                        ON B.PackageId = P.PackageId

                    INNER JOIN Destinations D
                        ON P.DestinationId = D.DestinationId

                    WHERE B.UserId = @UserId
                    AND B.TravelDate < CAST(GETDATE() AS DATE)

                    ORDER BY B.TravelDate DESC";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);


                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);


                DataTable dt =
                    new DataTable();


                da.Fill(dt);


                rptPreviousTrips.DataSource = dt;

                rptPreviousTrips.DataBind();


                if (dt.Rows.Count == 0)
                {
                    pnlPreviousEmpty.Visible = true;
                }
                else
                {
                    pnlPreviousEmpty.Visible = false;
                }
            }
        }
    }
}
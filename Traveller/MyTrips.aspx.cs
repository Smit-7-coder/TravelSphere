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

        private void LoadUpcomingTrips()
        {
            LoadTrips(
                "B.TravelDate >= CAST(GETDATE() AS DATE)",
                "B.TravelDate ASC",
                rptUpcomingTrips,
                pnlUpcomingEmpty
            );
        }

        private void LoadPreviousTrips()
        {
            LoadTrips(
                "B.TravelDate < CAST(GETDATE() AS DATE)",
                "B.TravelDate DESC",
                rptPreviousTrips,
                pnlPreviousEmpty
            );
        }

        private void LoadTrips(
            string dateCondition,
            string sortOrder,
            System.Web.UI.WebControls.Repeater repeater,
            System.Web.UI.WebControls.Panel emptyPanel)
        {
            int userId = Convert.ToInt32(Session["UserId"]);

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
                AND " + dateCondition + @"

                ORDER BY " + sortOrder;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        repeater.DataSource = dt;
                        repeater.DataBind();

                        emptyPanel.Visible = dt.Rows.Count == 0;
                    }
                }
            }
        }
    }
}
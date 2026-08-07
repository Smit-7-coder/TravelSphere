using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class DestinationDetails : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check DestinationId in URL
                if (Request.QueryString["id"] != null)
                {
                    int destinationId = Convert.ToInt32(Request.QueryString["id"]);

                    LoadDestination(destinationId);

                    LoadPackages(destinationId);
                }
                else
                {
                    Response.Redirect("Home.aspx");
                }
            }
        }


        // ==========================================
        // LOAD DESTINATION DETAILS
        // ==========================================

        private void LoadDestination(int destinationId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT *
                    FROM Destinations
                    WHERE DestinationId=@DestinationId";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@DestinationId", destinationId);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblDestinationName.Text = reader["DestinationName"].ToString();

                    lblState.Text = reader["State"].ToString();

                    lblType.Text = reader["DestinationType"].ToString();

                    lblDescription.Text = reader["Description"].ToString();

                    imgDestination.ImageUrl =
                        "~/Assets/images/" + reader["Image"].ToString();
                }

                reader.Close();
            }
        }



        // ==========================================
        // LOAD PACKAGES
        // ==========================================

        private void LoadPackages(int destinationId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT *
                    FROM Packages
                    WHERE DestinationId=@DestinationId
                    AND IsActive=1";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@DestinationId", destinationId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rptPackages.DataSource = dt;

                rptPackages.DataBind();
            }
        }
    }
}
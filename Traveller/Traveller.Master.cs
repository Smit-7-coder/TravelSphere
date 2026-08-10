using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class TravellerMaster : System.Web.UI.MasterPage
    {
        // ==========================================
        // DATABASE CONNECTION
        // ==========================================

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
            // ==========================================
            // CHECK USER LOGIN
            // ==========================================

            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }


            // ==========================================
            // CHECK USER ROLE
            // ==========================================

            if (Session["Role"] == null ||
                Session["Role"].ToString() != "Traveller")
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }


            // ==========================================
            // LOAD PROFILE LETTER
            // ==========================================

            if (!IsPostBack)
            {
                LoadProfileLetter();
            }
        }


        // ==========================================
        // LOAD PROFILE LETTER
        // ==========================================

        private void LoadProfileLetter()
        {
            // ==========================================
            // DEFAULT LETTER
            // ==========================================

            lblProfileLetter.Text = "U";


            // ==========================================
            // GET USER ID FROM SESSION
            // ==========================================

            int userId;

            if (!int.TryParse(
                Session["UserId"].ToString(),
                out userId))
            {
                return;
            }


            // ==========================================
            // GET USER NAME FROM DATABASE
            // ==========================================

            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                string query = @"
                    SELECT FullName
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


                object result =
                    cmd.ExecuteScalar();


                // ==========================================
                // CHECK RESULT
                // ==========================================

                if (result != null &&
                    result != DBNull.Value)
                {
                    string fullName =
                        result.ToString().Trim();


                    // ==========================================
                    // GET FIRST LETTER
                    // ==========================================

                    if (!string.IsNullOrWhiteSpace(
                        fullName))
                    {
                        lblProfileLetter.Text =
                            fullName
                                .Substring(0, 1)
                                .ToUpper();
                    }
                }
            }
        }


        // ==========================================
        // LOGOUT
        // ==========================================

        protected void btnLogout_Click(
            object sender,
            EventArgs e)
        {
            // ==========================================
            // CLEAR SESSION
            // ==========================================

            Session.Clear();

            Session.Abandon();


            // ==========================================
            // REDIRECT TO LOGIN
            // ==========================================

            Response.Redirect(
                "~/Account/Login.aspx");
        }
    }
}
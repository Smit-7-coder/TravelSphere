using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class Profile : System.Web.UI.Page
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
            // CHECK LOGIN
            // ==========================================

            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }



            // ==========================================
            // CHECK ROLE
            // ==========================================

            if (Session["Role"] == null ||
                Session["Role"].ToString() != "Traveller")
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }



            // ==========================================
            // LOAD PROFILE
            // ==========================================

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }



        // ==========================================
        // LOAD PROFILE
        // ==========================================

        private void LoadProfile()
        {
            // ==========================================
            // GET USER ID
            // ==========================================

            int userId =
                Convert.ToInt32(
                    Session["UserId"]);



            // ==========================================
            // DATABASE CONNECTION
            // ==========================================

            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                // ==========================================
                // QUERY
                // ==========================================

                string query = @"
                    SELECT
                        UserId,
                        FullName,
                        Email,
                        Phone
                    FROM Users
                    WHERE UserId = @UserId";



                // ==========================================
                // COMMAND
                // ==========================================

                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);



                // ==========================================
                // PARAMETER
                // ==========================================

                cmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);



                // ==========================================
                // OPEN CONNECTION
                // ==========================================

                con.Open();



                // ==========================================
                // READ DATA
                // ==========================================

                SqlDataReader reader =
                    cmd.ExecuteReader();



                if (reader.Read())
                {
                    // ==========================================
                    // USER ID
                    // ==========================================

                    string databaseUserId =
                        reader[
                            "UserId"
                        ].ToString();



                    lblUserId.Text =
                        databaseUserId;



                    lblAccountUserId.Text =
                        databaseUserId;



                    // ==========================================
                    // FULL NAME
                    // ==========================================

                    string fullName =
                        reader[
                            "FullName"
                        ].ToString();



                    txtFullName.Text =
                        fullName;



                    lblProfileName.Text =
                        fullName;



                    // ==========================================
                    // PROFILE INITIAL
                    // ==========================================

                    if (!string.IsNullOrWhiteSpace(
                        fullName))
                    {
                        lblAvatar.Text =
                            fullName
                                .Trim()
                                .Substring(
                                    0,
                                    1)
                                .ToUpper();
                    }
                    else
                    {
                        lblAvatar.Text =
                            "U";
                    }



                    // ==========================================
                    // EMAIL
                    // ==========================================

                    string email =
                        reader[
                            "Email"
                        ].ToString();



                    txtEmail.Text =
                        email;



                    lblProfileEmail.Text =
                        email;



                    lblAccountEmail.Text =
                        email;
                }
                else
                {
                    Response.Redirect(
                        "~/Account/Login.aspx");

                    return;
                }



                // ==========================================
                // CLOSE READER
                // ==========================================

                reader.Close();
            }
        }



        // ==========================================
        // SAVE PROFILE
        // ==========================================

        protected void btnSaveProfile_Click(
            object sender,
            EventArgs e)
        {
            // ==========================================
            // VALIDATION
            // ==========================================

            if (!Page.IsValid)
            {
                return;
            }



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
            // USER ID
            // ==========================================

            int userId =
                Convert.ToInt32(
                    Session["UserId"]);



            // ==========================================
            // GET FORM VALUES
            // ==========================================

            string fullName =
                txtFullName.Text.Trim();



            string email =
                txtEmail.Text.Trim();



            string phone =
                txtPhone.Text.Trim();



            // ==========================================
            // UPDATE DATABASE
            // ==========================================

            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                // ==========================================
                // UPDATE QUERY
                // ==========================================

                string query = @"
                    UPDATE Users
                    SET
                        FullName = @FullName,
                        Email = @Email,
                        Phone = @Phone
                    WHERE UserId = @UserId";



                // ==========================================
                // COMMAND
                // ==========================================

                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);



                // ==========================================
                // PARAMETERS
                // ==========================================

                cmd.Parameters.AddWithValue(
                    "@FullName",
                    fullName);



                cmd.Parameters.AddWithValue(
                    "@Email",
                    email);



                cmd.Parameters.AddWithValue(
                    "@Phone",
                    phone);



                cmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);



                // ==========================================
                // OPEN CONNECTION
                // ==========================================

                con.Open();



                // ==========================================
                // EXECUTE UPDATE
                // ==========================================

                int rowsAffected =
                    cmd.ExecuteNonQuery();



                // ==========================================
                // CHECK UPDATE
                // ==========================================

                if (rowsAffected > 0)
                {
                    // ==========================================
                    // UPDATE DISPLAY NAME
                    // ==========================================

                    lblProfileName.Text =
                        fullName;



                    // ==========================================
                    // UPDATE EMAIL
                    // ==========================================

                    lblProfileEmail.Text =
                        email;



                    lblAccountEmail.Text =
                        email;



                    // ==========================================
                    // UPDATE AVATAR
                    // ==========================================

                    if (!string.IsNullOrWhiteSpace(
                        fullName))
                    {
                        lblAvatar.Text =
                            fullName
                                .Trim()
                                .Substring(
                                    0,
                                    1)
                                .ToUpper();
                    }
                    else
                    {
                        lblAvatar.Text =
                            "U";
                    }



                    // ==========================================
                    // UPDATE SESSION NAME
                    // ==========================================

                    Session["FullName"] =
                        fullName;



                    // ==========================================
                    // SUCCESS MESSAGE
                    // ==========================================

                    lblMessage.Text =
                        "Your profile has been updated successfully.";

                    lblMessage.CssClass =
                        "profile-message success";
                }
                else
                {
                    // ==========================================
                    // NO CHANGE
                    // ==========================================

                    lblMessage.Text =
                        "No changes were made.";

                    lblMessage.CssClass =
                        "profile-message";
                }
            }
        }
    }
}
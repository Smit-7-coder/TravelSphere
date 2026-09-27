using System;
using System.Configuration;
using System.Data.SqlClient;

namespace TravelSphere.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            // Create a user object
            UserAccount user = new UserAccount();

            user.FullName = txtFullName.Text.Trim();
            user.Email = txtEmail.Text.Trim();

            // Hash the password before storing it
            user.Password = BCrypt.Net.BCrypt.HashPassword(
                txtPassword.Text
            );

            user.Phone = txtPhone.Text.Trim();
            user.Address = txtAddress.Text.Trim();
            user.Role = "Traveller";

            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["TravelSphereDB"]
                    .ConnectionString;

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();

                // Check whether email already exists
                string checkQuery =
                    "SELECT COUNT(*) FROM Users WHERE Email = @Email";

                using (SqlCommand checkCmd =
                       new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue(
                        "@Email",
                        user.Email
                    );

                    int count =
                        (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        lblMessage.Text =
                            "Email is already registered";

                        return;
                    }
                }

                // Insert new user
                string query = @"
                    INSERT INTO Users
                    (
                        FullName,
                        Email,
                        Password,
                        Phone,
                        Address,
                        Role
                    )
                    VALUES
                    (
                        @FullName,
                        @Email,
                        @Password,
                        @Phone,
                        @Address,
                        @Role
                    )";

                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@FullName",
                        user.FullName
                    );

                    cmd.Parameters.AddWithValue(
                        "@Email",
                        user.Email
                    );

                    cmd.Parameters.AddWithValue(
                        "@Password",
                        user.Password
                    );

                    cmd.Parameters.AddWithValue(
                        "@Phone",
                        user.Phone
                    );

                    cmd.Parameters.AddWithValue(
                        "@Address",
                        user.Address
                    );

                    cmd.Parameters.AddWithValue(
                        "@Role",
                        user.Role
                    );

                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text =
                    "Registration Successful";
            }
        }
    }
}
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace TravelSphere.Account
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        private string ResetToken
        {
            get
            {
                return Request.QueryString["token"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ValidateResetToken();
            }
        }

        private void ValidateResetToken()
        {
            string token = ResetToken;

            if (string.IsNullOrWhiteSpace(token))
            {
                ShowError("This password reset link is invalid.");
                return;
            }

            try
            {
                string tokenHash = HashToken(token);

                string connectionString =
                    ConfigurationManager
                        .ConnectionStrings["TravelSphereDB"]
                        .ConnectionString;

                string query = @"
                    SELECT UserEmail
                    FROM PasswordResetTokens
                    WHERE TokenHash = @TokenHash
                    AND IsUsed = 0
                    AND ExpiryDate > GETDATE()";

                using (SqlConnection connection =
                       new SqlConnection(connectionString))
                {
                    using (SqlCommand command =
                           new SqlCommand(query, connection))
                    {
                        command.Parameters.Add(
                            "@TokenHash",
                            SqlDbType.NVarChar,
                            64
                        ).Value = tokenHash;

                        connection.Open();

                        object result =
                            command.ExecuteScalar();

                        if (result == null)
                        {
                            ShowError(
                                "This password reset link is invalid or has expired."
                            );
                        }
                    }
                }
            }
            catch (Exception)
            {
                ShowError(
                    "Unable to validate the password reset link."
                );
            }
        }

        protected void btnResetPassword_Click(
            object sender,
            EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string token = ResetToken;

            if (string.IsNullOrWhiteSpace(token))
            {
                ShowError("This password reset link is invalid.");
                return;
            }

            string newPassword = txtNewPassword.Text;

            try
            {
                string tokenHash = HashToken(token);

                string connectionString =
                    ConfigurationManager
                        .ConnectionStrings["TravelSphereDB"]
                        .ConnectionString;

                using (SqlConnection connection =
                       new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Find the email connected to the reset token
                    string emailQuery = @"
                        SELECT UserEmail
                        FROM PasswordResetTokens
                        WHERE TokenHash = @TokenHash
                        AND IsUsed = 0
                        AND ExpiryDate > GETDATE()";

                    string email;

                    using (SqlCommand emailCommand =
                           new SqlCommand(emailQuery, connection))
                    {
                        emailCommand.Parameters.Add(
                            "@TokenHash",
                            SqlDbType.NVarChar,
                            64
                        ).Value = tokenHash;

                        object result =
                            emailCommand.ExecuteScalar();

                        if (result == null)
                        {
                            ShowError(
                                "This password reset link is invalid or has expired."
                            );

                            return;
                        }

                        email = result.ToString();
                    }

                    // Hash the new password using BCrypt
                    string hashedPassword =
                        BCrypt.Net.BCrypt.HashPassword(
                            newPassword
                        );

                    // Update the user's password
                    string updateUserQuery = @"
                        UPDATE Users
                        SET Password = @Password
                        WHERE Email = @Email";

                    using (SqlCommand updateCommand =
                           new SqlCommand(
                               updateUserQuery,
                               connection))
                    {
                        updateCommand.Parameters.Add(
                            "@Password",
                            SqlDbType.NVarChar,
                            255
                        ).Value = hashedPassword;

                        updateCommand.Parameters.Add(
                            "@Email",
                            SqlDbType.NVarChar,
                            255
                        ).Value = email;

                        int rowsAffected =
                            updateCommand.ExecuteNonQuery();

                        if (rowsAffected == 0)
                        {
                            ShowError(
                                "The user account could not be found."
                            );

                            return;
                        }
                    }

                    // Mark the reset token as used
                    string markTokenUsedQuery = @"
                        UPDATE PasswordResetTokens
                        SET IsUsed = 1
                        WHERE TokenHash = @TokenHash";

                    using (SqlCommand tokenCommand =
                           new SqlCommand(
                               markTokenUsedQuery,
                               connection))
                    {
                        tokenCommand.Parameters.Add(
                            "@TokenHash",
                            SqlDbType.NVarChar,
                            64
                        ).Value = tokenHash;

                        tokenCommand.ExecuteNonQuery();
                    }
                }

                Session["ForgotPasswordMessage"] =
                    "Your password has been reset successfully. You can now log in with your new password.";

                Response.Redirect(
                    "~/Account/Login.aspx",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception)
            {
                ShowError(
                    "Unable to reset your password."
                );
            }
        }

        private string HashToken(string token)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes =
                    Encoding.UTF8.GetBytes(token);

                byte[] hash =
                    sha256.ComputeHash(bytes);

                StringBuilder result =
                    new StringBuilder();

                foreach (byte b in hash)
                {
                    result.Append(
                        b.ToString("x2")
                    );
                }

                return result.ToString();
            }
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;

            lblMessage.Style["background-color"] =
                "#fdeaea";

            lblMessage.Style["color"] =
                "#d32f2f";

            pnlReset.Visible = false;
        }
    }
}
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace TravelSphere.Account
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }


        // =========================================================
        // SEND RESET LINK
        // =========================================================

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                Response.Write(
                    "<h3 style='color:red;'>Please enter your email address.</h3>"
                );

                return;
            }

            try
            {
                // -------------------------------------------------
                // 1. Generate secure token
                // -------------------------------------------------

                string token = GenerateResetToken();


                // -------------------------------------------------
                // 2. Hash token
                // -------------------------------------------------

                string tokenHash = HashToken(token);


                // -------------------------------------------------
                // 3. Save token in database
                // -------------------------------------------------

                SaveResetToken(email, tokenHash);


                // -------------------------------------------------
                // 4. Send reset email
                // -------------------------------------------------

                SendResetEmail(email, token);


                // -------------------------------------------------
                // 5. Save success message
                // -------------------------------------------------

                Session["ForgotPasswordMessage"] =
                    "If your email is registered with us, you'll receive a password reset link shortly.";


                // -------------------------------------------------
                // 6. Redirect to login
                // -------------------------------------------------

                Response.Redirect(
                    "~/Account/Login.aspx",
                    false
                );

                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                Response.Clear();

                Response.Write(
                    "<div style='font-family:Arial;padding:30px;'>" +

                    "<h2 style='color:#d32f2f;'>" +
                    "Password Reset Error" +
                    "</h2>" +

                    "<p>" +
                    "The password reset request could not be completed." +
                    "</p>" +

                    "<pre style='white-space:pre-wrap;background:#f5f5f5;padding:20px;border:1px solid #ddd;'>" +

                    Server.HtmlEncode(ex.ToString()) +

                    "</pre>" +

                    "</div>"
                );

                Context.ApplicationInstance.CompleteRequest();
            }
        }


        // =========================================================
        // GENERATE SECURE TOKEN
        // =========================================================

        private string GenerateResetToken()
        {
            byte[] tokenBytes = new byte[32];

            using (RandomNumberGenerator rng =
                   RandomNumberGenerator.Create())
            {
                rng.GetBytes(tokenBytes);
            }

            return Convert.ToBase64String(tokenBytes)
                .Replace("+", "-")
                .Replace("/", "_")
                .Replace("=", "");
        }


        // =========================================================
        // HASH TOKEN
        // =========================================================

        private string HashToken(string token)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes =
                    Encoding.UTF8.GetBytes(token);

                byte[] hash =
                    sha256.ComputeHash(bytes);

                StringBuilder builder =
                    new StringBuilder();

                foreach (byte b in hash)
                {
                    builder.Append(
                        b.ToString("x2")
                    );
                }

                return builder.ToString();
            }
        }


        // =========================================================
        // SAVE RESET TOKEN
        // =========================================================

        private void SaveResetToken(
            string email,
            string tokenHash)
        {
            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["TravelSphereDB"]
                    .ConnectionString;


            string deleteQuery = @"
                DELETE FROM PasswordResetTokens
                WHERE UserEmail = @Email
                AND IsUsed = 0
            ";


            string insertQuery = @"
                INSERT INTO PasswordResetTokens
                (
                    UserEmail,
                    TokenHash,
                    ExpiryDate,
                    IsUsed,
                    CreatedDate
                )
                VALUES
                (
                    @Email,
                    @TokenHash,
                    @ExpiryDate,
                    0,
                    GETDATE()
                )
            ";


            using (SqlConnection connection =
                   new SqlConnection(connectionString))
            {
                connection.Open();


                // Delete old unused token

                using (SqlCommand command =
                       new SqlCommand(
                           deleteQuery,
                           connection))
                {
                    command.Parameters.Add(
                        "@Email",
                        System.Data.SqlDbType.NVarChar,
                        255
                    ).Value = email;

                    command.ExecuteNonQuery();
                }


                // Insert new token

                using (SqlCommand command =
                       new SqlCommand(
                           insertQuery,
                           connection))
                {
                    command.Parameters.Add(
                        "@Email",
                        System.Data.SqlDbType.NVarChar,
                        255
                    ).Value = email;


                    command.Parameters.Add(
                        "@TokenHash",
                        System.Data.SqlDbType.NVarChar,
                        64
                    ).Value = tokenHash;


                    command.Parameters.Add(
                        "@ExpiryDate",
                        System.Data.SqlDbType.DateTime
                    ).Value = DateTime.Now.AddMinutes(30);


                    command.ExecuteNonQuery();
                }
            }
        }


        // =========================================================
        // SEND RESET EMAIL
        // =========================================================

        private void SendResetEmail(
            string email,
            string token)
        {
            string resetPage =
                ConfigurationManager
                    .AppSettings["ResetPasswordUrl"];


            if (string.IsNullOrWhiteSpace(resetPage))
            {
                throw new Exception(
                    "ResetPasswordUrl is missing from Web.config."
                );
            }


            // -----------------------------------------------------
            // Create reset URL
            // -----------------------------------------------------

            string resetUrl =
                resetPage +
                "?token=" +
                Uri.EscapeDataString(token);


            using (MailMessage message =
                   new MailMessage())
            {
                message.From =
                    new MailAddress(
                        "drivehub27@gmail.com",
                        "TravelSphere"
                    );


                message.To.Add(email);


                message.Subject =
                    "TravelSphere - Reset Your Password";


                message.IsBodyHtml = true;


                message.Body = @"
<!DOCTYPE html>

<html>

<body style='
    margin:0;
    padding:30px;
    background:#f5f7f6;
    font-family:Arial,Helvetica,sans-serif;
'>

<div style='
    max-width:600px;
    margin:auto;
    background:#ffffff;
    padding:35px;
    border-radius:10px;
'>

    <h2 style='color:#2e7d32;'>
        TravelSphere
    </h2>

    <p>
        Hello,
    </p>

    <p>
        We received a request to reset your
        TravelSphere account password.
    </p>

    <p>
        Click the button below to reset your password.
    </p>

    <p style='margin:30px 0;'>

        <a href='" + resetUrl + @"'
           style='
               display:inline-block;
               background:#2e7d32;
               color:#ffffff;
               padding:13px 25px;
               text-decoration:none;
               border-radius:6px;
               font-weight:bold;
           '>

            Reset Password

        </a>

    </p>

    <p>
        This link will expire in
        <strong>30 minutes</strong>.
    </p>

    <p style='color:#777;font-size:13px;'>

        If you did not request this password reset,
        you can safely ignore this email.

    </p>

    <hr />

    <p style='color:#999;font-size:12px;'>
        © TravelSphere
    </p>

</div>

</body>

</html>
";


                // -------------------------------------------------
                // Gmail SMTP
                // Credentials are read from Web.config
                // -------------------------------------------------
                using (SmtpClient smtp = new SmtpClient())
                {
                    smtp.Host = "smtp.gmail.com";
                    smtp.Port = 587;

                    smtp.EnableSsl = true;

                    smtp.UseDefaultCredentials = false;

                    smtp.Credentials = new System.Net.NetworkCredential(
                        "drivehub27@gmail.com",
                        "gqyqekrycjmmnqtx   "
                    );

                    smtp.Send(message);
                }
            }
        }
    }
}
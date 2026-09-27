using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace TravelSphere.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowForgotPasswordMessage();
            }
        }

        private void ShowForgotPasswordMessage()
        {
            if (Session["ForgotPasswordMessage"] != null)
            {
                lblMessage.Text =
                    Session["ForgotPasswordMessage"].ToString();

                lblMessage.CssClass =
                    "message success";

                Session.Remove("ForgotPasswordMessage");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["TravelSphereDB"]
                    .ConnectionString;

            string query = @"
                SELECT
                    UserId,
                    FullName,
                    Email,
                    Password,
                    Role
                FROM Users
                WHERE Email = @Email";

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Email",
                        txtEmail.Text.Trim());

                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string storedPassword =
                                reader["Password"].ToString();

                            bool passwordCorrect =
                                BCrypt.Net.BCrypt.Verify(
                                    txtPassword.Text,
                                    storedPassword);

                            if (passwordCorrect)
                            {
                                LoginUser(reader);
                            }
                            else
                            {
                                ShowError(
                                    "Invalid Email or Password.");
                            }
                        }
                        else
                        {
                            ShowError(
                                "Invalid Email or Password.");
                        }
                    }
                }
            }
        }

        private void LoginUser(SqlDataReader reader)
        {
            string role =
                reader["Role"].ToString();

            UserAccount user;

            if (role == "Admin")
            {
                user = new AdminAccount();
            }
            else if (role == "Traveller")
            {
                user = new TravellerAccount();
            }
            else
            {
                ShowError(
                    "Your account role is not configured.");

                return;
            }

            user.UserId =
                reader["UserId"].ToString();

            user.FullName =
                reader["FullName"].ToString();

            user.Email =
                reader["Email"].ToString();

            user.Role = role;

            Session["UserId"] = user.UserId;
            Session["FullName"] = user.FullName;
            Session["Email"] = user.Email;
            Session["Role"] = user.Role;

            Response.Redirect(
                user.GetHomePage());
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "message";
        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TravelSphere.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT UserId, FullName, Email, Role
                                 FROM Users
                                 WHERE Email = @Email AND Password = @Password";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Store logged-in user details in Session
                    Session["UserId"] = reader["UserId"].ToString();
                    Session["FullName"] = reader["FullName"].ToString();
                    Session["Email"] = reader["Email"].ToString();
                    Session["Role"] = reader["Role"].ToString();

                    string role = reader["Role"].ToString();

                    reader.Close();

                    // Role wise redirect
                    if (role == "Admin")
                    {
                        Response.Redirect("~/Admin/Dashboard.aspx");
                    }
                    else if (role == "Traveller")
                    {
                        Response.Redirect("~/Traveller/Home.aspx");
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid Email or Password.";
                }
            }
        }
    }
}
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

            string connectionString =
                ConfigurationManager.ConnectionStrings["TravelSphereDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlCommand Checkcmd = new SqlCommand(checkQuery, con);

                Checkcmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                int count = (int)Checkcmd.ExecuteScalar();

                if(count > 0)
                {
                    lblMessage.Text = "Email is already registered";
                    return;
                }

                string query = @"INSERT INTO Users
                        (FullName, Email, Password, Phone, Address, Role)
                        VALUES
                        (@FullName, @Email, @Password, @Phone, @Address, @Role)";
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Role", "Traveller");

                cmd.ExecuteNonQuery();
                lblMessage.Text = "Registration Successful";
            }
        }
    }
}
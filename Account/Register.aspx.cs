using System;
using TravelSphere.Models;
using TravelSphere.Services;

namespace TravelSphere.Account
{
    public partial class Register : System.Web.UI.Page
    {
        private readonly UserService userService = new UserService();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            User user = new User
            {
                FullName = txtFullName.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                Password = txtPassword.Text,
                Phone = txtPhone.Text.Trim(),
                Address = txtAddress.Text.Trim(),
                Role = "Traveller"
            };

            string result = userService.Register(user);

            lblMessage.Text = result;
        }
    }
}
using System;

namespace TravelSphere
{
    public class UserAccount
    {
        public string UserId { get; set; }

        public string FullName { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public string Phone { get; set; }

        public string Address { get; set; }

        public string Role { get; set; }

        public virtual string GetHomePage()
        {
            return "~/Account/Login.aspx";
        }
    }
}
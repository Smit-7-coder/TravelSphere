using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TravelSphere.Models
{
    public class User
    {
        public int UserId { get; set; }

        public string FullName { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public string Phone { get; set; }

        public string Address { get; set; }

        public string ProfileImage { get; set; }

        public string Role { get; set; }

        public DateTime CreatedAt { get; set; }
    }
}
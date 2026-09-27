using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TravelSphere
{
    public class AdminAccount : UserAccount
    {
        public override string GetHomePage()
        {
            return "~/Admin/Dashboard.aspx";
        }
    }
}
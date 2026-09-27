using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TravelSphere
{
    public class TravellerAccount : UserAccount
    {
        public override string GetHomePage()
        {
            return "~/Traveller/Home.aspx";
        }
    }
}
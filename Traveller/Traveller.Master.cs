using System;

namespace TravelSphere.Traveller
{
    public partial class TravellerMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // User must be logged in
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }


            // Only Traveller can access Traveller pages
            if (Session["Role"] == null ||
                Session["Role"].ToString() != "Traveller")
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }


            // Show first letter of logged-in user's name
            if (!IsPostBack && Session["FullName"] != null)
            {
                string name = Session["FullName"].ToString();

                if (!string.IsNullOrEmpty(name))
                {
                    lblProfileLetter.Text =
                        name.Substring(0, 1).ToUpper();
                }
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Session.Abandon();

            Response.Redirect("~/Account/Login.aspx");
        }
    }
}
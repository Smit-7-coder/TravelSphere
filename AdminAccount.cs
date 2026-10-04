namespace TravelSphere
{
    public class AdminAccount : UserAccount
    {
        public override string GetHomePage()
        {
            return "~/Admin/AdminDeshboard.aspx";
        }
    }
}
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
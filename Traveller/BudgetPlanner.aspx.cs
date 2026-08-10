using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TravelSphere.Traveller
{
    public partial class BudgetPlanner : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings[
                "TravelSphereDB"
            ].ConnectionString;


        // ==========================================
        // PAGE LOAD
        // ==========================================

        protected void Page_Load(
            object sender,
            EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }


            if (!IsPostBack)
            {
                LoadTravelTypes();

                LoadHotelTypes();


                ResetSummary();
            }
        }


        // ==========================================
        // LOAD TRAVEL TYPES
        // ==========================================

        private void LoadTravelTypes()
        {
            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                string query = @"
                    SELECT
                        OptionName
                    FROM TravelCosts
                    WHERE CostType = 'Travel'
                    AND IsActive = 1
                    ORDER BY OptionName";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                con.Open();


                SqlDataReader reader =
                    cmd.ExecuteReader();


                ddlTravelType.Items.Clear();


                ddlTravelType.Items.Add(
                    new System.Web.UI.WebControls.ListItem(
                        "Select Travel Type",
                        ""));


                while (reader.Read())
                {
                    string optionName =
                        reader[
                            "OptionName"
                        ].ToString();


                    ddlTravelType.Items.Add(
                        new System.Web.UI.WebControls.ListItem(
                            optionName,
                            optionName));
                }


                reader.Close();
            }
        }


        // ==========================================
        // LOAD HOTEL TYPES
        // ==========================================

        private void LoadHotelTypes()
        {
            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                string query = @"
                    SELECT
                        OptionName
                    FROM TravelCosts
                    WHERE CostType = 'Hotel'
                    AND IsActive = 1
                    ORDER BY OptionName";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                con.Open();


                SqlDataReader reader =
                    cmd.ExecuteReader();


                ddlHotelType.Items.Clear();


                ddlHotelType.Items.Add(
                    new System.Web.UI.WebControls.ListItem(
                        "Select Hotel Type",
                        ""));


                while (reader.Read())
                {
                    string optionName =
                        reader[
                            "OptionName"
                        ].ToString();


                    ddlHotelType.Items.Add(
                        new System.Web.UI.WebControls.ListItem(
                            optionName,
                            optionName));
                }


                reader.Close();
            }
        }


        // ==========================================
        // CALCULATE BUDGET
        // ==========================================

        protected void btnCalculate_Click(
            object sender,
            EventArgs e)
        {
            lblMessage.Text = "";


            // ==========================================
            // VALIDATE DAYS
            // ==========================================

            if (!int.TryParse(
                txtDays.Text,
                out int numberOfDays)
                ||
                numberOfDays <= 0)
            {
                lblMessage.Text =
                    "Please enter a valid number of days.";

                return;
            }


            // ==========================================
            // VALIDATE PEOPLE
            // ==========================================

            if (!int.TryParse(
                txtPeople.Text,
                out int numberOfPeople)
                ||
                numberOfPeople <= 0)
            {
                lblMessage.Text =
                    "Please enter a valid number of people.";

                return;
            }


            // ==========================================
            // VALIDATE ROOMS
            // ==========================================

            if (!int.TryParse(
                txtRooms.Text,
                out int numberOfRooms)
                ||
                numberOfRooms <= 0)
            {
                lblMessage.Text =
                    "Please enter a valid number of rooms.";

                return;
            }


            // ==========================================
            // VALIDATE TRAVEL TYPE
            // ==========================================

            if (string.IsNullOrWhiteSpace(
                ddlTravelType.SelectedValue))
            {
                lblMessage.Text =
                    "Please select a travel type.";

                return;
            }


            // ==========================================
            // VALIDATE HOTEL TYPE
            // ==========================================

            if (string.IsNullOrWhiteSpace(
                ddlHotelType.SelectedValue))
            {
                lblMessage.Text =
                    "Please select a hotel type.";

                return;
            }


            // ==========================================
            // VALIDATE MIN DISTANCE
            // ==========================================

            if (!decimal.TryParse(
                txtMinDistance.Text,
                out decimal minDistance)
                ||
                minDistance < 0)
            {
                lblMessage.Text =
                    "Please enter a valid minimum distance.";

                return;
            }


            // ==========================================
            // VALIDATE MAX DISTANCE
            // ==========================================

            if (!decimal.TryParse(
                txtMaxDistance.Text,
                out decimal maxDistance)
                ||
                maxDistance < 0)
            {
                lblMessage.Text =
                    "Please enter a valid maximum distance.";

                return;
            }


            // ==========================================
            // DISTANCE VALIDATION
            // ==========================================

            if (maxDistance < minDistance)
            {
                lblMessage.Text =
                    "Maximum distance cannot be less than minimum distance.";

                return;
            }


            // ==========================================
            // GET TRAVEL RATE
            // ==========================================

            decimal travelRate =
                GetRate(
                    "Travel",
                    ddlTravelType.SelectedValue);


            // ==========================================
            // GET HOTEL RATE
            // ==========================================

            decimal hotelRate =
                GetRate(
                    "Hotel",
                    ddlHotelType.SelectedValue);


            // ==========================================
            // GET DINING RATE
            // ==========================================

            decimal diningRate =
                GetDefaultRate(
                    "Dining");


            // ==========================================
            // GET ACTIVITY RATE
            // ==========================================

            decimal activityRate =
                GetDefaultRate(
                    "Activity");


            // ==========================================
            // AVERAGE DISTANCE
            // ==========================================

            decimal averageDistance =
                (minDistance + maxDistance)
                / 2;


            // ==========================================
            // ACCOMMODATION COST
            // ==========================================

            decimal accommodationCost =
                hotelRate
                * numberOfRooms
                * numberOfDays;


            // ==========================================
            // TRAVEL COST
            // ==========================================

            decimal travelCost =
                travelRate
                * averageDistance;


            // ==========================================
            // DINING COST
            // ==========================================

            decimal diningCost =
                diningRate
                * numberOfPeople
                * numberOfDays;


            // ==========================================
            // ACTIVITIES COST
            // ==========================================

            decimal activitiesCost = 0;


            if (chkPaidActivities.Checked)
            {
                activitiesCost =
                    activityRate
                    * numberOfPeople
                    * numberOfDays;
            }


            // ==========================================
            // TOTAL
            // ==========================================

            decimal estimatedAmount =
                accommodationCost
                + travelCost
                + diningCost
                + activitiesCost;


            // ==========================================
            // DISPLAY SUMMARY
            // ==========================================

            lblAccommodationCost.Text =
                accommodationCost.ToString("N0");


            lblTravelCost.Text =
                travelCost.ToString("N0");


            lblDiningCost.Text =
                diningCost.ToString("N0");


            lblActivitiesCost.Text =
                activitiesCost.ToString("N0");


            lblEstimatedAmount.Text =
                estimatedAmount.ToString("N0");


            // ==========================================
            // SAVE PLAN PANEL
            // ==========================================

            pnlSave.Visible =
                true;


            lblSaveMessage.Text =
                "";


            // ==========================================
            // STORE VALUES IN VIEWSTATE
            // ==========================================

            ViewState["NumberOfDays"] =
                numberOfDays;


            ViewState["NumberOfPeople"] =
                numberOfPeople;


            ViewState["NumberOfRooms"] =
                numberOfRooms;


            ViewState["TravelType"] =
                ddlTravelType.SelectedValue;


            ViewState["HotelType"] =
                ddlHotelType.SelectedValue;


            ViewState["PaidActivities"] =
                chkPaidActivities.Checked;


            ViewState["MinDistance"] =
                minDistance;


            ViewState["MaxDistance"] =
                maxDistance;


            ViewState["AccommodationCost"] =
                accommodationCost;


            ViewState["TravelCost"] =
                travelCost;


            ViewState["DiningCost"] =
                diningCost;


            ViewState["ActivitiesCost"] =
                activitiesCost;


            ViewState["EstimatedAmount"] =
                estimatedAmount;
        }


        // ==========================================
        // GET SPECIFIC RATE
        // ==========================================

        private decimal GetRate(
            string costType,
            string optionName)
        {
            decimal rate = 0;


            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                string query = @"
                    SELECT TOP 1
                        Rate
                    FROM TravelCosts
                    WHERE CostType = @CostType
                    AND OptionName = @OptionName
                    AND IsActive = 1";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@CostType",
                    costType);


                cmd.Parameters.AddWithValue(
                    "@OptionName",
                    optionName);


                con.Open();


                object result =
                    cmd.ExecuteScalar();


                if (result != null)
                {
                    rate =
                        Convert.ToDecimal(result);
                }
            }


            return rate;
        }


        // ==========================================
        // GET DEFAULT RATE
        // ==========================================

        private decimal GetDefaultRate(
            string costType)
        {
            decimal rate = 0;


            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                string query = @"
                    SELECT TOP 1
                        Rate
                    FROM TravelCosts
                    WHERE CostType = @CostType
                    AND IsActive = 1
                    ORDER BY CostId ASC";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@CostType",
                    costType);


                con.Open();


                object result =
                    cmd.ExecuteScalar();


                if (result != null)
                {
                    rate =
                        Convert.ToDecimal(result);
                }
            }


            return rate;
        }


        // ==========================================
        // SAVE BUDGET PLAN
        // ==========================================

        protected void btnSavePlan_Click(
            object sender,
            EventArgs e)
        {
            // ==========================================
            // CHECK USER
            // ==========================================

            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    "~/Account/Login.aspx");

                return;
            }


            // ==========================================
            // CHECK CALCULATION
            // ==========================================

            if (ViewState["EstimatedAmount"] == null)
            {
                lblSaveMessage.Text =
                    "Please calculate your budget first.";

                return;
            }


            int userId =
                Convert.ToInt32(
                    Session["UserId"]);


            int numberOfDays =
                Convert.ToInt32(
                    ViewState["NumberOfDays"]);


            int numberOfPeople =
                Convert.ToInt32(
                    ViewState["NumberOfPeople"]);


            int numberOfRooms =
                Convert.ToInt32(
                    ViewState["NumberOfRooms"]);


            string travelType =
                ViewState["TravelType"].ToString();


            string hotelType =
                ViewState["HotelType"].ToString();


            bool paidActivities =
                Convert.ToBoolean(
                    ViewState["PaidActivities"]);


            decimal minDistance =
                Convert.ToDecimal(
                    ViewState["MinDistance"]);


            decimal maxDistance =
                Convert.ToDecimal(
                    ViewState["MaxDistance"]);


            decimal accommodationCost =
                Convert.ToDecimal(
                    ViewState["AccommodationCost"]);


            decimal travelCost =
                Convert.ToDecimal(
                    ViewState["TravelCost"]);


            decimal diningCost =
                Convert.ToDecimal(
                    ViewState["DiningCost"]);


            decimal activitiesCost =
                Convert.ToDecimal(
                    ViewState["ActivitiesCost"]);


            decimal estimatedAmount =
                Convert.ToDecimal(
                    ViewState["EstimatedAmount"]);


            // ==========================================
            // INSERT BUDGET PLAN
            // ==========================================

            using (SqlConnection con =
                   new SqlConnection(
                       connectionString))
            {
                string query = @"
                    INSERT INTO BudgetPlans
                    (
                        UserId,
                        NumberOfDays,
                        NumberOfPeople,
                        TravelType,
                        HotelType,
                        NumberOfRooms,
                        PaidActivities,
                        MinDistance,
                        MaxDistance,
                        AccommodationCost,
                        TravelCost,
                        DiningCost,
                        ActivitiesCost,
                        EstimatedAmount
                    )
                    VALUES
                    (
                        @UserId,
                        @NumberOfDays,
                        @NumberOfPeople,
                        @TravelType,
                        @HotelType,
                        @NumberOfRooms,
                        @PaidActivities,
                        @MinDistance,
                        @MaxDistance,
                        @AccommodationCost,
                        @TravelCost,
                        @DiningCost,
                        @ActivitiesCost,
                        @EstimatedAmount
                    )";


                SqlCommand cmd =
                    new SqlCommand(
                        query,
                        con);


                cmd.Parameters.AddWithValue(
                    "@UserId",
                    userId);


                cmd.Parameters.AddWithValue(
                    "@NumberOfDays",
                    numberOfDays);


                cmd.Parameters.AddWithValue(
                    "@NumberOfPeople",
                    numberOfPeople);


                cmd.Parameters.AddWithValue(
                    "@TravelType",
                    travelType);


                cmd.Parameters.AddWithValue(
                    "@HotelType",
                    hotelType);


                cmd.Parameters.AddWithValue(
                    "@NumberOfRooms",
                    numberOfRooms);


                cmd.Parameters.AddWithValue(
                    "@PaidActivities",
                    paidActivities);


                cmd.Parameters.AddWithValue(
                    "@MinDistance",
                    minDistance);


                cmd.Parameters.AddWithValue(
                    "@MaxDistance",
                    maxDistance);


                cmd.Parameters.AddWithValue(
                    "@AccommodationCost",
                    accommodationCost);


                cmd.Parameters.AddWithValue(
                    "@TravelCost",
                    travelCost);


                cmd.Parameters.AddWithValue(
                    "@DiningCost",
                    diningCost);


                cmd.Parameters.AddWithValue(
                    "@ActivitiesCost",
                    activitiesCost);


                cmd.Parameters.AddWithValue(
                    "@EstimatedAmount",
                    estimatedAmount);


                con.Open();


                int result =
                    cmd.ExecuteNonQuery();


                if (result > 0)
                {
                    lblSaveMessage.Text =
                        "Your budget plan has been saved successfully.";

                    lblSaveMessage.CssClass =
                        "save-message success";
                }
                else
                {
                    lblSaveMessage.Text =
                        "Unable to save your budget plan.";

                    lblSaveMessage.CssClass =
                        "save-message error";
                }
            }
        }


        // ==========================================
        // RESET SUMMARY
        // ==========================================

        private void ResetSummary()
        {
            lblAccommodationCost.Text =
                "0";


            lblTravelCost.Text =
                "0";


            lblDiningCost.Text =
                "0";


            lblActivitiesCost.Text =
                "0";


            lblEstimatedAmount.Text =
                "0";


            pnlSave.Visible =
                false;
        }
    }
}
<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="BudgetPlanner.aspx.cs"
    Inherits="TravelSphere.Traveller.BudgetPlanner" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/budget-planner.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">


    <!-- ==========================================
         MAIN CONTAINER
    =========================================== -->

    <div class="budget-container">


        <!-- ==========================================
             PAGE HEADER
        =========================================== -->

        <div class="budget-header">

            <div>

                <h1>
                    Budget Planner
                </h1>

                <p>
                    Plan your trip and get an estimated travel budget.
                </p>

            </div>

        </div>


        <!-- ==========================================
             MAIN GRID
        =========================================== -->

        <div class="budget-grid">


            <!-- ==========================================
                 LEFT SIDE - FORM
            =========================================== -->

            <div class="budget-card">


                <h2>
                    Plan Your Trip
                </h2>


                <p class="card-subtitle">
                    Enter your trip details to calculate an estimated budget.
                </p>


                <!-- ==========================================
                     NUMBER OF DAYS
                =========================================== -->

                <div class="form-group">

                    <label for="txtDays">
                        Number of Days
                    </label>


                    <asp:TextBox
                        ID="txtDays"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Number"
                        min="1"
                        placeholder="Example: 5">
                    </asp:TextBox>

                </div>


                <!-- ==========================================
                     NUMBER OF PEOPLE
                =========================================== -->

                <div class="form-group">

                    <label for="txtPeople">
                        Number of People
                    </label>


                    <asp:TextBox
                        ID="txtPeople"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Number"
                        min="1"
                        placeholder="Example: 2">
                    </asp:TextBox>

                </div>


                <!-- ==========================================
                     NUMBER OF ROOMS
                =========================================== -->

                <div class="form-group">

                    <label for="txtRooms">
                        Number of Rooms
                    </label>


                    <asp:TextBox
                        ID="txtRooms"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Number"
                        min="1"
                        placeholder="Example: 1">
                    </asp:TextBox>

                </div>


                <!-- ==========================================
                     TRAVEL TYPE
                =========================================== -->

                <div class="form-group">

                    <label for="ddlTravelType">
                        Travel Type
                    </label>


                    <asp:DropDownList
                        ID="ddlTravelType"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem
                            Text="Select Travel Type"
                            Value="">
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>


                <!-- ==========================================
                     HOTEL TYPE
                =========================================== -->

                <div class="form-group">

                    <label for="ddlHotelType">
                        Hotel Type
                    </label>


                    <asp:DropDownList
                        ID="ddlHotelType"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem
                            Text="Select Hotel Type"
                            Value="">
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>


                <!-- ==========================================
                     MINIMUM DISTANCE
                =========================================== -->

                <div class="distance-grid">


                    <div class="form-group">

                        <label for="txtMinDistance">
                            Minimum Distance (KM)
                        </label>


                        <asp:TextBox
                            ID="txtMinDistance"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Number"
                            min="0"
                            step="0.01"
                            placeholder="Example: 100">
                        </asp:TextBox>

                    </div>


                    <div class="form-group">

                        <label for="txtMaxDistance">
                            Maximum Distance (KM)
                        </label>


                        <asp:TextBox
                            ID="txtMaxDistance"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Number"
                            min="0"
                            step="0.01"
                            placeholder="Example: 300">
                        </asp:TextBox>

                    </div>


                </div>


                <!-- ==========================================
                     PAID ACTIVITIES
                =========================================== -->

                <div class="activity-option">


                    <div>

                        <label class="activity-label">
                            Paid Activities
                        </label>

                        <p>
                            Include estimated activity expenses.
                        </p>

                    </div>


                    <label class="switch">

                        <asp:CheckBox
                            ID="chkPaidActivities"
                            runat="server"
                            AutoPostBack="false" />

                        <span class="slider">
                        </span>

                    </label>


                </div>


                <!-- ==========================================
                     CALCULATE BUTTON
                =========================================== -->

                <asp:Button
                    ID="btnCalculate"
                    runat="server"
                    Text="Calculate My Budget"
                    CssClass="calculate-button"
                    OnClick="btnCalculate_Click" />


                <!-- ==========================================
                     MESSAGE
                =========================================== -->

                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="message">
                </asp:Label>


            </div>


            <!-- ==========================================
                 RIGHT SIDE - SUMMARY
            =========================================== -->

            <div class="budget-card summary-card">


                <div class="summary-header">

                    <div>

                        <h2>
                            Estimated Budget
                        </h2>

                        <p>
                            Your estimated trip expenses
                        </p>

                    </div>


                    <div class="budget-icon">
                        ₹
                    </div>

                </div>


                <!-- ==========================================
                     SUMMARY ITEMS
                =========================================== -->

                <div class="summary-list">


                    <!-- ACCOMMODATION -->

                    <div class="summary-row">

                        <div>

                            <span class="summary-title">
                                Accommodation
                            </span>

                            <span class="summary-description">
                                Hotel and room expenses
                            </span>

                        </div>


                        <strong>

                            ₹<asp:Label
                                ID="lblAccommodationCost"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>


                    <!-- TRAVEL -->

                    <div class="summary-row">

                        <div>

                            <span class="summary-title">
                                Travel
                            </span>

                            <span class="summary-description">
                                Estimated transportation cost
                            </span>

                        </div>


                        <strong>

                            ₹<asp:Label
                                ID="lblTravelCost"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>


                    <!-- DINING -->

                    <div class="summary-row">

                        <div>

                            <span class="summary-title">
                                Dining
                            </span>

                            <span class="summary-description">
                                Food expenses
                            </span>

                        </div>


                        <strong>

                            ₹<asp:Label
                                ID="lblDiningCost"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>


                    <!-- ACTIVITIES -->

                    <div class="summary-row">

                        <div>

                            <span class="summary-title">
                                Activities
                            </span>

                            <span class="summary-description">
                                Paid activities and experiences
                            </span>

                        </div>


                        <strong>

                            ₹<asp:Label
                                ID="lblActivitiesCost"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>


                </div>


                <!-- ==========================================
                     TOTAL
                =========================================== -->

                <div class="estimated-total">


                    <div>

                        <span>
                            Estimated Total
                        </span>

                        <small>
                            Approximate trip budget
                        </small>

                    </div>


                    <strong>

                        ₹<asp:Label
                            ID="lblEstimatedAmount"
                            runat="server">
                        </asp:Label>

                    </strong>


                </div>


                <!-- ==========================================
                     SAVE PLAN
                =========================================== -->

                <asp:Panel
                    ID="pnlSave"
                    runat="server"
                    Visible="false"
                    CssClass="save-section">


                    <div>

                        <h3>
                            Save this Budget Plan
                        </h3>

                        <p>
                            Save your estimated budget to your TravelSphere account.
                        </p>

                    </div>


                    <asp:Button
                        ID="btnSavePlan"
                        runat="server"
                        Text="Save Plan"
                        CssClass="save-button"
                        OnClick="btnSavePlan_Click" />


                </asp:Panel>


                <!-- ==========================================
                     SAVE MESSAGE
                =========================================== -->

                <asp:Label
                    ID="lblSaveMessage"
                    runat="server"
                    CssClass="save-message">
                </asp:Label>


            </div>


        </div>


        <!-- ==========================================
             INFORMATION
        =========================================== -->

        <div class="budget-info">


            <div class="info-icon">
                i
            </div>


            <div>

                <h3>
                    How the estimate works
                </h3>

                <p>
                    Your estimated budget is calculated using the travel,
                    accommodation, dining and activity rates configured
                    by TravelSphere.
                </p>

            </div>


        </div>


    </div>


</asp:Content>
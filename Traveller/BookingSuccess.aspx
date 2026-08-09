<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="BookingSuccess.aspx.cs"
    Inherits="TravelSphere.Traveller.BookingSuccess" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/booking-success.css"
          rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="success-container">

        <!-- ==========================================
             SUCCESS HEADER
        =========================================== -->

        <div class="success-card">

            <div class="success-icon">
                ✓
            </div>


            <h1>
                Booking Confirmed!
            </h1>


            <p class="success-message">
                Your travel booking has been successfully confirmed.
            </p>


            <div class="booking-id-box">

                <span>
                    Booking ID
                </span>

                <strong>
                    #<asp:Label
                        ID="lblBookingId"
                        runat="server">
                    </asp:Label>
                </strong>

            </div>

        </div>


        <!-- ==========================================
             BOOKING DETAILS
        =========================================== -->

        <div class="details-card">

            <h2>
                Booking Details
            </h2>


            <div class="details-grid">


                <!-- PACKAGE -->

                <div class="detail-item">

                    <span class="detail-label">
                        Package
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblPackageName"
                            runat="server">
                        </asp:Label>
                    </strong>

                </div>


                <!-- DESTINATION -->

                <div class="detail-item">

                    <span class="detail-label">
                        Destination
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblDestination"
                            runat="server">
                        </asp:Label>
                    </strong>

                </div>


                <!-- TRAVEL DATE -->

                <div class="detail-item">

                    <span class="detail-label">
                        Travel Date
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblTravelDate"
                            runat="server">
                        </asp:Label>
                    </strong>

                </div>


                <!-- PERSONS -->

                <div class="detail-item">

                    <span class="detail-label">
                        Number of Persons
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblPersons"
                            runat="server">
                        </asp:Label>
                    </strong>

                </div>


                <!-- BOOKING DATE -->

                <div class="detail-item">

                    <span class="detail-label">
                        Booking Date
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblBookingDate"
                            runat="server">
                        </asp:Label>
                    </strong>

                </div>


                <!-- BOOKING STATUS -->

                <div class="detail-item">

                    <span class="detail-label">
                        Booking Status
                    </span>

                    <strong class="status">
                        <asp:Label
                            ID="lblBookingStatus"
                            runat="server">
                        </asp:Label>
                    </strong>

                </div>

            </div>


            <!-- ==========================================
                 PAYMENT
            =========================================== -->

            <div class="payment-section">

                <div>

                    <span class="detail-label">
                        Payment Status
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblPaymentStatus"
                            runat="server">
                        </asp:Label>
                    </strong>

                </div>


                <div class="total-section">

                    <span>
                        Total Amount
                    </span>

                    <strong>
                        ₹<asp:Label
                            ID="lblTotalAmount"
                            runat="server">
                        </asp:Label>
                    </strong>

                </div>

            </div>

        </div>


        <!-- ==========================================
             ACTIONS
        =========================================== -->

        <div class="action-section">

            <a
                href="Home.aspx"
                class="home-button">

                Back to Home

            </a>


            <a
                href="MyTrips.aspx"
                class="trips-button">

                View My Trips

            </a>

        </div>

    </div>

</asp:Content>
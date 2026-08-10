<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="BookingDetails.aspx.cs"
    Inherits="TravelSphere.Traveller.BookingDetails" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/booking-details.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">


    <!-- ==========================================
         MAIN CONTAINER
    =========================================== -->

    <div class="booking-details-container">


        <!-- ==========================================
             PAGE HEADER
        =========================================== -->

        <div class="details-header">

            <div>

                <h1>
                    Booking Details
                </h1>

                <p>
                    View complete information about your trip.
                </p>

            </div>


            <a
                href="MyTrips.aspx"
                class="back-button">

                ← Back to My Trips

            </a>

        </div>


        <!-- ==========================================
             ERROR MESSAGE
        =========================================== -->

        <asp:Panel
            ID="pnlError"
            runat="server"
            CssClass="error-card"
            Visible="false">

            <h3>
                Booking Not Found
            </h3>

            <p>
                We could not find this booking.
            </p>

            <a
                href="MyTrips.aspx"
                class="back-button">

                Back to My Trips

            </a>

        </asp:Panel>


        <!-- ==========================================
             BOOKING CONTENT
        =========================================== -->

        <asp:Panel
            ID="pnlBooking"
            runat="server"
            Visible="false">


            <!-- ==========================================
                 PACKAGE HEADER
            =========================================== -->

            <div class="package-card">


                <div class="package-image-container">

                    <asp:Image
                        ID="imgPackage"
                        runat="server"
                        CssClass="package-image" />

                </div>


                <div class="package-info">


                    <h2>

                        <asp:Label
                            ID="lblPackageName"
                            runat="server">
                        </asp:Label>

                    </h2>


                    <div class="package-location">

                        <span>
                            ●
                        </span>


                        <asp:Label
                            ID="lblDestination"
                            runat="server">
                        </asp:Label>

                    </div>


                    <p>

                        <asp:Label
                            ID="lblPackageDescription"
                            runat="server">
                        </asp:Label>

                    </p>


                    <div class="package-meta">


                        <span>

                            Duration:

                            <strong>

                                <asp:Label
                                    ID="lblDuration"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </span>


                        <span>

                            Adult Price:

                            <strong>

                                ₹<asp:Label
                                    ID="lblAdultPrice"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </span>


                        <span>

                            Child Price:

                            <strong>

                                ₹<asp:Label
                                    ID="lblChildPrice"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </span>


                    </div>


                </div>


            </div>


            <!-- ==========================================
                 BOOKING INFORMATION + PAYMENT
            =========================================== -->

            <div class="details-grid">


                <!-- ==========================================
                     BOOKING INFORMATION
                =========================================== -->

                <div class="details-card">


                    <h2>
                        Booking Information
                    </h2>


                    <div class="information-list">


                        <div class="information-row">

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


                        <div class="information-row">

                            <span>
                                Booking Date
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblBookingDate"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <div class="information-row">

                            <span>
                                Travel Date
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblTravelDate"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <div class="information-row">

                            <span>
                                Travellers
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblNumberOfPersons"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                        <div class="information-row">

                            <span>
                                Booking Status
                            </span>

                            <asp:Label
                                ID="lblBookingStatus"
                                runat="server"
                                CssClass="status-badge">
                            </asp:Label>

                        </div>


                        <div class="information-row">

                            <span>
                                Payment Status
                            </span>

                            <asp:Label
                                ID="lblPaymentStatus"
                                runat="server"
                                CssClass="payment-badge">
                            </asp:Label>

                        </div>


                    </div>


                </div>


                <!-- ==========================================
                     PAYMENT SUMMARY
                =========================================== -->

                <div class="details-card price-card">


                    <h2>
                        Payment Summary
                    </h2>


                    <div class="price-row">

                        <span>
                            Package Amount
                        </span>

                        <strong>

                            ₹<asp:Label
                                ID="lblPackageAmount"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>


                    <div class="price-row">

                        <span>
                            Tax
                        </span>

                        <strong>

                            ₹<asp:Label
                                ID="lblTaxAmount"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>


                    <hr />


                    <div class="total-row">

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
                 TRAVELLER DETAILS
            =========================================== -->

            <div class="details-card travellers-card">


                <div class="card-heading">

                    <div>

                        <h2>
                            Traveller Details
                        </h2>

                        <p>
                            People included in this booking.
                        </p>

                    </div>


                    <span class="traveller-count">

                        <asp:Label
                            ID="lblTravellerCount"
                            runat="server">
                        </asp:Label>

                    </span>

                </div>


                <div class="travellers-table-wrapper">


                    <table class="travellers-table">


                        <thead>

                            <tr>

                                <th>
                                    #
                                </th>

                                <th>
                                    Traveller Name
                                </th>

                                <th>
                                    Age
                                </th>

                                <th>
                                    Gender
                                </th>

                            </tr>

                        </thead>


                        <tbody>


                            <asp:Repeater
                                ID="rptTravellers"
                                runat="server">


                                <ItemTemplate>


                                    <tr>

                                        <td>

                                            <%# Container.ItemIndex + 1 %>

                                        </td>


                                        <td>

                                            <strong>

                                                <%# Eval("TravellerName") %>

                                            </strong>

                                        </td>


                                        <td>

                                            <%# Eval("Age") %>

                                        </td>


                                        <td>

                                            <%# Eval("Gender") %>

                                        </td>

                                    </tr>


                                </ItemTemplate>


                            </asp:Repeater>


                        </tbody>


                    </table>


                </div>


            </div>


            <!-- ==========================================
                 SPECIAL REQUEST
            =========================================== -->

            <div class="details-card special-request-card">


                <h2>
                    Special Request
                </h2>


                <asp:Panel
                    ID="pnlSpecialRequest"
                    runat="server">

                    <p class="special-request">

                        <asp:Label
                            ID="lblSpecialRequest"
                            runat="server">
                        </asp:Label>

                    </p>

                </asp:Panel>


                <asp:Panel
                    ID="pnlNoSpecialRequest"
                    runat="server"
                    Visible="false">

                    <p class="no-request">

                        No special request was added to this booking.

                    </p>

                </asp:Panel>


            </div>


            <!-- ==========================================
                 CANCEL BOOKING SECTION
            =========================================== -->

            <asp:Panel
                ID="pnlCancelBooking"
                runat="server"
                CssClass="cancel-card"
                Visible="false">


                <div class="cancel-info">


                    <h2>
                        Cancel Booking
                    </h2>


                    <p>
                        You can cancel this booking before the travel date.
                        Once the travel date starts, cancellation is no longer available.
                    </p>


                </div>


                <asp:Button
                    ID="btnCancelBooking"
                    runat="server"
                    Text="Cancel Booking"
                    CssClass="cancel-button"
                    OnClick="btnCancelBooking_Click"
                    OnClientClick="return confirmCancelBooking();" />


            </asp:Panel>


            <!-- ==========================================
                 CANCELLATION MESSAGE
            =========================================== -->

            <asp:Label
                ID="lblCancelMessage"
                runat="server"
                CssClass="cancel-message">
            </asp:Label>


        </asp:Panel>


    </div>


    <!-- ==========================================
         CANCEL CONFIRMATION JAVASCRIPT
    =========================================== -->

    <script>

        function confirmCancelBooking() {

            return confirm(
                "Are you sure you want to cancel this booking?"
            );

        }

    </script>


</asp:Content>
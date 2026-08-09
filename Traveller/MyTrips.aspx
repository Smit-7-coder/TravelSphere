<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="MyTrips.aspx.cs"
    Inherits="TravelSphere.Traveller.MyTrips" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/my-trips.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="trips-container">

        <!-- ==========================================
             PAGE HEADER
        =========================================== -->

        <div class="trips-header">

            <h1>My Trips</h1>

            <p>
                View and manage all your travel bookings.
            </p>

        </div>


        <!-- ==========================================
             UPCOMING TRIPS
        =========================================== -->

        <section class="trips-section">

            <div class="section-title">

                <h2>Upcoming Trips</h2>

            </div>


            <asp:Panel
                ID="pnlUpcomingEmpty"
                runat="server"
                CssClass="empty-message"
                Visible="false">

                <div class="empty-icon">
                    ✈
                </div>

                <h3>No Upcoming Trips</h3>

                <p>
                    You don't have any upcoming trips.
                </p>

                <a
                    href="Search.aspx"
                    class="explore-button">

                    Explore Destinations

                </a>

            </asp:Panel>


            <div class="trip-list">

                <asp:Repeater
                    ID="rptUpcomingTrips"
                    runat="server">

                    <ItemTemplate>

                        <div class="trip-card">

                            <!-- ==================================
                                 PACKAGE IMAGE
                            =================================== -->

                            <div class="trip-image">

                                <img
                                    src='<%# ResolveUrl("~/Assets/images/" + Eval("PackageImage")) %>'
                                    alt='<%# Eval("PackageName") %>' />

                            </div>


                            <!-- ==================================
                                 TRIP INFORMATION
                            =================================== -->

                            <div class="trip-content">

                                <div class="trip-main">

                                    <h3>
                                        <%# Eval("PackageName") %>
                                    </h3>


                                    <div class="trip-location">

                                        ●
                                        <%# Eval("DestinationName") %>,
                                        <%# Eval("State") %>

                                    </div>


                                    <div class="trip-info-grid">

                                        <div>

                                            <span>
                                                Booking ID
                                            </span>

                                            <strong>
                                                #<%# Eval("BookingId") %>
                                            </strong>

                                        </div>


                                        <div>

                                            <span>
                                                Travel Date
                                            </span>

                                            <strong>
                                                <%# Eval(
                                                    "TravelDate",
                                                    "{0:dd MMM yyyy}") %>
                                            </strong>

                                        </div>


                                        <div>

                                            <span>
                                                Persons
                                            </span>

                                            <strong>
                                                <%# Eval("NumberOfPersons") %>
                                            </strong>

                                        </div>


                                        <div>

                                            <span>
                                                Total Amount
                                            </span>

                                            <strong>
                                                ₹<%# Eval(
                                                    "TotalAmount",
                                                    "{0:N0}") %>
                                            </strong>

                                        </div>

                                    </div>

                                </div>


                                <!-- ==================================
                                     STATUS
                                =================================== -->

                                <div class="trip-side">

                                    <span class="booking-status">

                                        <%# Eval("BookingStatus") %>

                                    </span>


                                    <a
                                        href='BookingDetails.aspx?id=<%# Eval("BookingId") %>'
                                        class="view-trip-button">

                                        View Details

                                    </a>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </section>


        <!-- ==========================================
             PREVIOUS TRIPS
        =========================================== -->

        <section class="trips-section previous-section">

            <div class="section-title">

                <h2>Previous Trips</h2>

            </div>


            <asp:Panel
                ID="pnlPreviousEmpty"
                runat="server"
                CssClass="empty-message"
                Visible="false">

                <p>
                    You don't have any previous trips.
                </p>

            </asp:Panel>


            <div class="trip-list">

                <asp:Repeater
                    ID="rptPreviousTrips"
                    runat="server">

                    <ItemTemplate>

                        <div class="trip-card previous-trip">

                            <!-- IMAGE -->

                            <div class="trip-image">

                                <img
                                    src='<%# ResolveUrl("~/Assets/images/" + Eval("PackageImage")) %>'
                                    alt='<%# Eval("PackageName") %>' />

                            </div>


                            <!-- CONTENT -->

                            <div class="trip-content">

                                <div class="trip-main">

                                    <h3>
                                        <%# Eval("PackageName") %>
                                    </h3>


                                    <div class="trip-location">

                                        ●
                                        <%# Eval("DestinationName") %>,
                                        <%# Eval("State") %>

                                    </div>


                                    <div class="trip-info-grid">

                                        <div>

                                            <span>
                                                Booking ID
                                            </span>

                                            <strong>
                                                #<%# Eval("BookingId") %>
                                            </strong>

                                        </div>


                                        <div>

                                            <span>
                                                Travel Date
                                            </span>

                                            <strong>
                                                <%# Eval(
                                                    "TravelDate",
                                                    "{0:dd MMM yyyy}") %>
                                            </strong>

                                        </div>


                                        <div>

                                            <span>
                                                Persons
                                            </span>

                                            <strong>
                                                <%# Eval("NumberOfPersons") %>
                                            </strong>

                                        </div>


                                        <div>

                                            <span>
                                                Total Amount
                                            </span>

                                            <strong>
                                                ₹<%# Eval(
                                                    "TotalAmount",
                                                    "{0:N0}") %>
                                            </strong>

                                        </div>

                                    </div>

                                </div>


                                <div class="trip-side">

                                    <span class="completed-status">

                                        <%# Eval("BookingStatus") %>

                                    </span>


                                    <a
                                        href='BookingDetails.aspx?id=<%# Eval("BookingId") %>'
                                        class="view-trip-button">

                                        View Details

                                    </a>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </section>

    </div>

</asp:Content>
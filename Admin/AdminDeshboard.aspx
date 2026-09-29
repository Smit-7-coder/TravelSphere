<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AdminDeshboard.aspx.cs"
    Inherits="TravelSphere.Admin.AdminDeshboard"
    MasterPageFile="~/Admin/Admin.Master" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link rel="stylesheet" href="../Assets/Admincss/deshboard.css"/>;

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="dashboard-page">

        <!-- Hero Section -->
        <section class="dashboard-hero">

            <div class="hero-content">

                <h1>
                    Plan your packages for the world
                </h1>

                <p>
                    Welcome Back! Admin
                </p>

            </div>

            <img src="../Assets/Images/admin-avatar.png"
                 alt="Admin"
                 class="admin-avatar" />

        </section>


        <!-- Dashboard Content -->
        <section class="dashboard-content">

            <!-- Summary Cards -->
            <div class="summary-cards">

                <div class="summary-card">

                    <h3>Total Packages</h3>

                    <span>24</span>

                </div>


                <div class="summary-card">

                    <h3>Total Destinations</h3>

                    <span>24</span>

                </div>


                <div class="summary-card">

                    <h3>Total Bookings</h3>

                    <span>24</span>

                </div>

            </div>


            <!-- Recent Bookings + Buttons -->
            <div class="dashboard-lower-section">


                <!-- Recent Bookings -->
                <div class="recent-bookings-section">

                    <h2>Recent Bookings</h2>

                    <div class="booking-table-container">

                        <table class="booking-table">

                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Package</th>
                                    <th>Persons</th>
                                    <th>Payment Status</th>
                                </tr>
                            </thead>


                            <tbody>

                                <tr>
                                    <td>Rina Shah</td>
                                    <td>Ladakh Adventure<br />Tour</td>
                                    <td>5</td>
                                    <td>₹ 3,50,000</td>
                                </tr>


                                <tr>
                                    <td>Amit Varma</td>
                                    <td>Varanasi Spiritual<br />Tour</td>
                                    <td>4</td>
                                    <td>₹ 56,000</td>
                                </tr>


                                <tr>
                                    <td>Adna Patel</td>
                                    <td>Manali Adventure<br />Trip</td>
                                    <td>10</td>
                                    <td>₹ 1,20,000</td>
                                </tr>


                                <tr>
                                    <td>Sneha Roy</td>
                                    <td>Taj Mahal Weekend<br />Trip</td>
                                    <td>3</td>
                                    <td>₹ 75,000</td>
                                </tr>


                                <tr>
                                    <td>Krish Banerjee</td>
                                    <td>Kerala Backwater<br />Trip</td>
                                    <td>6</td>
                                    <td>₹ 4,56,000</td>
                                </tr>

                            </tbody>

                        </table>

                    </div>

                </div>


                <!-- Dashboard Buttons -->
                <div class="dashboard-actions">

                   <asp:Button
                        ID="btnAddPackage"
                        runat="server"
                        Text="Add Package"
                        CssClass="dashboard-action-button" />

                    <asp:Button
                        ID="btnViewPackages"
                        runat="server"
                        Text="View Packages"
                        CssClass="dashboard-action-button" />

                    <asp:Button
                        ID="btnViewBookings"
                        runat="server"
                        Text="View all Bookings"
                        CssClass="dashboard-action-button" />

                </div>

            </div>

        </section>

    </div>

</asp:Content>
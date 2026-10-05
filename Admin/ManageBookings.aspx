<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ManageBookings.aspx.cs"
    Inherits="TravelSphere.Admin.ManageBookings"
    MasterPageFile="~/Admin/Admin.Master" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/Admincss/mbooking.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">


    <div class="bookings-page">


        <!-- =========================================
             PAGE HEADER
        ========================================== -->

        <div class="page-top">

            <div class="page-title">

                <h1>Manage Bookings</h1>

                <p>
                    View and manage all customer bookings
                </p>

            </div>


            <!-- SEARCH -->

            <div class="search-wrapper">

                <span class="search-icon">
                    <i class="bi bi-search"></i>
                </span>

                <input
                    type="text"
                    id="bookingSearch"
                    class="booking-search"
                    placeholder="Search bookings..."
                    autocomplete="off" />

            </div>

        </div>



        <!-- =========================================
             SUMMARY
        ========================================== -->

        <div class="booking-summary">


            <!-- TOTAL -->

            <div class="summary-item">

                <span class="summary-label">
                    Total Bookings
                </span>

                <span
                    class="summary-value"
                    id="totalBookings">
                    5
                </span>

            </div>


            <!-- CONFIRMED -->

            <div class="summary-item">

                <span class="summary-label">
                    Confirmed
                </span>

                <span
                    class="summary-value confirmed-text"
                    id="confirmedBookings">
                    3
                </span>

            </div>


            <!-- CANCELLED -->

            <div class="summary-item">

                <span class="summary-label">
                    Cancelled
                </span>

                <span
                    class="summary-value cancelled-text"
                    id="cancelledBookings">
                    2
                </span>

            </div>


        </div>



        <!-- =========================================
             BOOKINGS CARD
        ========================================== -->

        <div class="bookings-card">


            <!-- CARD HEADER -->

            <div class="card-header">

                <div>

                    <h2>Recent Bookings</h2>

                    <p>
                        Customer booking details
                    </p>

                </div>

            </div>



            <!-- =========================================
                 TABLE
            ========================================== -->

            <div class="table-wrapper">

                <table
                    class="bookings-table"
                    id="bookingsTable">

                    <thead>

                        <tr>

                            <th>Booking ID</th>

                            <th>Customer</th>

                            <th>Package</th>

                            <th>Booking Date</th>

                            <th>Amount</th>

                            <th>Status</th>

                            <th>Actions</th>

                        </tr>

                    </thead>


                    <tbody>


                        <!-- =================================
                             BOOKING 001
                        ================================== -->

                        <tr>

                            <td>
                                <span class="booking-id">
                                    B-001
                                </span>
                            </td>


                            <td>

                                <div class="customer">

                                    <div class="customer-avatar">
                                        RS
                                    </div>

                                    <span>
                                        Rohan Sharma
                                    </span>

                                </div>

                            </td>


                            <td>
                                Ladakh Adventure Tour
                            </td>


                            <td>
                                15-04-2025
                            </td>


                            <td class="amount">
                                ₹ 3,50,000
                            </td>


                            <td>

                                <span class="status confirmed">
                                    Confirmed
                                </span>

                            </td>


                            <td>

                                <div class="action-buttons">

                                    <button
                                        type="button"
                                        class="action-btn cancel-btn"
                                        onclick="cancelBooking(this)"
                                        title="Cancel Booking"
                                        aria-label="Cancel Booking">

                                        <i class="bi bi-x-lg"></i>

                                    </button>


                                    <button
                                        type="button"
                                        class="action-btn delete-btn"
                                        onclick="deleteBooking(this)"
                                        title="Delete Booking"
                                        aria-label="Delete Booking">

                                        <i class="bi bi-trash3"></i>

                                    </button>

                                </div>

                            </td>

                        </tr>



                        <!-- =================================
                             BOOKING 002
                        ================================== -->

                        <tr>

                            <td>
                                <span class="booking-id">
                                    B-002
                                </span>
                            </td>


                            <td>

                                <div class="customer">

                                    <div class="customer-avatar">
                                        PT
                                    </div>

                                    <span>
                                        Priya Trivedi
                                    </span>

                                </div>

                            </td>


                            <td>
                                Varanasi Spiritual Tour
                            </td>


                            <td>
                                12-04-2025
                            </td>


                            <td class="amount">
                                ₹ 56,000
                            </td>


                            <td>

                                <span class="status cancelled">
                                    Cancelled
                                </span>

                            </td>


                            <td>

                                <div class="action-buttons">

                                    <button
                                        type="button"
                                        class="action-btn cancel-btn"
                                        onclick="cancelBooking(this)"
                                        title="Cancel Booking"
                                        aria-label="Cancel Booking">

                                        <i class="bi bi-x-lg"></i>

                                    </button>


                                    <button
                                        type="button"
                                        class="action-btn delete-btn"
                                        onclick="deleteBooking(this)"
                                        title="Delete Booking"
                                        aria-label="Delete Booking">

                                        <i class="bi bi-trash3"></i>

                                    </button>

                                </div>

                            </td>

                        </tr>



                        <!-- =================================
                             BOOKING 003
                        ================================== -->

                        <tr>

                            <td>
                                <span class="booking-id">
                                    B-003
                                </span>
                            </td>


                            <td>

                                <div class="customer">

                                    <div class="customer-avatar">
                                        AK
                                    </div>

                                    <span>
                                        Anil Kapoor
                                    </span>

                                </div>

                            </td>


                            <td>
                                Manali Adventure Trip
                            </td>


                            <td>
                                10-04-2025
                            </td>


                            <td class="amount">
                                ₹ 1,20,000
                            </td>


                            <td>

                                <span class="status confirmed">
                                    Confirmed
                                </span>

                            </td>


                            <td>

                                <div class="action-buttons">

                                    <button
                                        type="button"
                                        class="action-btn cancel-btn"
                                        onclick="cancelBooking(this)"
                                        title="Cancel Booking"
                                        aria-label="Cancel Booking">

                                        <i class="bi bi-x-lg"></i>

                                    </button>


                                    <button
                                        type="button"
                                        class="action-btn delete-btn"
                                        onclick="deleteBooking(this)"
                                        title="Delete Booking"
                                        aria-label="Delete Booking">

                                        <i class="bi bi-trash3"></i>

                                    </button>

                                </div>

                            </td>

                        </tr>



                        <!-- =================================
                             BOOKING 004
                        ================================== -->

                        <tr>

                            <td>
                                <span class="booking-id">
                                    B-004
                                </span>
                            </td>


                            <td>

                                <div class="customer">

                                    <div class="customer-avatar">
                                        SJ
                                    </div>

                                    <span>
                                        Santosh Joshi
                                    </span>

                                </div>

                            </td>


                            <td>
                                Taj Mahal Weekend Trip
                            </td>


                            <td>
                                05-04-2025
                            </td>


                            <td class="amount">
                                ₹ 75,000
                            </td>


                            <td>

                                <span class="status confirmed">
                                    Confirmed
                                </span>

                            </td>


                            <td>

                                <div class="action-buttons">

                                    <button
                                        type="button"
                                        class="action-btn cancel-btn"
                                        onclick="cancelBooking(this)"
                                        title="Cancel Booking"
                                        aria-label="Cancel Booking">

                                        <i class="bi bi-x-lg"></i>

                                    </button>


                                    <button
                                        type="button"
                                        class="action-btn delete-btn"
                                        onclick="deleteBooking(this)"
                                        title="Delete Booking"
                                        aria-label="Delete Booking">

                                        <i class="bi bi-trash3"></i>

                                    </button>

                                </div>

                            </td>

                        </tr>



                        <!-- =================================
                             BOOKING 005
                        ================================== -->

                        <tr>

                            <td>
                                <span class="booking-id">
                                    B-005
                                </span>
                            </td>


                            <td>

                                <div class="customer">

                                    <div class="customer-avatar">
                                        NM
                                    </div>

                                    <span>
                                        Neha Mehta
                                    </span>

                                </div>

                            </td>


                            <td>
                                Kerala Backwater Trip
                            </td>


                            <td>
                                30-04-2025
                            </td>


                            <td class="amount">
                                ₹ 4,56,000
                            </td>


                            <td>

                                <span class="status cancelled">
                                    Cancelled
                                </span>

                            </td>


                            <td>

                                <div class="action-buttons">


                                    <button
                                        type="button"
                                        class="action-btn cancel-btn"
                                        onclick="cancelBooking(this)"
                                        title="Cancel Booking"
                                        aria-label="Cancel Booking">

                                        <i class="bi bi-x-lg"></i>

                                    </button>


                                    <button
                                        type="button"
                                        class="action-btn delete-btn"
                                        onclick="deleteBooking(this)"
                                        title="Delete Booking"
                                        aria-label="Delete Booking">

                                        <i class="bi bi-trash3"></i>

                                    </button>

                                </div>

                            </td>

                        </tr>


                    </tbody>

                </table>

            </div>

        </div>


    </div>



    <!-- =========================================
         BOOKING MANAGEMENT SCRIPT
    ========================================== -->

    <script>

        document.addEventListener("DOMContentLoaded", function () {

            updateSummary();


            /* =====================================
               SEARCH
            ===================================== */

            var searchBox =
                document.getElementById("bookingSearch");


            if (searchBox) {

                searchBox.addEventListener("input", function () {

                    var searchText =
                        searchBox.value
                            .trim()
                            .toLowerCase();


                    var rows =
                        document.querySelectorAll(
                            "#bookingsTable tbody tr"
                        );


                    rows.forEach(function (row) {

                        var rowText =
                            row.textContent.toLowerCase();


                        if (rowText.includes(searchText)) {

                            row.style.display = "";

                        }
                        else {

                            row.style.display = "none";

                        }

                    });

                });

            }

        });



        /* =========================================
           CONFIRM BOOKING
        ========================================== */

        function confirmBooking(button) {

            var row =
                button.closest("tr");


            if (!row) {
                return;
            }


            var status =
                row.querySelector(".status");


            if (!status) {
                return;
            }


            if (
                status.classList.contains("confirmed")
            ) {

                alert(
                    "This booking is already confirmed."
                );

                return;

            }


            status.textContent =
                "Confirmed";


            status.classList.remove(
                "cancelled"
            );


            status.classList.add(
                "confirmed"
            );


            updateSummary();


            alert(
                "Booking confirmed successfully."
            );

        }



        /* =========================================
           CANCEL BOOKING
        ========================================== */

        function cancelBooking(button) {

            var row =
                button.closest("tr");


            if (!row) {
                return;
            }


            var status =
                row.querySelector(".status");


            if (!status) {
                return;
            }


            if (
                status.classList.contains("cancelled")
            ) {

                alert(
                    "This booking is already cancelled."
                );

                return;

            }


            var result =
                confirm(
                    "Are you sure you want to cancel this booking?"
                );


            if (!result) {
                return;
            }


            status.textContent =
                "Cancelled";


            status.classList.remove(
                "confirmed"
            );


            status.classList.add(
                "cancelled"
            );


            updateSummary();


            alert(
                "Booking cancelled successfully."
            );

        }



        /* =========================================
           DELETE BOOKING
        ========================================== */

        function deleteBooking(button) {

            var row =
                button.closest("tr");


            if (!row) {
                return;
            }


            var bookingIdElement =
                row.querySelector(".booking-id");


            var bookingId =
                bookingIdElement
                    ? bookingIdElement.textContent.trim()
                    : "this booking";


            var result =
                confirm(
                    "Are you sure you want to delete booking " +
                    bookingId +
                    "?"
                );


            if (!result) {
                return;
            }


            row.remove();


            updateSummary();


            alert(
                "Booking " +
                bookingId +
                " deleted successfully."
            );

        }



        /* =========================================
           UPDATE SUMMARY
        ========================================== */

        function updateSummary() {

            var rows =
                document.querySelectorAll(
                    "#bookingsTable tbody tr"
                );


            var total = 0;

            var confirmed = 0;

            var cancelled = 0;


            rows.forEach(function (row) {

                total++;


                var status =
                    row.querySelector(".status");


                if (!status) {
                    return;
                }


                if (
                    status.classList.contains(
                        "confirmed"
                    )
                ) {

                    confirmed++;

                }


                if (
                    status.classList.contains(
                        "cancelled"
                    )
                ) {

                    cancelled++;

                }

            });


            var totalElement =
                document.getElementById(
                    "totalBookings"
                );


            var confirmedElement =
                document.getElementById(
                    "confirmedBookings"
                );


            var cancelledElement =
                document.getElementById(
                    "cancelledBookings"
                );


            if (totalElement) {

                totalElement.textContent =
                    total;

            }


            if (confirmedElement) {

                confirmedElement.textContent =
                    confirmed;

            }


            if (cancelledElement) {

                cancelledElement.textContent =
                    cancelled;

            }

        }

    </script>


</asp:Content>

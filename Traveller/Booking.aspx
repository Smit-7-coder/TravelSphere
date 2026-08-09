<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="Booking.aspx.cs"
    Inherits="TravelSphere.Traveller.Booking" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/booking.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">


    <!-- ==========================================
         BOOKING CONTAINER
    =========================================== -->

    <div class="booking-container">


        <h1>
            Complete Your Booking
        </h1>


        <p class="booking-subtitle">
            Enter your travel details and confirm your trip.
        </p>


        <!-- ==========================================
             PACKAGE SUMMARY
        =========================================== -->

        <div class="package-summary">


            <asp:Image
                ID="imgPackage"
                runat="server"
                CssClass="package-summary-image" />


            <div class="package-summary-info">


                <h2>

                    <asp:Label
                        ID="lblPackageName"
                        runat="server">
                    </asp:Label>

                </h2>


                <p>

                    <asp:Label
                        ID="lblDestination"
                        runat="server">
                    </asp:Label>

                </p>


                <div class="package-summary-details">


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

                        Adult:

                        <strong>

                            ₹<asp:Label
                                ID="lblAdultPrice"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </span>


                    <span>

                        Child:

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
             BOOKING GRID
        =========================================== -->

        <div class="booking-grid">


            <!-- ==========================================
                 LEFT SIDE - BOOKING FORM
            =========================================== -->

            <div class="booking-form card">


                <h2>
                    Traveller Details
                </h2>


                <!-- ==========================================
                     FULL NAME
                =========================================== -->

                <div class="form-group">


                    <label>
                        Full Name
                    </label>


                    <asp:TextBox
                        ID="txtFullName"
                        runat="server"
                        CssClass="form-control">
                    </asp:TextBox>


                    <asp:RequiredFieldValidator
                        ID="rfvFullName"
                        runat="server"
                        ControlToValidate="txtFullName"
                        ErrorMessage="Full Name is required."
                        ForeColor="Red"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>


                </div>


                <!-- ==========================================
                     EMAIL
                =========================================== -->

                <div class="form-group">


                    <label>
                        Email
                    </label>


                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        TextMode="Email"
                        CssClass="form-control">
                    </asp:TextBox>


                    <asp:RequiredFieldValidator
                        ID="rfvEmail"
                        runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email is required."
                        ForeColor="Red"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>


                </div>


                <!-- ==========================================
                     PHONE
                =========================================== -->

                <div class="form-group">


                    <label>
                        Phone Number
                    </label>


                    <asp:TextBox
                        ID="txtPhone"
                        runat="server"
                        MaxLength="10"
                        CssClass="form-control">
                    </asp:TextBox>


                    <asp:RequiredFieldValidator
                        ID="rfvPhone"
                        runat="server"
                        ControlToValidate="txtPhone"
                        ErrorMessage="Phone number is required."
                        ForeColor="Red"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>


                </div>


                <!-- ==========================================
                     TRAVEL DATE
                =========================================== -->

                <div class="form-group">


                    <label>
                        Travel Date
                    </label>


                    <asp:TextBox
                        ID="txtTravelDate"
                        runat="server"
                        TextMode="Date"
                        CssClass="form-control">
                    </asp:TextBox>


                    <asp:RequiredFieldValidator
                        ID="rfvTravelDate"
                        runat="server"
                        ControlToValidate="txtTravelDate"
                        ErrorMessage="Travel date is required."
                        ForeColor="Red"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>


                </div>


                <!-- ==========================================
                     NUMBER OF ADULTS
                =========================================== -->

                <div class="form-group">


                    <label>
                        Number of Adults
                    </label>


                    <asp:TextBox
                        ID="txtAdults"
                        runat="server"
                        Text="1"
                        TextMode="Number"
                        CssClass="form-control"
                        min="1"
                        oninput="calculateBookingTotal(); generateTravellerFields();">
                    </asp:TextBox>


                </div>


                <!-- ==========================================
                     NUMBER OF CHILDREN
                =========================================== -->

                <div class="form-group">


                    <label>
                        Number of Children
                    </label>


                    <asp:TextBox
                        ID="txtChildren"
                        runat="server"
                        Text="0"
                        TextMode="Number"
                        CssClass="form-control"
                        min="0"
                        oninput="calculateBookingTotal(); generateTravellerFields();">
                    </asp:TextBox>


                </div>


                <!-- ==========================================
                     TRAVELLER DETAILS
                =========================================== -->

                <div class="traveller-details-section">


                    <h2>
                        Traveller Information
                    </h2>


                    <p class="traveller-info">
                        Enter the details of all people travelling.
                    </p>


                    <div id="travellerContainer">
                    </div>


                </div>


                <!-- ==========================================
                     SPECIAL REQUEST
                =========================================== -->

                <div class="form-group">


                    <label>
                        Special Request
                    </label>


                    <asp:TextBox
                        ID="txtSpecialRequest"
                        runat="server"
                        TextMode="MultiLine"
                        Rows="4"
                        CssClass="form-control">
                    </asp:TextBox>


                </div>


                <!-- ==========================================
                     CONFIRM BOOKING
                =========================================== -->

                <asp:Button
                    ID="btnConfirmBooking"
                    runat="server"
                    Text="Confirm Booking"
                    CssClass="confirm-button"
                    OnClick="btnConfirmBooking_Click" />


                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="booking-message">
                </asp:Label>


            </div>


            <!-- ==========================================
                 RIGHT SIDE - PRICE SUMMARY
            =========================================== -->

            <div class="price-card card">


                <h2>
                    Booking Summary
                </h2>


                <!-- ==========================================
                     ADULT PRICE
                =========================================== -->

                <div class="price-row">


                    <span>
                        Adult Price
                    </span>


                    <strong>

                        ₹<span id="adultPrice">

                            <asp:Label
                                ID="lblAdultSummary"
                                runat="server">
                            </asp:Label>

                        </span>

                    </strong>


                </div>


                <!-- ==========================================
                     CHILD PRICE
                =========================================== -->

                <div class="price-row">


                    <span>
                        Child Price
                    </span>


                    <strong>

                        ₹<span id="childPrice">

                            <asp:Label
                                ID="lblChildSummary"
                                runat="server">
                            </asp:Label>

                        </span>

                    </strong>


                </div>


                <hr />


                <!-- ==========================================
                     ADULT COUNT
                =========================================== -->

                <div class="price-row">


                    <span>
                        Adults
                    </span>


                    <strong>

                        <span id="adultCount">
                            1
                        </span>

                    </strong>


                </div>


                <!-- ==========================================
                     CHILD COUNT
                =========================================== -->

                <div class="price-row">


                    <span>
                        Children
                    </span>


                    <strong>

                        <span id="childCount">
                            0
                        </span>

                    </strong>


                </div>


                <hr />


                <!-- ==========================================
                     TOTAL AMOUNT
                =========================================== -->

                <div class="total-row">


                    <span>
                        Total Amount
                    </span>


                    <strong>

                        ₹<span id="totalAmount">

                            <asp:Label
                                ID="lblTotalAmount"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </span>

                    </strong>


                </div>


            </div>


        </div>


    </div>


    <!-- ==========================================
         JAVASCRIPT
    =========================================== -->

    <script>


        // ==========================================
        // CALCULATE BOOKING TOTAL
        // ==========================================

        function calculateBookingTotal() {


            // ==========================================
            // GET ADULT COUNT
            // ==========================================

            let adults = parseInt(

                document.getElementById(
                    '<%= txtAdults.ClientID %>'
                ).value

            ) || 0;


            // ==========================================
            // GET CHILD COUNT
            // ==========================================

            let children = parseInt(

                document.getElementById(
                    '<%= txtChildren.ClientID %>'
                ).value

            ) || 0;


            // ==========================================
            // MINIMUM VALUES
            // ==========================================

            if (adults < 1) {

                adults = 1;

            }


            if (children < 0) {

                children = 0;

            }


            // ==========================================
            // GET ADULT PRICE
            // ==========================================

            let adultPrice = parseFloat(

                document.getElementById(
                    'adultPrice'
                ).innerText.replace(/,/g, '')

            ) || 0;


            // ==========================================
            // GET CHILD PRICE
            // ==========================================

            let childPrice = parseFloat(

                document.getElementById(
                    'childPrice'
                ).innerText.replace(/,/g, '')

            ) || 0;


            // ==========================================
            // CALCULATE ADULT AMOUNT
            // ==========================================

            let adultAmount =
                adults * adultPrice;


            // ==========================================
            // CALCULATE CHILD AMOUNT
            // ==========================================

            let childAmount =
                children * childPrice;


            // ==========================================
            // CALCULATE TOTAL
            // ==========================================

            let total =
                adultAmount + childAmount;


            // ==========================================
            // UPDATE ADULT COUNT
            // ==========================================

            document.getElementById(
                'adultCount'
            ).innerText = adults;


            // ==========================================
            // UPDATE CHILD COUNT
            // ==========================================

            document.getElementById(
                'childCount'
            ).innerText = children;


            // ==========================================
            // UPDATE TOTAL
            // ==========================================

            document.getElementById(
                'totalAmount'
            ).innerText =

                total.toLocaleString(
                    'en-IN'
                );

        }


        // ==========================================
        // GENERATE TRAVELLER FIELDS
        // ==========================================

        function generateTravellerFields() {


            // ==========================================
            // GET ADULT COUNT
            // ==========================================

            let adults = parseInt(

                document.getElementById(
                    '<%= txtAdults.ClientID %>'
                ).value

            ) || 0;


            // ==========================================
            // GET CHILD COUNT
            // ==========================================

            let children = parseInt(

                document.getElementById(
                    '<%= txtChildren.ClientID %>'
                ).value

            ) || 0;


            // ==========================================
            // MINIMUM VALUES
            // ==========================================

            if (adults < 1) {

                adults = 1;

            }


            if (children < 0) {

                children = 0;

            }


            // ==========================================
            // TOTAL TRAVELLERS
            // ==========================================

            let totalTravellers =
                adults + children;


            // ==========================================
            // GET CONTAINER
            // ==========================================

            let container =
                document.getElementById(
                    'travellerContainer'
                );


            // ==========================================
            // CLEAR OLD FIELDS
            // ==========================================

            container.innerHTML = '';


            // ==========================================
            // CREATE TRAVELLER FIELDS
            // ==========================================

            for (
                let i = 1;
                i <= totalTravellers;
                i++
            ) {


                let card =
                    document.createElement(
                        'div'
                    );


                card.className =
                    'traveller-card';


                card.innerHTML = `

                    <h3>
                        Traveller ${i}
                    </h3>


                    <div class="traveller-form-grid">


                        <!-- NAME -->

                        <div class="traveller-field">


                            <label>
                                Traveller Name
                            </label>


                            <input
                                type="text"
                                name="TravellerName_${i}"
                                class="traveller-input"
                                placeholder="Enter traveller name"
                                required />


                        </div>


                        <!-- AGE -->

                        <div class="traveller-field">


                            <label>
                                Age
                            </label>


                            <input
                                type="number"
                                name="TravellerAge_${i}"
                                class="traveller-input"
                                placeholder="Age"
                                min="1"
                                max="120"
                                required />


                        </div>


                        <!-- GENDER -->

                        <div class="traveller-field">


                            <label>
                                Gender
                            </label>


                            <select
                                name="TravellerGender_${i}"
                                class="traveller-input"
                                required>


                                <option value="">
                                    Select
                                </option>


                                <option value="Male">
                                    Male
                                </option>


                                <option value="Female">
                                    Female
                                </option>


                                <option value="Other">
                                    Other
                                </option>


                            </select>


                        </div>


                    </div>

                `;


                container.appendChild(
                    card
                );

            }

        }


        // ==========================================
        // PAGE LOAD
        // ==========================================

        window.onload = function () {


            calculateBookingTotal();


            generateTravellerFields();


        };


    </script>


</asp:Content>
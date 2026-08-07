<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="PackageDetails.aspx.cs"
    Inherits="TravelSphere.Traveller.PackageDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Assets/css/package-details.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="package-container">

    <!-- Banner -->

    <div class="banner">

        <asp:Image
            ID="imgPackage"
            runat="server"
            CssClass="banner-image" />

    </div>

    <!-- Package Name -->

    <h1>

        <asp:Label
            ID="lblPackageName"
            runat="server">
        </asp:Label>

    </h1>

    <h4>

        <asp:Label
            ID="lblDestination"
            runat="server">
        </asp:Label>

    </h4>


    <div class="details-grid">

        <!-- Left -->

        <div class="left-section">

            <div class="card">

                <h2>About Package</h2>

                <asp:Label
                    ID="lblDescription"
                    runat="server">
                </asp:Label>

            </div>


            <div class="card">

                <h2>Stay Details</h2>

                <p><strong>Hotel :</strong>
                    <asp:Label ID="lblHotel" runat="server"></asp:Label>
                </p>

                <p><strong>Room Type :</strong>
                    <asp:Label ID="lblRoomType" runat="server"></asp:Label>
                </p>

                <p><strong>Meals :</strong>
                    <asp:Label ID="lblMeals" runat="server"></asp:Label>
                </p>

            </div>

        </div>


        <!-- Right -->

        <div class="right-section">

            <div class="info-card">

                <h2>Package Information</h2>

                <p><strong>Duration :</strong>
                    <asp:Label ID="lblDuration" runat="server"></asp:Label>
                </p>

                <p><strong>Adult Price :</strong>
                    ₹<asp:Label ID="lblAdultPrice" runat="server"></asp:Label>
                </p>

                <p><strong>Child Price :</strong>
                    ₹<asp:Label ID="lblChildPrice" runat="server"></asp:Label>
                </p>

                <p><strong>Transport :</strong>
                    <asp:Label ID="lblTransport" runat="server"></asp:Label>
                </p>

                <p><strong>Best Season :</strong>
                    <asp:Label ID="lblSeason" runat="server"></asp:Label>
                </p>

                <asp:Button
                    ID="btnBookNow"
                    runat="server"
                    Text="Book Now"
                    CssClass="book-btn"
                    OnClick="btnBookNow_Click" />

            </div>

        </div>

    </div>


    <!-- Itinerary -->

    <div class="card itinerary">

        <h2>Day Wise Itinerary</h2>

        <asp:Repeater
            ID="rptItinerary"
            runat="server">

            <ItemTemplate>

                <div class="day-card">

                    <h3>
                        Day <%# Eval("DayNumber") %>
                    </h3>

                    <h4>
                        <%# Eval("Title") %>
                    </h4>

                    <p>
                        <%# Eval("Description") %>
                    </p>

                </div>

            </ItemTemplate>

        </asp:Repeater>

    </div>

</div>

</asp:Content>
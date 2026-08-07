<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="Home.aspx.cs"
    Inherits="TravelSphere.Traveller.Home" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/home.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">


    <!-- ==========================================
         HERO SECTION
    =========================================== -->

    <section class="hero-section">
</section>



    <!-- ==========================================
         PAGE CONTENT
    =========================================== -->

    <div class="home-container">


        <!-- ======================================
             POPULAR DESTINATIONS
        ======================================= -->

        <section class="home-section">

            <div class="section-header">

                <div>
                    <h2>Popular Destinations</h2>

                    <p>
                        Discover the most loved destinations
                    </p>
                </div>


                <a href="Search.aspx" class="view-all">

                    View All

                    <span>→</span>

                </a>

            </div>



            <!-- DESTINATION CARDS -->

            <div class="destination-grid">


                <asp:Repeater
                    ID="rptDestinations"
                    runat="server">

                    <ItemTemplate>


                        <div class="destination-card">


                            <!-- IMAGE -->

                            <div class="destination-image">

                                <img
                                    src='<%# ResolveUrl("~/Assets/images/" + Eval("Image")) %>'
                                    alt='<%# Eval("DestinationName") %>' />

                            </div>



                            <!-- CONTENT -->

                            <div class="destination-content">

                                <h3>
                                    <%# Eval("DestinationName") %>
                                </h3>


                                <div class="destination-location">

                                    <span class="location-icon">●</span>

                                    <%# Eval("State") %>

                                </div>


                                <p>
                                    <%# Eval("Description") %>
                                </p>


                                <a
                                      href='<%# ResolveUrl("~/Traveller/DestinationDetails.aspx?id=" + Eval("DestinationId")) %>'
                                    class="view-btn">

                                    View

                                </a>


                            </div>


                        </div>


                    </ItemTemplate>

                </asp:Repeater>


            </div>

        </section>



        <!-- ======================================
             POPULAR PACKAGES
        ======================================= -->

        <section class="home-section package-section">


            <div class="section-header">

                <div>

                    <h2>Popular Packages</h2>

                    <p>
                        Handpicked travel experiences for you
                    </p>

                </div>

            </div>



            <div class="package-list">


                <asp:Repeater
                    ID="rptPackages"
                    runat="server">

                    <ItemTemplate>


                        <div class="package-card">


                            <!-- PACKAGE IMAGE -->

                            <div class="package-image">

                                <img
                                    src='<%# ResolveUrl("~/Assets/images/" + Eval("PackageImage")) %>'
                                    alt='<%# Eval("PackageName") %>' />

                            </div>



                            <!-- PACKAGE INFO -->

                            <div class="package-content">


                                <div class="package-main-info">

                                    <h3>
                                        <%# Eval("PackageName") %>
                                    </h3>


                                    <div class="package-location">

                                        <%# Eval("DestinationName") %>,
                                        <%# Eval("State") %>

                                    </div>


                                    <p>
                                        <%# Eval("Description") %>
                                    </p>


                                    <!-- DETAILS -->

                                    <div class="package-details">


                                        <span>

                                            <strong>
                                                <%# Eval("DurationDays") %>
                                            </strong>

                                            Days

                                        </span>


                                        <span>

                                            ₹<%# Eval("AdultPrice", "{0:N0}") %>

                                        </span>


                                    </div>

                                </div>



                                <!-- VIEW DETAILS -->

                                <div class="package-action">

                                    <a
                                        href='<%# ResolveUrl("~/Traveller/PackageDetails.aspx?id=" + Eval("PackageId")) %>'
                                        class="details-btn">

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
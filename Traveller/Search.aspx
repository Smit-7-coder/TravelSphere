<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="Search.aspx.cs"
    Inherits="TravelSphere.Traveller.Search" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/search.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="search-container">

        <!-- ==========================================
             SEARCH HEADER
        =========================================== -->

        <div class="search-header">

            <h1>Explore Gujarat</h1>

            <p>
                Search destinations and travel packages
                for your next adventure.
            </p>

        </div>


        <!-- ==========================================
             SEARCH BOX
        =========================================== -->

        <div class="search-box">

            <asp:TextBox
                ID="txtSearch"
                runat="server"
                CssClass="search-input"
                placeholder="Search destination or package...">
            </asp:TextBox>


            <asp:Button
                ID="btnSearch"
                runat="server"
                Text="Search"
                CssClass="search-button"
                OnClick="btnSearch_Click" />

        </div>


        <!-- ==========================================
             SEARCH MESSAGE
        =========================================== -->

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="search-message">
        </asp:Label>


        <!-- ==========================================
             DESTINATIONS
        =========================================== -->

        <section class="result-section">

            <div class="result-title">

                <h2>Destinations</h2>

            </div>


            <div class="destination-grid">

                <asp:Repeater
                    ID="rptDestinations"
                    runat="server">

                    <ItemTemplate>

                        <div class="destination-card">

                            <div class="destination-image">

                                <img
                                    src='<%# ResolveUrl("~/Assets/images/" + Eval("Image")) %>'
                                    alt='<%# Eval("DestinationName") %>' />

                            </div>


                            <div class="destination-content">

                                <h3>
                                    <%# Eval("DestinationName") %>
                                </h3>


                                <div class="destination-state">

                                    <span>●</span>

                                    <%# Eval("State") %>

                                </div>


                                <p>
                                    <%# Eval("Description") %>
                                </p>


                                <a
                                    href='<%# ResolveUrl("~/Traveller/DestinationDetails.aspx?id=" + Eval("DestinationId")) %>'
                                    class="view-button">

                                    View

                                </a>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </section>


        <!-- ==========================================
             PACKAGES
        =========================================== -->

        <section class="result-section package-result-section">

            <div class="result-title">

                <h2>Travel Packages</h2>

            </div>


            <div class="package-grid">

                <asp:Repeater
                    ID="rptPackages"
                    runat="server">

                    <ItemTemplate>

                        <div class="package-card">

                            <div class="package-image">

                                <img
                                    src='<%# ResolveUrl("~/Assets/images/" + Eval("PackageImage")) %>'
                                    alt='<%# Eval("PackageName") %>' />

                            </div>


                            <div class="package-content">

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


                                <div class="package-bottom">

                                    <div class="package-price">

                                        <strong>
                                            ₹<%# Eval("AdultPrice", "{0:N0}") %>
                                        </strong>

                                        <span>
                                            / Adult
                                        </span>

                                    </div>


                                    <div class="package-duration">

                                        <%# Eval("DurationDays") %>
                                        Days

                                    </div>


                                    <a
                                        href='<%# ResolveUrl("~/Traveller/PackageDetails.aspx?id=" + Eval("PackageId")) %>'
                                        class="details-button">

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
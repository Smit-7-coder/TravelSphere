<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="DestinationDetails.aspx.cs"
    Inherits="TravelSphere.Traveller.DestinationDetails" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/destination-details.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">


<div class="destination-container">

    <!-- Hero Image -->

    <div class="hero-image">

        <asp:Image
            ID="imgDestination"
            runat="server"
            CssClass="destination-img" />

    </div>



    <!-- Destination Details -->

    <div class="destination-details">

        <h1>

            <asp:Label
                ID="lblDestinationName"
                runat="server">
            </asp:Label>

        </h1>

        <div class="destination-state">

            <asp:Label
                ID="lblState"
                runat="server">
            </asp:Label>

        </div>


        <div class="destination-type">

            <strong>Destination Type :</strong>

            <asp:Label
                ID="lblType"
                runat="server">
            </asp:Label>

        </div>


        <div class="description">

            <asp:Label
                ID="lblDescription"
                runat="server">
            </asp:Label>

        </div>

    </div>



    <!-- Packages -->

    <div class="package-section">

        <h2>Available Packages</h2>


        <asp:Repeater
            ID="rptPackages"
            runat="server">

            <ItemTemplate>

                <div class="package-card">

                    <img
                        src='<%# ResolveUrl("~/Assets/images/" + Eval("PackageImage")) %>' />

                    <div class="package-info">

                        <h3>

                            <%# Eval("PackageName") %>

                        </h3>

                        <p>

                            <%# Eval("Description") %>

                        </p>

                        <div class="package-footer">

                            <span>

                                <%# Eval("DurationDays") %> Days

                            </span>

                            <span>

                                ₹<%# Eval("AdultPrice","{0:N0}") %>

                            </span>

                            <a href='PackageDetails.aspx?id=<%# Eval("PackageId") %>'>

                                View Details

                            </a>

                        </div>

                    </div>

                </div>

            </ItemTemplate>

        </asp:Repeater>

    </div>

</div>

</asp:Content>
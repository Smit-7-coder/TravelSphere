<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ManagePackages.aspx.cs"
    Inherits="TravelSphere.Admin.ManagePackages"
    MasterPageFile="~/Admin/Admin.Master" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/Admincss/mpackage.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="packages-page">

        <!-- Page Header -->
        <div class="packages-header">

            <h1>Manage Packages</h1>

            <asp:Button
                ID="btnAddPackage"
                runat="server"
                Text="+ Add New Package"
                PostBackUrl="~/Admin/AddNewPackages.aspx"
                CssClass="add-package-button" 
                />
                

        </div>


        <!-- Packages Table -->
        <div class="packages-container">

            <table class="packages-table">

                <thead>
                    <tr>
                        <th>Package Name</th>
                        <th>Location</th>
                        <th>Duration</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>


                <tbody>

                    <!-- Row 1 -->
                    <tr>

                        <td>Ladakh Adventure Tour</td>

                        <td>
                            Ladakh,<br />
                            Jammu &amp; Kashmir
                        </td>

                        <td>7 Days</td>

                        <td>₹ 3,50,000</td>

                        <td>
                            <div class="action-buttons">

                                <button
                                    type="button"
                                    class="icon-button edit-button"
                                    title="Edit Package">
                                    ✎
                                </button>

                                <button
                                    type="button"
                                    class="icon-button delete-button"
                                    title="Delete Package">
                                    🗑
                                </button>

                            </div>
                        </td>

                    </tr>


                    <!-- Row 2 -->
                    <tr>

                        <td>Varanasi Spiritual Tour</td>

                        <td>
                            Varanasi,<br />
                            Uttar Pradesh
                        </td>

                        <td>6 Days</td>

                        <td>₹ 56,000</td>

                        <td>
                            <div class="action-buttons">

                                <button
                                    type="button"
                                    class="icon-button edit-button"
                                    title="Edit Package">
                                    ✎
                                </button>

                                <button
                                    type="button"
                                    class="icon-button delete-button"
                                    title="Delete Package">
                                    🗑
                                </button>

                            </div>
                        </td>

                    </tr>


                    <!-- Row 3 -->
                    <tr>

                        <td>Manali Adventure Trip</td>

                        <td>
                            Himachal<br />
                            Pradesh
                        </td>

                        <td>5 Days</td>

                        <td>₹ 1,20,000</td>

                        <td>
                            <div class="action-buttons">

                                <button
                                    type="button"
                                    class="icon-button edit-button"
                                    title="Edit Package">
                                    ✎
                                </button>

                                <button
                                    type="button"
                                    class="icon-button delete-button"
                                    title="Delete Package">
                                    🗑
                                </button>

                            </div>
                        </td>

                    </tr>


                    <!-- Row 4 -->
                    <tr>

                        <td>Taj Mahal Weekend Trip</td>

                        <td>
                            Agra,<br />
                            Uttar Pradesh
                        </td>

                        <td>2 Days</td>

                        <td>₹ 75,000</td>

                        <td>
                            <div class="action-buttons">

                                <button
                                    type="button"
                                    class="icon-button edit-button"
                                    title="Edit Package">
                                    ✎
                                </button>

                                <button
                                    type="button"
                                    class="icon-button delete-button"
                                    title="Delete Package">
                                    🗑
                                </button>

                            </div>
                        </td>

                    </tr>


                    <!-- Row 5 -->
                    <tr>

                        <td>Kerala Backwater Trip</td>

                        <td>
                            Alappuzha,<br />
                            Kerala
                        </td>

                        <td>9 Days</td>

                        <td>₹ 4,56,000</td>

                        <td>
                            <div class="action-buttons">

                                <button
                                    type="button"
                                    class="icon-button edit-button"
                                    title="Edit Package">
                                    ✎
                                </button>

                                <button
                                    type="button"
                                    class="icon-button delete-button"
                                    title="Delete Package">
                                    🗑
                                </button>

                            </div>
                        </td>

                    </tr>

                </tbody>

            </table>

        </div>

    </div>

</asp:Content>
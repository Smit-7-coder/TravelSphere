<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="EPackages.aspx.cs"
    Inherits="TravelSphere.Admin.EPackages"
    MasterPageFile="~/Admin/Admin.Master" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/Admincss/EPackage.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="add-package-page">

        <!-- =========================================
             PAGE HEADER
        ========================================== -->

        <div class="page-header">

            <div>

                <h1>Edit Package</h1>

                <p>
                    Update the details of this travel package.
                </p>

            </div>

            <div class="header-badge">
                Edit Package
            </div>

        </div>


        <!-- =========================================
             VALIDATION SUMMARY
        ========================================== -->

        <asp:ValidationSummary
            ID="vsPackage"
            runat="server"
            ValidationGroup="PackageValidation"
            CssClass="validation-summary"
            HeaderText="Please correct the following:"
            DisplayMode="BulletList" />


        <!-- =========================================
             MAIN FORM
        ========================================== -->

        <div class="package-form">


            <!-- =========================================
                 BASIC INFORMATION
            ========================================== -->

            <div class="form-section">

                <div class="section-title">

                    <h2>Basic Information</h2>

                    <span>Update package details</span>

                </div>


                <div class="form-grid">


                    <!-- Package Name -->

                    <div class="form-group full-width">

                        <asp:Label
                            ID="lblPackageName"
                            runat="server"
                            Text="Package Name *"
                            AssociatedControlID="txtPackageName"
                            CssClass="form-label" />

                        <asp:TextBox
                            ID="txtPackageName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter package name" />

                        <asp:RequiredFieldValidator
                            ID="rfvPackageName"
                            runat="server"
                            ControlToValidate="txtPackageName"
                            ErrorMessage="Package name is required."
                            Text="Package name is required."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>


                    <!-- Location -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblLocation"
                            runat="server"
                            Text="Location *"
                            AssociatedControlID="ddlLocation"
                            CssClass="form-label" />

                        <asp:DropDownList
                            ID="ddlLocation"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem
                                Text="--- Select Location ---"
                                Value="" />

                            <asp:ListItem
                                Text="Ladakh, Jammu &amp; Kashmir"
                                Value="Ladakh" />

                            <asp:ListItem
                                Text="Manali, Himachal Pradesh"
                                Value="Manali" />

                            <asp:ListItem
                                Text="Goa"
                                Value="Goa" />

                            <asp:ListItem
                                Text="Kerala"
                                Value="Kerala" />

                            <asp:ListItem
                                Text="Varanasi, Uttar Pradesh"
                                Value="Varanasi" />

                            <asp:ListItem
                                Text="Agra, Uttar Pradesh"
                                Value="Agra" />

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="rfvLocation"
                            runat="server"
                            ControlToValidate="ddlLocation"
                            InitialValue=""
                            ErrorMessage="Please select a location."
                            Text="Please select a location."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>


                    <!-- Duration -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblDuration"
                            runat="server"
                            Text="Duration (Days) *"
                            AssociatedControlID="txtDuration"
                            CssClass="form-label" />

                        <asp:TextBox
                            ID="txtDuration"
                            runat="server"
                            TextMode="Number"
                            CssClass="form-control"
                            placeholder="Example: 5" />

                        <asp:RequiredFieldValidator
                            ID="rfvDuration"
                            runat="server"
                            ControlToValidate="txtDuration"
                            ErrorMessage="Duration is required."
                            Text="Duration is required."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                        <asp:RangeValidator
                            ID="rvDuration"
                            runat="server"
                            ControlToValidate="txtDuration"
                            Type="Integer"
                            MinimumValue="1"
                            MaximumValue="60"
                            ErrorMessage="Duration must be between 1 and 60 days."
                            Text="Enter 1-60 days."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>


                    <!-- Price -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblPrice"
                            runat="server"
                            Text="Price (₹) *"
                            AssociatedControlID="txtPrice"
                            CssClass="form-label" />

                        <asp:TextBox
                            ID="txtPrice"
                            runat="server"
                            TextMode="Number"
                            CssClass="form-control"
                            placeholder="Example: 70000" />

                        <asp:RequiredFieldValidator
                            ID="rfvPrice"
                            runat="server"
                            ControlToValidate="txtPrice"
                            ErrorMessage="Package price is required."
                            Text="Price is required."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                        <asp:RangeValidator
                            ID="rvPrice"
                            runat="server"
                            ControlToValidate="txtPrice"
                            Type="Double"
                            MinimumValue="1"
                            MaximumValue="10000000"
                            ErrorMessage="Enter a valid package price."
                            Text="Enter a valid price."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>


                    <!-- Child Price -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblChildPrice"
                            runat="server"
                            Text="Child Price (₹) *"
                            AssociatedControlID="txtChildPrice"
                            CssClass="form-label" />

                        <asp:TextBox
                            ID="txtChildPrice"
                            runat="server"
                            TextMode="Number"
                            CssClass="form-control"
                            placeholder="Example: 35000" />

                        <asp:RequiredFieldValidator
                            ID="rfvChildPrice"
                            runat="server"
                            ControlToValidate="txtChildPrice"
                            ErrorMessage="Child price is required."
                            Text="Child price is required."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                        <asp:RangeValidator
                            ID="rvChildPrice"
                            runat="server"
                            ControlToValidate="txtChildPrice"
                            Type="Double"
                            MinimumValue="1"
                            MaximumValue="10000000"
                            ErrorMessage="Enter a valid child price."
                            Text="Enter a valid price."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>

                </div>

            </div>


            <!-- =========================================
                 PACKAGE DETAILS
            ========================================== -->

            <div class="form-section">

                <div class="section-title">

                    <h2>Package Details</h2>

                    <span>Update description and season</span>

                </div>


                <div class="form-grid">


                    <!-- Description -->

                    <div class="form-group full-width">

                        <asp:Label
                            ID="lblDescription"
                            runat="server"
                            Text="Package Description *"
                            AssociatedControlID="txtDescription"
                            CssClass="form-label" />

                        <asp:TextBox
                            ID="txtDescription"
                            runat="server"
                            TextMode="MultiLine"
                            CssClass="form-control textarea-control"
                            placeholder="Update package description..." />

                        <asp:RequiredFieldValidator
                            ID="rfvDescription"
                            runat="server"
                            ControlToValidate="txtDescription"
                            ErrorMessage="Package description is required."
                            Text="Description is required."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>


                    <!-- Best Season -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblSeason"
                            runat="server"
                            Text="Best Season *"
                            AssociatedControlID="ddlSeason"
                            CssClass="form-label" />

                        <asp:DropDownList
                            ID="ddlSeason"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem
                                Text="--- Select Season ---"
                                Value="" />

                            <asp:ListItem
                                Text="Winter"
                                Value="Winter" />

                            <asp:ListItem
                                Text="Summer"
                                Value="Summer" />

                            <asp:ListItem
                                Text="Monsoon"
                                Value="Monsoon" />

                            <asp:ListItem
                                Text="Spring"
                                Value="Spring" />

                            <asp:ListItem
                                Text="Autumn"
                                Value="Autumn" />

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="rfvSeason"
                            runat="server"
                            ControlToValidate="ddlSeason"
                            InitialValue=""
                            ErrorMessage="Please select the best season."
                            Text="Please select a season."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>

                </div>

            </div>


            <!-- =========================================
                 ACCOMMODATION & MEALS
            ========================================== -->

            <div class="form-section">

                <div class="section-title">

                    <h2>Accommodation &amp; Meals</h2>

                    <span>Update hotel and meal information</span>

                </div>


                <div class="form-grid">


                    <!-- Hotel -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblHotel"
                            runat="server"
                            Text="Hotel Name *"
                            AssociatedControlID="txtHotelName"
                            CssClass="form-label" />

                        <asp:TextBox
                            ID="txtHotelName"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Enter hotel name" />

                        <asp:RequiredFieldValidator
                            ID="rfvHotel"
                            runat="server"
                            ControlToValidate="txtHotelName"
                            ErrorMessage="Hotel name is required."
                            Text="Hotel name is required."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>


                    <!-- Room -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblRoom"
                            runat="server"
                            Text="Room Type *"
                            AssociatedControlID="txtRoomType"
                            CssClass="form-label" />

                        <asp:TextBox
                            ID="txtRoomType"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Example: Deluxe Room" />

                        <asp:RequiredFieldValidator
                            ID="rfvRoom"
                            runat="server"
                            ControlToValidate="txtRoomType"
                            ErrorMessage="Room type is required."
                            Text="Room type is required."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>


                    <!-- Meals -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblMeals"
                            runat="server"
                            Text="Meals Included *"
                            AssociatedControlID="ddlMeals"
                            CssClass="form-label" />

                        <asp:DropDownList
                            ID="ddlMeals"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem
                                Text="--- Select Meals ---"
                                Value="" />

                            <asp:ListItem
                                Text="Breakfast"
                                Value="Breakfast" />

                            <asp:ListItem
                                Text="Breakfast + Dinner"
                                Value="BreakfastDinner" />

                            <asp:ListItem
                                Text="Breakfast + Lunch + Dinner"
                                Value="AllMeals" />

                            <asp:ListItem
                                Text="No Meals"
                                Value="NoMeals" />

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="rfvMeals"
                            runat="server"
                            ControlToValidate="ddlMeals"
                            InitialValue=""
                            ErrorMessage="Please select meals."
                            Text="Please select meals."
                            ValidationGroup="PackageValidation"
                            CssClass="field-error"
                            Display="Dynamic" />

                    </div>


                    <!-- Current / New Image -->

                    <div class="form-group">

                        <asp:Label
                            ID="lblImage"
                            runat="server"
                            Text="Package Image"
                            AssociatedControlID="fuPackageImage"
                            CssClass="form-label" />

                        <div class="file-upload-box">

                            <asp:FileUpload
                                ID="fuPackageImage"
                                runat="server"
                                CssClass="file-upload" />

                        </div>

                    </div>

                </div>

            </div>


            <!-- =========================================
                 ACTION BUTTONS
            ========================================== -->

            <div class="form-actions">

                <asp:Button
                    ID="btnCancel"
                    runat="server"
                    Text="Cancel"
                    CssClass="cancel-button"
                    CausesValidation="false" />

                <asp:Button
                    ID="btnUpdatePackage"
                    runat="server"
                    Text="Update Package"
                    CssClass="save-button"
                    CausesValidation="true"
                    ValidationGroup="PackageValidation" />

            </div>


        </div>

    </div>

</asp:Content>
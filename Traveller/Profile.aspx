<%@ Page Language="C#"
    MasterPageFile="~/Traveller/Traveller.Master"
    AutoEventWireup="true"
    CodeBehind="Profile.aspx.cs"
    Inherits="TravelSphere.Traveller.Profile" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../Assets/css/profile.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">


    <!-- ==========================================
         PROFILE PAGE
    =========================================== -->

    <div class="profile-page">


        <!-- ==========================================
             PAGE HEADER
        =========================================== -->

        <div class="profile-page-header">

            <div>

                <span class="page-label">
                    MY ACCOUNT
                </span>

                <h1>
                    My Profile
                </h1>

                <p>
                    Manage your personal information and
                    TravelSphere account.
                </p>

            </div>


            <div class="profile-header-badge">

                <span class="badge-dot">
                </span>

                Active Account

            </div>

        </div>



        <!-- ==========================================
             MAIN PROFILE GRID
        =========================================== -->

        <div class="profile-main-grid">


            <!-- ==========================================
                 PROFILE CARD
            =========================================== -->

            <div class="profile-overview-card">


                <!-- Decorative background -->

                <div class="profile-card-decoration decoration-one">
                </div>

                <div class="profile-card-decoration decoration-two">
                </div>


                <!-- Avatar -->

                <div class="profile-avatar-wrapper">

                    <div class="profile-avatar">

                        <asp:Label
                            ID="lblAvatar"
                            runat="server"
                            Text="U">
                        </asp:Label>

                    </div>


                    <div class="avatar-status">
                    </div>

                </div>


                <!-- User Name -->

                <h2 class="profile-name">

                    <asp:Label
                        ID="lblProfileName"
                        runat="server">
                    </asp:Label>

                </h2>


                <!-- Email -->

                <p class="profile-email">

                    <asp:Label
                        ID="lblProfileEmail"
                        runat="server">
                    </asp:Label>

                </p>


                <!-- Traveller Badge -->

                <div class="traveller-badge">

                    <span>
                        ✦
                    </span>

                    Traveller

                </div>


                <!-- Divider -->

                <div class="profile-divider">
                </div>


                <!-- Profile Information -->

                <div class="overview-info">


                    <div class="overview-row">

                        <span>
                            User ID
                        </span>

                        <strong>

                            #<asp:Label
                                ID="lblUserId"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>


                    <div class="overview-row">

                        <span>
                            Account Type
                        </span>

                        <strong>
                            Traveller
                        </strong>

                    </div>


                    <div class="overview-row">

                        <span>
                            Status
                        </span>

                        <strong class="active-text">
                            Active
                        </strong>

                    </div>


                </div>


            </div>



            <!-- ==========================================
                 PERSONAL INFORMATION
            =========================================== -->

            <div class="profile-form-card">


                <div class="card-top">


                    <div>

                        <span class="card-label">
                            PROFILE SETTINGS
                        </span>

                        <h2>
                            Personal Information
                        </h2>

                        <p>
                            Keep your account information
                            up to date.
                        </p>

                    </div>


                    <div class="card-icon">
                        ✎
                    </div>


                </div>


                <!-- ==========================================
                     FULL NAME
                =========================================== -->

                <div class="form-group">

                    <label
                        for="txtFullName">

                        Full Name

                    </label>


                    <div class="input-wrapper">

                        <span class="input-icon">
                            ◉
                        </span>


                        <asp:TextBox
                            ID="txtFullName"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="100">
                        </asp:TextBox>

                    </div>


                    <asp:RequiredFieldValidator
                        ID="rfvFullName"
                        runat="server"
                        ControlToValidate="txtFullName"
                        ErrorMessage="Full name is required."
                        CssClass="validation-error"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>

                </div>



                <!-- ==========================================
                     EMAIL
                =========================================== -->

                <div class="form-group">

                    <label
                        for="txtEmail">

                        Email Address

                    </label>


                    <div class="input-wrapper">

                        <span class="input-icon">
                            @
                        </span>


                        <asp:TextBox
                            ID="txtEmail"
                            runat="server"
                            CssClass="profile-input"
                            TextMode="Email"
                            MaxLength="150">
                        </asp:TextBox>

                    </div>


                    <asp:RequiredFieldValidator
                        ID="rfvEmail"
                        runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email address is required."
                        CssClass="validation-error"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>


                    <asp:RegularExpressionValidator
                        ID="revEmail"
                        runat="server"
                        ControlToValidate="txtEmail"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        ErrorMessage="Please enter a valid email address."
                        CssClass="validation-error"
                        Display="Dynamic">
                    </asp:RegularExpressionValidator>

                </div>



                <!-- ==========================================
                     PHONE
                =========================================== -->

                <div class="form-group">

                    <label
                        for="txtPhone">

                        Phone Number

                    </label>


                    <div class="input-wrapper">

                        <span class="input-icon">
                            ☎
                        </span>


                        <asp:TextBox
                            ID="txtPhone"
                            runat="server"
                            CssClass="profile-input"
                            MaxLength="10">
                        </asp:TextBox>

                    </div>


                    <asp:RequiredFieldValidator
                        ID="rfvPhone"
                        runat="server"
                        ControlToValidate="txtPhone"
                        ErrorMessage="Phone number is required."
                        CssClass="validation-error"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>


                    <asp:RegularExpressionValidator
                        ID="revPhone"
                        runat="server"
                        ControlToValidate="txtPhone"
                        ValidationExpression="^[0-9]{10}$"
                        ErrorMessage="Enter a valid 10-digit phone number."
                        CssClass="validation-error"
                        Display="Dynamic">
                    </asp:RegularExpressionValidator>

                </div>



                <!-- ==========================================
                     ACTION AREA
                =========================================== -->

                <div class="form-action">


                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="profile-message">
                    </asp:Label>


                    <asp:Button
                        ID="btnSaveProfile"
                        runat="server"
                        Text="Save Changes"
                        CssClass="save-button"
                        OnClick="btnSaveProfile_Click" />

                </div>


            </div>


        </div>



        <!-- ==========================================
             ACCOUNT INFORMATION
        =========================================== -->

        <div class="account-card">


            <div class="account-card-header">


                <div>

                    <span class="card-label">
                        ACCOUNT DETAILS
                    </span>

                    <h2>
                        Account Information
                    </h2>

                    <p>
                        Basic information associated with
                        your TravelSphere account.
                    </p>

                </div>


                <div class="account-icon">
                    ✓
                </div>


            </div>



            <!-- ==========================================
                 ACCOUNT DETAILS GRID
            =========================================== -->

            <div class="account-details-grid">


                <!-- USER ID -->

                <div class="account-detail">

                    <div class="detail-icon">
                        #
                    </div>

                    <div>

                        <span>
                            User ID
                        </span>

                        <strong>

                            #<asp:Label
                                ID="lblAccountUserId"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>

                </div>



                <!-- ACCOUNT TYPE -->

                <div class="account-detail">

                    <div class="detail-icon">
                        ◉
                    </div>

                    <div>

                        <span>
                            Account Type
                        </span>

                        <strong>
                            Traveller
                        </strong>

                    </div>

                </div>



                <!-- EMAIL -->

                <div class="account-detail">

                    <div class="detail-icon">
                        @
                    </div>

                    <div>

                        <span>
                            Email
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblAccountEmail"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>

                </div>



                <!-- STATUS -->

                <div class="account-detail">

                    <div class="detail-icon status-icon">
                        ✓
                    </div>

                    <div>

                        <span>
                            Account Status
                        </span>

                        <strong class="status-text">
                            Active
                        </strong>

                    </div>

                </div>


            </div>


        </div>



        <!-- ==========================================
             PROFILE TIP
        =========================================== -->

        <div class="profile-tip">


            <div class="tip-icon">
                i
            </div>


            <div>

                <strong>
                    Keep your information updated
                </strong>

                <p>
                    Your profile information helps TravelSphere
                    provide a smoother booking and travel experience.
                </p>

            </div>


        </div>


    </div>


</asp:Content>
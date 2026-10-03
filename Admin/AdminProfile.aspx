<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AdminProfile.aspx.cs"
    Inherits="TravelSphere.Admin.AdminProfile"
    MasterPageFile="~/Admin/Admin.Master" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link rel="stylesheet"
        href="../Assets/Admincss/AProfile.css" />

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="admin-profile-page">

        <!-- Profile Header -->
        <section class="profile-cover">

            <div class="profile-heading">
                <h1>My Profile</h1>

                <p>
                    Manage your admin account settings
                </p>
            </div>

        </section>


        <!-- Admin Information -->
        <section class="profile-main">

            <div class="admin-avatar">

                <img
                    src="../Assets/images/Admin.png"
                    alt="Admin Profile" />

            </div>


            <div class="admin-basic-info">

                <h2>Aaryan Bharvadiya</h2>

                <p>
                    <i class="bi bi-envelope"></i>
                    aaryan123@travelsphere.com
                </p>

                <p>
                    <i class="bi bi-geo-alt"></i>
                    Gujarat, India
                </p>

            </div>

        </section>


        <!-- Information Cards -->
        <section class="profile-cards">

            <!-- Personal Information -->
            <div class="profile-card">

                <h2>Personal Information</h2>

                <div class="card-line"></div>

                <div class="profile-detail">
                    <strong>Name</strong>
                    <span>Aaryan Bharvadiya</span>
                </div>

                <div class="profile-detail">
                    <strong>Email</strong>
                    <span>aaryan123@travelsphere.com</span>
                </div>

                <div class="profile-detail">
                    <strong>Phone</strong>
                    <span>+91 98765 43210</span>
                </div>

                <div class="profile-detail">
                    <strong>Address</strong>
                    <span>Gujarat, India</span>
                </div>

            </div>


            <!-- Company Details -->
            <div class="profile-card">

                <h2>Company Details</h2>

                <div class="card-line"></div>

                <div class="profile-detail">
                    <strong>Company Name</strong>
                    <span>TravelSphere</span>
                </div>

                <div class="profile-detail">
                    <strong>Role</strong>
                    <span>Administrator</span>
                </div>

                <div class="profile-detail">
                    <strong>Company Address</strong>
                    <span>Ahmedabad, Gujarat, India</span>
                </div>

                <div class="profile-detail">
                    <strong>Website</strong>
                    <span>www.travelsphere.com</span>
                </div>

            </div>

        </section>


        <!-- Edit Profile -->
        <div class="profile-action">

            <a href="../Admin/AEditProfile.aspx"
               class="edit-profile-btn">

                <i class="bi bi-pencil-square"></i>

                Edit Profile

            </a>

        </div>

    </div>

</asp:Content>